import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/services/task_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_provider_test.mocks.dart';

@GenerateMocks([TaskService])
void main() {
  late MockTaskService mockTaskService;
  late StreamController<List<Task>> tasksController;
  late TaskProvider provider;

  final taskPending = Task(
    id: '1',
    title: 'Tarefa Pendente',
    status: TaskStatus.pending,
    userId: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final taskInProgress = Task(
    id: '2',
    title: 'Tarefa Em Progresso',
    status: TaskStatus.inProgress,
    userId: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final taskCompleted = Task(
    id: '3',
    title: 'Tarefa Concluída',
    status: TaskStatus.completed,
    userId: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockTaskService = MockTaskService();
    tasksController = StreamController<List<Task>>.broadcast();

    when(
      mockTaskService.watchTasks(),
    ).thenAnswer((_) => tasksController.stream);

    provider = TaskProvider.withService(mockTaskService);
  });

  tearDown(() {
    tasksController.close();
    provider.dispose();
  });

  group('Estado inicial', () {
    test('deve iniciar com lista de tarefas vazia', () {
      expect(provider.allTasks, isEmpty);
    });

    test('deve iniciar com completedTasks vazio', () {
      expect(provider.completedTasks, isEmpty);
    });

    test('deve iniciar com inProgressTasks vazio', () {
      expect(provider.inProgressTasks, isEmpty);
    });

    test('deve iniciar com pendingTasks vazio', () {
      expect(provider.pendingTasks, isEmpty);
    });
  });

  group('watchAllTasks', () {
    test('deve atualizar allTasks ao receber tarefas do stream', () async {
      provider.watchAllTasks();

      tasksController.add([taskPending, taskInProgress, taskCompleted]);
      await Future.delayed(Duration.zero);

      expect(provider.allTasks.length, equals(3));
    });

    test('deve retornar lista imutável em allTasks', () {
      expect(provider.allTasks, isA<List<Task>>());
      expect(
        () => (provider.allTasks).add(taskPending),
        throwsUnsupportedError,
      );
    });

    test('deve filtrar corretamente pendingTasks', () async {
      provider.watchAllTasks();

      tasksController.add([taskPending, taskInProgress, taskCompleted]);
      await Future.delayed(Duration.zero);

      expect(provider.pendingTasks.length, equals(1));
      expect(provider.pendingTasks.first.id, equals('1'));
    });

    test('deve filtrar corretamente inProgressTasks', () async {
      provider.watchAllTasks();

      tasksController.add([taskPending, taskInProgress, taskCompleted]);
      await Future.delayed(Duration.zero);

      expect(provider.inProgressTasks.length, equals(1));
      expect(provider.inProgressTasks.first.id, equals('2'));
    });

    test('deve filtrar corretamente completedTasks', () async {
      provider.watchAllTasks();

      tasksController.add([taskPending, taskInProgress, taskCompleted]);
      await Future.delayed(Duration.zero);

      expect(provider.completedTasks.length, equals(1));
      expect(provider.completedTasks.first.id, equals('3'));
    });

    test('deve notificar listeners ao receber novas tarefas', () async {
      int notifyCount = 0;
      provider.addListener(() => notifyCount++);

      provider.watchAllTasks();

      tasksController.add([taskPending]);
      await Future.delayed(Duration.zero);

      tasksController.add([taskPending, taskInProgress]);
      await Future.delayed(Duration.zero);

      expect(notifyCount, equals(2));
    });

    test(
      'deve cancelar subscription anterior ao chamar watchAllTasks novamente',
      () async {
        provider.watchAllTasks();
        provider.watchAllTasks();

        verify(mockTaskService.watchTasks()).called(2);
      },
    );
  });

  group('addTask', () {
    test('deve chamar addTask no service', () async {
      when(mockTaskService.addTask(taskPending)).thenAnswer((_) async {});

      await provider.addTask(taskPending);

      verify(mockTaskService.addTask(taskPending)).called(1);
    });

    test('deve propagar exceção quando service falhar', () async {
      when(
        mockTaskService.addTask(taskPending),
      ).thenThrow(Exception('Erro ao adicionar'));

      expect(() => provider.addTask(taskPending), throwsException);
    });
  });

  group('deleteTask', () {
    test('deve chamar deleteTask no service com o id correto', () async {
      when(mockTaskService.deleteTask('1')).thenAnswer((_) async {});

      await provider.deleteTask('1');

      verify(mockTaskService.deleteTask('1')).called(1);
    });

    test('deve propagar exceção quando service falhar', () async {
      when(
        mockTaskService.deleteTask('1'),
      ).thenThrow(Exception('Erro ao deletar'));

      expect(() => provider.deleteTask('1'), throwsException);
    });
  });

  group('updateTask', () {
    test(
      'deve chamar updateTask no service com id e tarefa corretos',
      () async {
        when(
          mockTaskService.updateTask('1', taskPending),
        ).thenAnswer((_) async {});

        await provider.updateTask('1', taskPending);

        verify(mockTaskService.updateTask('1', taskPending)).called(1);
      },
    );

    test('deve propagar exceção quando service falhar', () async {
      when(
        mockTaskService.updateTask('1', taskPending),
      ).thenThrow(Exception('Erro ao atualizar'));

      expect(() => provider.updateTask('1', taskPending), throwsException);
    });
  });

  group('updateTaskStatus', () {
    test('deve atualizar status da tarefa corretamente', () async {
      provider.watchAllTasks();
      tasksController.add([taskPending]);
      await Future.delayed(Duration.zero);

      when(mockTaskService.updateTask(any, any)).thenAnswer((_) async {});

      await provider.updateTaskStatus('1', TaskStatus.inProgress);

      final captured = verify(
        mockTaskService.updateTask(captureAny, captureAny),
      ).captured;

      expect(captured[0], equals('1'));
      expect((captured[1] as Task).status, equals(TaskStatus.inProgress));
    });

    test('deve lançar exceção quando tarefa não for encontrada', () async {
      provider.watchAllTasks();
      tasksController.add([]);
      await Future.delayed(Duration.zero);

      expect(
        () => provider.updateTaskStatus('inexistente', TaskStatus.completed),
        throwsStateError,
      );
    });
  });

  group('startPendingTask', () {
    test('deve atualizar status da tarefa para inProgress', () async {
      provider.watchAllTasks();
      tasksController.add([taskPending]);
      await Future.delayed(Duration.zero);

      when(mockTaskService.updateTask(any, any)).thenAnswer((_) async {});

      await provider.startPendingTask('1');

      final captured = verify(
        mockTaskService.updateTask(captureAny, captureAny),
      ).captured;

      expect(captured[0], equals('1'));
      expect((captured[1] as Task).status, equals(TaskStatus.inProgress));
    });
  });
}
