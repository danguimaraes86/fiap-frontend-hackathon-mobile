import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/providers/user_preferences_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/authenticated_app_bar.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/floating_add_task_buttom.dart';
import 'package:frontend_hackathon_mobile/views/dashboard/widgets/dashboard_focus_mode.dart';
import 'package:frontend_hackathon_mobile/views/dashboard/widgets/dashboard_full_details.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().watchAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFocusMode = context
        .watch<UserPreferencesProvider>()
        .preferences
        .focusMode;

    return Scaffold(
      appBar: AuthenticatedAppBar(),
      body: isFocusMode ? FocusModeDashboard() : DetailedDashboardCard(),
      floatingActionButton: FloatingAddTaskButtom(),
    );
  }
}
