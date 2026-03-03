import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_hackathon_mobile/models/authentication_model.dart';
import 'package:frontend_hackathon_mobile/models/user_model.dart';
import 'package:frontend_hackathon_mobile/providers/authentication_provider.dart';
import 'package:frontend_hackathon_mobile/services/authentication_service.dart';
import 'package:frontend_hackathon_mobile/services/exceptions/authentication_exception.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_provider_test.mocks.dart';

@GenerateMocks([AuthenticationService])
void main() {
  late MockAuthenticationService mockAuthService;
  late StreamController<UserModel?> authStateController;
  late AuthenticationProvider provider;

  setUp(() {
    mockAuthService = MockAuthenticationService();
    authStateController = StreamController<UserModel?>.broadcast();

    when(
      mockAuthService.authStateChanges,
    ).thenAnswer((_) => authStateController.stream);

    provider = AuthenticationProvider.withService(mockAuthService);
  });

  tearDown(() {
    authStateController.close();
    provider.dispose();
  });

  group('Estado inicial', () {
    test('deve iniciar com usuário nulo', () {
      expect(provider.user, isNull);
    });

    test('deve iniciar com isLoggedIn false', () {
      expect(provider.isLoggedIn, isFalse);
    });

    test('deve iniciar com isLoading false', () {
      expect(provider.isLoading, isFalse);
    });

    test('deve iniciar sem mensagem de erro', () {
      expect(provider.errorMessage, isNull);
    });
  });

  group('authStateChanges observer', () {
    test(
      'deve atualizar usuário e isLoggedIn ao receber usuário válido',
      () async {
        final user = UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');

        authStateController.add(user);
        await Future.delayed(Duration.zero);

        expect(provider.user, equals(user));
        expect(provider.isLoggedIn, isTrue);
      },
    );

    test('deve limpar usuário e isLoggedIn ao receber null', () async {
      final user = UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');

      authStateController.add(user);
      await Future.delayed(Duration.zero);

      authStateController.add(null);
      await Future.delayed(Duration.zero);

      expect(provider.user, isNull);
      expect(provider.isLoggedIn, isFalse);
    });
  });

  group('handleSignupUser', () {
    final signupRequest = SignupRequest(
      name: 'Dan',
      email: 'dan@email.com',
      password: '123456',
    );

    test('deve retornar true quando signup for bem-sucedido', () async {
      when(mockAuthService.signupUser(signupRequest)).thenAnswer((_) async {
        return UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');
      });

      final result = await provider.handleSignupUser(signupRequest);

      expect(result, isTrue);
      expect(provider.errorMessage, isNull);
    });

    test(
      'deve retornar false e setar erro quando lançar SignUpException',
      () async {
        when(
          mockAuthService.signupUser(signupRequest),
        ).thenThrow(SignUpException('E-mail já cadastrado'));

        final result = await provider.handleSignupUser(signupRequest);

        expect(result, isFalse);
        expect(provider.errorMessage, equals('E-mail já cadastrado'));
      },
    );

    test(
      'deve setar isLoading como true durante execução e false ao finalizar',
      () async {
        final loadingStates = <bool>[];

        when(mockAuthService.signupUser(signupRequest)).thenAnswer((_) async {
          return UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');
        });

        provider.addListener(() {
          loadingStates.add(provider.isLoading);
        });

        await provider.handleSignupUser(signupRequest);

        expect(loadingStates, containsAllInOrder([true, false]));
        expect(provider.isLoading, isFalse);
      },
    );

    test('deve limpar erro antes de executar novo signup', () async {
      when(
        mockAuthService.signupUser(signupRequest),
      ).thenThrow(SignUpException('Erro anterior'));
      await provider.handleSignupUser(signupRequest);

      when(mockAuthService.signupUser(signupRequest)).thenAnswer((_) async {
        return UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');
      });
      await provider.handleSignupUser(signupRequest);

      expect(provider.errorMessage, isNull);
    });
  });

  group('handleLoginUser', () {
    final loginRequest = LoginRequest(
      email: 'dan@email.com',
      password: '123456',
    );

    test('deve retornar true quando login for bem-sucedido', () async {
      when(mockAuthService.loginUser(loginRequest)).thenAnswer((_) async {
        return UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');
      });

      final result = await provider.handleLoginUser(loginRequest);

      expect(result, isTrue);
      expect(provider.errorMessage, isNull);
    });

    test(
      'deve retornar false e setar erro quando lançar LoginException',
      () async {
        when(
          mockAuthService.loginUser(loginRequest),
        ).thenThrow(LoginException('Credenciais inválidas'));

        final result = await provider.handleLoginUser(loginRequest);

        expect(result, isFalse);
        expect(provider.errorMessage, equals('Credenciais inválidas'));
      },
    );

    test(
      'deve setar isLoading como true durante execução e false ao finalizar',
      () async {
        final loadingStates = <bool>[];

        when(mockAuthService.loginUser(loginRequest)).thenAnswer((_) async {
          return UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');
        });

        provider.addListener(() {
          loadingStates.add(provider.isLoading);
        });

        await provider.handleLoginUser(loginRequest);

        expect(loadingStates, containsAllInOrder([true, false]));
        expect(provider.isLoading, isFalse);
      },
    );

    test('deve garantir isLoading false mesmo quando lançar exceção', () async {
      when(
        mockAuthService.loginUser(loginRequest),
      ).thenThrow(LoginException('Erro'));

      await provider.handleLoginUser(loginRequest);

      expect(provider.isLoading, isFalse);
    });

    test('deve limpar erro antes de executar novo login', () async {
      when(
        mockAuthService.loginUser(loginRequest),
      ).thenThrow(LoginException('Erro anterior'));
      await provider.handleLoginUser(loginRequest);

      when(mockAuthService.loginUser(loginRequest)).thenAnswer((_) async {
        return UserModel(uid: '1', name: 'Dan', email: 'dan@email.com');
      });
      await provider.handleLoginUser(loginRequest);

      expect(provider.errorMessage, isNull);
    });
  });

  group('handleLogoutUser', () {
    test('deve chamar logout no service', () {
      provider.handleLogoutUser();

      verify(mockAuthService.logout()).called(1);
    });

    test('deve limpar mensagem de erro ao fazer logout', () async {
      final loginRequest = LoginRequest(
        email: 'dan@email.com',
        password: '123456',
      );

      when(
        mockAuthService.loginUser(loginRequest),
      ).thenThrow(LoginException('Erro'));
      await provider.handleLoginUser(loginRequest);

      provider.handleLogoutUser();

      expect(provider.errorMessage, isNull);
    });
  });
}
