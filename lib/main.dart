import 'package:ashristore/activation_code.dart';
import 'package:ashristore/core/api/dio_consumer.dart';
import 'package:ashristore/create_password.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/home.dart';
import 'package:ashristore/password.dart';
import 'package:ashristore/screens/admin_home.dart';
import 'package:ashristore/screens/login.dart';
import 'package:ashristore/screens/sign_up.dart';
import 'package:ashristore/splash.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit(DioConsumer(dio: Dio()))),
      ],
      child: MaterialApp(
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
          "login": (context) => Login(),
          'password': (context) => Password(),
          'active': (context) => ActivationCode(),
          'create': (context) => CreatePassword(),
          'home': (context) => Home(),
          'signup': (context) => SignUp(),
          'adminHome': (context) => AdminHome(),
        },

        home: VideoSplashScreen(),
      ),
    );
  }
}
