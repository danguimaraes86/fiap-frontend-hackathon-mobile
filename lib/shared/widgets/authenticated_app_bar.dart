import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/custom_theme.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';
import 'package:frontend_hackathon_mobile/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class AuthenticatedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AuthenticatedAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthenticationProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final lightTheme = CustomTheme(
      Theme.of(context).textTheme,
    ).light().colorScheme;

    void logoutUser() async {
      authProvider.handleLogoutUser();
      if (context.mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.home, (route) => false);
      }
    }

    return AppBar(
      backgroundColor: colorScheme.primaryContainer,
      title: Image.asset("assets/logos/logo_desktop.png", height: 40),
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: lightTheme.surface,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(Routes.userPreferencesForm),
          icon: const Icon(Icons.tune),
          color: lightTheme.surface,
          tooltip: 'Preferências',
        ),
        IconButton(
          onPressed: logoutUser,
          icon: const Icon(Icons.logout),
          color: lightTheme.surface,
          tooltip: 'Sair',
        ),
      ],
    );
  }
}
