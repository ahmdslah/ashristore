import 'package:ashristore/activation_code.dart';
import 'package:ashristore/core/cache/cache_helper.dart';
import 'package:ashristore/create_password.dart';
import 'package:ashristore/cubit/user_cubit/user_cubit.dart';
import 'package:ashristore/password.dart';
import 'package:ashristore/screens/admin_home.dart';
import 'package:ashristore/screens/home_screen.dart';
import 'package:ashristore/screens/login.dart';
import 'package:ashristore/screens/settings.dart';
import 'package:ashristore/screens/sign_up.dart';
import 'package:ashristore/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => UserCubit()..initState())],
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
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xffF2F3F2),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        routes: {
          "login": (context) => Login(),
          'password': (context) => Password(),
          'active': (context) => ActivationCode(),
          'create': (context) => CreatePassword(),
          'home': (context) => HomeScreen(),
          'signup': (context) => SignUp(),
          'adminHome': (context) => AdminHome(),
          'homeScreen': (context) => HomeScreen(),
          'settings': (context) => Settings(),
        },

        home: VideoSplashScreen(),
      ),
    );
  }
}
