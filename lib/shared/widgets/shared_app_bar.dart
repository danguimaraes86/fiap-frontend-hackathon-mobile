import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/custom_theme.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<IconButton>? actions;

  const SharedAppBar({super.key, required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final lightTheme = CustomTheme(
      Theme.of(context).textTheme,
    ).light().colorScheme;

    return AppBar(
      backgroundColor: lightTheme.primaryContainer,
      foregroundColor: lightTheme.surface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }
}
