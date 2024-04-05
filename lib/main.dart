import 'package:alindor_tech/controllers/record_controller.dart';
import 'package:alindor_tech/controllers/play_controller.dart';
import 'package:alindor_tech/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => RecordController()),
        ChangeNotifierProvider(create: (_) => AudioPlayController()),
        ChangeNotifierProvider(create: (_) => ChangeNotifier())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
