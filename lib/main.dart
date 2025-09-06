import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'services/mock_service.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MockService>(create: (_) => MockService()),
      ],
      child: MaterialApp(
        title: 'English Learner',
        theme: AppTheme.light(),
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}