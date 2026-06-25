import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/route_manager.dart';
import 'core/providers/questionnaire_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuestionnaireProvider(),
      child: createMaterialApp(),
    ),
  );
}
