import 'dart:convert';

import 'package:ashristore/core/api/api_consumer.dart';
import 'package:ashristore/core/api/end_points.dart';
import 'package:ashristore/core/api/models/price_model.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit(this.api) : super(UserInitialState());

  final emailpattern = RegExp(
    r"\^\^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?\^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+",
  );

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController emailL = TextEditingController();
  TextEditingController passwordL = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  final ApiConsumer api;
  PriceModel? priceModel;

  Future<void> getGoldPrice() async {
    try {
      emit(LoadPrice());
      final response = await api.get(EndPoints.goldEgp);
      final firstDecode = jsonDecode(response);
      priceModel = PriceModel.fromJson(firstDecode);
      emit(GetPriceSuccess(priceModel: priceModel!));
    } on DioException catch (e) {
      print(e.error);
    }
  }

  setState() {
    print(fName.text);
    emit(SetState());
  }

  signUp() async {
    try {
      emit(UserSignupLoading());
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
      credential.user!.sendEmailVerification();
      emit(UserSignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(UserSignupFailed(message: e.code));
      } else if (e.code == 'email-already-in-use') {
        emit(
          UserSignupFailed(
            message: "The account already exists for that email.",
          ),
        );
      } else {
        emit(UserSignupFailed(message: e.code));
      }
    } catch (e) {
      emit(UserSignupFailed(message: e.toString()));
    }
  }

  login() async {
    try {
      if (emailL.text.isNotEmpty && passwordL.text.isNotEmpty) {
        emit(UserLoginLoading());
        if (emailL.text.trim() == "admin" &&
            passwordL.text.trim() == "admin2468") {
          emit(AdminLoginSuccess());
          clearLogin();
        } else {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: emailL.text.trim(),
                password: passwordL.text.trim(),
              );
          emit(UserLoginSuccess());
          clearLogin();
        }
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many login attempts. Please try later.';
          break;
        default:
          message = 'Email or password is incorrect.';
      }
      emit(UserLoginFailed(message: message));
    } catch (e) {
      emit(UserLoginFailed(message: e.toString()));
    }
  }

  clearSignup() {
    fName.clear();
    lName.clear();
    password.clear();
    email.clear();
    confirmPassword.clear();
  }

  clearLogin() {
    passwordL.clear();
    emailL.clear();
  }
}















// Future<UserCredential> signInWithGoogle() async {
  //   // 1. Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // لو المستخدم لغى تسجيل الدخول
  //   if (googleUser == null) {
  //     throw Exception("Sign in aborted by user");
  //   }

  //   // 2. Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   // 3. Create a new credential
  //   final OAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   // 4. Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }