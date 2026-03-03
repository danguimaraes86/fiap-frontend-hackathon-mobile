import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_hackathon_mobile/models/user_preferences_model.dart';
import 'package:frontend_hackathon_mobile/providers/user_preferences_provider.dart';
import 'package:frontend_hackathon_mobile/services/user_preferences_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_preferences_provider_test.mocks.dart';

@GenerateMocks([UserPreferencesService])
void main() {
  late MockUserPreferencesService mockService;
  late UserPreferencesProvider provider;

  final defaultPreferences = UserPreferencesModel.defaultPreferences;

  final preferencesWithId = UserPreferencesModel(
    id: 'pref-1',
    theme: ThemeType.light,
    focusMode: false,
    showCompletedTasks: true,
    showPendingTasks: true,
  );

  setUp(() {
    mockService = MockUserPreferencesService();
    provider = UserPreferencesProvider.withService(mockService);
  });

  tearDown(() {
    provider.dispose();
  });

  group('Estado inicial', () {
    test('deve iniciar com preferências padrão', () {
      expect(provider.preferences, equals(defaultPreferences));
    });

    test('deve iniciar com isLoading false', () {
      expect(provider.isLoading, isFalse);
    });

    test('deve iniciar sem erro', () {
      expect(provider.error, isNull);
    });

    test(
      'deve iniciar com themeMode correto baseado nas preferências padrão',
      () {
        final expectedMode = switch (defaultPreferences.theme) {
          ThemeType.dark => ThemeMode.dark,
          ThemeType.light => ThemeMode.light,
          ThemeType.system => ThemeMode.system,
        };
        expect(provider.themeMode, equals(expectedMode));
      },
    );
  });

  group('themeMode', () {
    test('deve retornar ThemeMode.dark quando tema for dark', () async {
      final darkPrefs = preferencesWithId.copyWith(theme: ThemeType.dark);
      when(mockService.getPreferences()).thenAnswer((_) async => darkPrefs);

      await provider.init();

      expect(provider.themeMode, equals(ThemeMode.dark));
    });

    test('deve retornar ThemeMode.light quando tema for light', () async {
      final lightPrefs = preferencesWithId.copyWith(theme: ThemeType.light);
      when(mockService.getPreferences()).thenAnswer((_) async => lightPrefs);

      await provider.init();

      expect(provider.themeMode, equals(ThemeMode.light));
    });

    test('deve retornar ThemeMode.system quando tema for system', () async {
      final systemPrefs = preferencesWithId.copyWith(theme: ThemeType.system);
      when(mockService.getPreferences()).thenAnswer((_) async => systemPrefs);

      await provider.init();

      expect(provider.themeMode, equals(ThemeMode.system));
    });
  });

  group('init', () {
    test(
      'deve carregar preferências existentes quando id não for nulo',
      () async {
        when(
          mockService.getPreferences(),
        ).thenAnswer((_) async => preferencesWithId);

        await provider.init();

        expect(provider.preferences, equals(preferencesWithId));
        expect(provider.error, isNull);
        verifyNever(mockService.createPreferences());
      },
    );

    test('deve criar preferências quando id for nulo', () async {
      final prefsWithoutId = UserPreferencesModel(
        id: null,
        theme: ThemeType.light,
        focusMode: false,
        showCompletedTasks: true,
        showPendingTasks: true,
      );

      when(
        mockService.getPreferences(),
      ).thenAnswer((_) async => prefsWithoutId);
      when(
        mockService.createPreferences(),
      ).thenAnswer((_) async => preferencesWithId);

      await provider.init();

      expect(provider.preferences, equals(preferencesWithId));
      verify(mockService.createPreferences()).called(1);
    });

    test(
      'deve setar isLoading true durante execução e false ao finalizar',
      () async {
        final loadingStates = <bool>[];

        when(
          mockService.getPreferences(),
        ).thenAnswer((_) async => preferencesWithId);

        provider.addListener(() => loadingStates.add(provider.isLoading));

        await provider.init();

        expect(loadingStates, containsAllInOrder([true, false]));
        expect(provider.isLoading, isFalse);
      },
    );

    test(
      'deve setar erro e garantir isLoading false quando service falhar',
      () async {
        when(
          mockService.getPreferences(),
        ).thenThrow(Exception('Falha ao buscar preferências'));

        await provider.init();

        expect(provider.error, isNotNull);
        expect(provider.isLoading, isFalse);
      },
    );

    test('deve limpar erro anterior em caso de sucesso', () async {
      when(mockService.getPreferences()).thenThrow(Exception('Erro'));
      await provider.init();

      when(
        mockService.getPreferences(),
      ).thenAnswer((_) async => preferencesWithId);
      await provider.init();

      expect(provider.error, isNull);
    });
  });

  group('updatePreferences', () {
    test(
      'deve atualizar preferências locais após sucesso no service',
      () async {
        final updated = preferencesWithId.copyWith(focusMode: true);
        when(mockService.updatePreferences(updated)).thenAnswer((_) async {});

        await provider.updatePreferences(updated);

        expect(provider.preferences, equals(updated));
        expect(provider.error, isNull);
      },
    );

    test(
      'deve setar isLoading true durante execução e false ao finalizar',
      () async {
        final loadingStates = <bool>[];
        when(mockService.updatePreferences(any)).thenAnswer((_) async {});

        provider.addListener(() => loadingStates.add(provider.isLoading));

        await provider.updatePreferences(preferencesWithId);

        expect(loadingStates, containsAllInOrder([true, false]));
        expect(provider.isLoading, isFalse);
      },
    );

    test(
      'deve setar erro e garantir isLoading false quando service falhar',
      () async {
        when(
          mockService.updatePreferences(any),
        ).thenThrow(Exception('Falha ao atualizar'));

        await provider.updatePreferences(preferencesWithId);

        expect(provider.error, isNotNull);
        expect(provider.isLoading, isFalse);
      },
    );
  });

  group('updateTheme', () {
    test('deve chamar updatePreferences com o novo tema', () async {
      when(mockService.updatePreferences(any)).thenAnswer((_) async {});

      await provider.updateTheme(ThemeType.dark);

      final captured = verify(
        mockService.updatePreferences(captureAny),
      ).captured;

      expect(
        (captured[0] as UserPreferencesModel).theme,
        equals(ThemeType.dark),
      );
    });
  });

  group('toggleFocusMode', () {
    test('deve inverter o valor de focusMode', () async {
      when(
        mockService.getPreferences(),
      ).thenAnswer((_) async => preferencesWithId.copyWith(focusMode: false));
      await provider.init();

      when(mockService.updatePreferences(any)).thenAnswer((_) async {});
      await provider.toggleFocusMode();

      expect(provider.preferences.focusMode, isTrue);
    });
  });

  group('toggleShowCompletedTasks', () {
    test('deve inverter o valor de showCompletedTasks', () async {
      when(mockService.getPreferences()).thenAnswer(
        (_) async => preferencesWithId.copyWith(showCompletedTasks: true),
      );
      await provider.init();

      when(mockService.updatePreferences(any)).thenAnswer((_) async {});
      await provider.toggleShowCompletedTasks();

      expect(provider.preferences.showCompletedTasks, isFalse);
    });
  });

  group('toggleShowPendingTasks', () {
    test('deve inverter o valor de showPendingTasks', () async {
      when(mockService.getPreferences()).thenAnswer(
        (_) async => preferencesWithId.copyWith(showPendingTasks: true),
      );
      await provider.init();

      when(mockService.updatePreferences(any)).thenAnswer((_) async {});
      await provider.toggleShowPendingTasks();

      expect(provider.preferences.showPendingTasks, isFalse);
    });
  });
}
