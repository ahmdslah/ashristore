import 'package:ashristore/activation_code.dart';
import 'package:ashristore/create_password.dart';
import 'package:ashristore/home.dart';
import 'package:ashristore/password.dart';
import 'package:ashristore/signup.dart';
import 'package:ashristore/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('ar'), // Arabic
        Locale('en'), // English
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ar'),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routes: {
        "login": (context) => Signup(),
        "phone": (context) => Signup(),
        'password': (context) => Password(),
        'active': (context) => ActivationCode(),
        'create': (context) => CreatePassword(),
        'home': (context) => Home(),
      },
      home: VideoSplashScreen(),
    );
  }
}
