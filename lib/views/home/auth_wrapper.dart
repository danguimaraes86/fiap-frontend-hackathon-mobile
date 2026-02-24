import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';
import 'package:frontend_hackathon_mobile/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listenToAuthState();
  }

  void _listenToAuthState() {
    final authProvider = context.watch<AuthenticationProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (authProvider.isLoggedIn) {
        Navigator.of(context).pushReplacementNamed(Routes.dashboard);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
