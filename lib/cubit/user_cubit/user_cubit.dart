import 'package:ashristore/const/const.dart';
import 'package:ashristore/core/api/models/price_model.dart';
import 'package:ashristore/core/cache/cache_helper.dart';
import 'package:ashristore/cubit/user_cubit/user_states.dart';
import 'package:ashristore/excel/excel.dart';
import 'package:ashristore/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

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
  // final ApiConsumer api;
  PriceModel? priceModel;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection(
    userCollection,
  );
  final user = FirebaseAuth.instance.currentUser;

  UserModel? userInfo = UserModel(
    name: CacheHelper().getData(key: userName) ?? "userName",
    email: CacheHelper().getData(key: userEmail) ?? "email@email.com",
    cart: CacheHelper().getList(userCart) ?? [],
  );

  List productList = CacheHelper().getListOfMap(productListCache);
  // List cart = CacheHelper().getListOfMap(cartListCache);
  List categories = [];

  int currentIndex = 0;

  double _totalPrice = CacheHelper().getData(key: totalPriceCache);

  double getTotal() {
    return _totalPrice;
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndex());
  }

  Future<void> initState() async {
    try {
      if (productList.isEmpty) {
        await loadProducts();
      }
      getUserInfo();
      showCart();
      totalPrice(CacheHelper().getListOfMap(cartListCache));
    } catch (e) {
      emit(ProductsFailed());
    }
  }

  Future<void> loadProducts() async {
    final data = await readFromGoogleSheet();

    CacheHelper().saveListOfMap(key: productListCache, value: data);
  }

  totalPrice(List cart) {
    double total = 0;
    for (int i = 0; i < cart.length; i++) {
      if (cart[i][pPrice] != null) {
        total += double.parse(cart[i][pPrice]) * cart[i][pCount];
      }
    }
    CacheHelper().saveData(key: totalPriceCache, value: total);
    _totalPrice = total;
    print(CacheHelper().getData(key: totalPriceCache));
  }

  Future<void> adduser(
    String fName,
    String lName,
    String password,
    String email,
    String id,
    DateTime createdAt,
    List<Map<dynamic, dynamic>> cart,
  ) async {
    users
        .doc(email.trim().toLowerCase())
        .set({
          userName: "${fName.trim()} ${lName.trim()}",
          userEmail: email.trim().toLowerCase(),
          userPassword: password.trim(),
          userId: id,
          userCreatedAt: createdAt,
          userCart: cart,
        })
        .then(
          (value) => print(
            "----------------------------User Added-------------------------------------",
          ),
        )
        .catchError((error) => print("Error Occured $error"));
  }

  Future<void> updateUserCart(
    int productId,
    String email,
    List<dynamic> cart,
  ) async {
    List<dynamic> newCart = cart;
    newCart.add(productId);
    await users
        .doc(email)
        .set({userCart: newCart}, SetOptions(merge: true))
        .then((onValue) => print("cart updated"))
        .catchError(
          (onError) => print(
            "---------------------------$onError-------------------------------",
          ),
        );
    CacheHelper().saveList(key: userCart, value: newCart);
    showCart();
    totalPrice(CacheHelper().getListOfMap(cartListCache));
    CacheHelper().saveData(key: totalPriceCache, value: _totalPrice);
  }

  Future<void> getUserInfo() async {
    try {
      if (user != null) {
        DocumentSnapshot doc =
            await FirebaseFirestore.instance
                .collection(userCollection)
                .doc(user!.email!)
                .get();
        final data = doc.data() as Map<String, dynamic>;
        CacheHelper().saveData(key: userName, value: data[userName]);
        CacheHelper().saveData(key: userEmail, value: data[userEmail]);
        CacheHelper().saveList(key: userCart, value: data[userCart]);
      }
    } catch (e) {
      print("❌❌❌❌❌❌ $e");
    }
  }

  void showCart() {
    // تأجيل بسيط لو محتاج تتأكد من تحميل البيانات
    Future.delayed(const Duration(seconds: 1));

    // قراءة سلة المستخدم
    List carts = CacheHelper().getList(userCart);

    // قائمة المنتجات والعدّادات
    List<Map<String, dynamic>> products = [];
    Map<int, int> counts = {};

    // 🧮 1️⃣ حساب عدد مرات التكرار
    for (var num in carts) {
      counts[num] = (counts[num] ?? 0) + 1;
    }

    // 🔢 2️⃣ تحويل النتائج إلى قائمة فيها ID و count
    List<Map<String, dynamic>> result =
        counts.entries.map((e) => {"ID": e.key, "count": e.value}).toList();

    // 🧩 3️⃣ تأمين productList قبل الاستخدام
    if (productList.isEmpty) {
      print("⚠️ productList فارغة، لن يتم عرض السلة.");
      return;
    }

    // 🛒 4️⃣ ربط كل ID بالمنتج الصحيح
    for (var item in result) {
      final foundProduct = productList.firstWhere(
        (p) {
          try {
            return int.parse(p['ID'].toString()) == item['ID'];
          } catch (e) {
            print("❌ خطأ أثناء مقارنة ID: $e");
            return false;
          }
        },
        orElse: () => <String, dynamic>{}, // نوع متوافق تمامًا
      );

      if (foundProduct.isNotEmpty) {
        final product = Map<String, dynamic>.from(foundProduct);
        product['count'] = item['count'];
        products.add(product);
      } else {
        print("⚠️ المنتج ذو ID ${item['ID']} غير موجود في القائمة.");
      }
    }

    // 💾 5️⃣ حفظ النتيجة في الكاش
    CacheHelper().saveListOfMap(key: cartListCache, value: products);
  }

  loadOneCategory(String catName) async {
    try {
      emit(LoadCatLoading());
      // await Future.delayed(Duration(milliseconds: 500));
      List<Map<String, dynamic>> proList = [];
      for (int i = 0; i < productList.length; i++) {
        if (productList[i][pCat] == catName) {
          proList.add(productList[i]);
        }
      }
      emit(LoadCatSuccess(list: proList));
    } on Exception catch (e) {
      emit(LoadCatFailed(errMessage: e.toString()));
    }
  }

  setState() {
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
      adduser(
        fName.text,
        lName.text,
        password.text,
        email.text,
        credential.user!.uid,
        credential.user!.metadata.creationTime!,
        [],
      );
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
          await FirebaseAuth.instance.signInWithEmailAndPassword(
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