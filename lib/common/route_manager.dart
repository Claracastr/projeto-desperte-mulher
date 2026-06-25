/*
Nome: CreateMaterialApp()
Descrição: Cria o objeto MaterialApp com as rotas e suas respectivas classes
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'package:flutter/material.dart';
import '../core/design_system.dart';
import '../features/about/about_page.dart';
import '../features/help/help_page.dart';
import '../features/history/history_page.dart';
import '../features/onboarding/identify_form_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/questionnaire/questionnaire_page.dart';
import '../features/results/result_page.dart';
import '../features/admin/admin_dashboard_page.dart';
import 'app_routes.dart';

Widget createMaterialApp() {
  return MaterialApp(
    title: 'Desperte Mulher',
    theme: DSTheme.lightTheme(),
    darkTheme: DSTheme.darkTheme(),
    themeMode: ThemeMode.system,
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (_) => const OnboardingPage(),
      AppRoutes.identify: (_) => const IdentifyFormPage(),
      AppRoutes.questionnaire: (_) => const QuestionnairePage(),
      AppRoutes.result: (_) => const ResultPage(),
      AppRoutes.history: (_) => const HistoryPage(),
      AppRoutes.help: (_) => const HelpPage(),
      AppRoutes.about: (_) => const AboutPage(),
      AppRoutes.admin: (_) => const AdminDashboardPage(),
    },
  );
}
