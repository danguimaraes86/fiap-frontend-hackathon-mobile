import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/views/auth/login_view.dart';
import 'package:frontend_hackathon_mobile/views/auth/signup_view.dart';
import 'package:frontend_hackathon_mobile/views/dashboard/dashboard_view.dart';
import 'package:frontend_hackathon_mobile/views/home/home_view.dart';
import 'package:frontend_hackathon_mobile/views/task_form/task_form_view.dart';
import 'package:frontend_hackathon_mobile/views/task_list/task_list_view.dart';

class Routes {
  static String home = '/home';
  static String signUp = '/signup';
  static String login = '/login';
  static String dashboard = '/dashboard';
  static String taskList = '/list';
  static String taskForm = '/task';

  Map<String, WidgetBuilder> get routes {
    return {
      Routes.home: (context) => const HomeView(),
      Routes.signUp: (context) => const SignupView(),
      Routes.login: (context) => const LoginView(),
      Routes.dashboard: (context) => const DashboardView(),
      Routes.taskList: (context) => const TaskListView(),
      Routes.taskForm: (context) => const TaskFormView(),
    };
  }
}
