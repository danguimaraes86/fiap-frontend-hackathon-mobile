import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/authentication_model.dart';
import 'package:frontend_hackathon_mobile/models/user_model.dart';
import 'package:frontend_hackathon_mobile/services/authentication_service.dart';
import 'package:frontend_hackathon_mobile/services/exceptions/authentication_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();
  StreamSubscription<UserModel?>? _authSubscription;

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthenticationProvider() {
    _initAuthObserver();
  }

  void _initAuthObserver() {
    _authSubscription = _authService.authStateChanges.listen((UserModel? user) {
      _user = user;
      _isLoggedIn = user != null;
      notifyListeners();
    });
  }

  Future<bool> handleSignupUser(SignupRequest request) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.signupUser(request);
      return true;
    } on SignUpException catch (e) {
      _setError(e.message);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> handleLoginUser(LoginRequest request) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.loginUser(request);
      return true;
    } on LoginException catch (e) {
      _setError(e.message);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void handleLogoutUser() {
    _clearError();
    _authService.logout();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
