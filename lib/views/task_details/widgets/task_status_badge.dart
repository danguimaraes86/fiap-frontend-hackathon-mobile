import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/custom_theme.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';

class StatusBadge extends StatelessWidget {
  final TaskStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final lightColorScheme = CustomTheme(
      Theme.of(context).textTheme,
    ).light().colorScheme;

    final colors = {
      'primary': (
        fg: lightColorScheme.primary,
        bg: lightColorScheme.onPrimaryContainer,
      ),
      'secondary': (
        fg: lightColorScheme.secondary,
        bg: lightColorScheme.onSecondaryContainer,
      ),
      'tertiary': (
        fg: lightColorScheme.tertiary,
        bg: lightColorScheme.onTertiaryContainer,
      ),
    };

    final chipColors = colors[status.color] ?? colors['primary']!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColors.bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColors.fg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 16, color: chipColors.fg),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: TextStyle(
              color: chipColors.fg,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
