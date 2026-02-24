import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';

class FloatingAddTaskButtom extends StatelessWidget {
  const FloatingAddTaskButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.taskForm);
      },
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
