import 'package:ashristore/core/api/models/price_model.dart';
import 'package:ashristore/models/user_model.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {
  // final List list;

  // UserInitialState({required this.list});
}

class ProductsLoading extends UserStates {}

class ProductsFailed extends UserStates {}

class ProductsSuccess extends UserStates {
  final List productsList;

  ProductsSuccess({required this.productsList});
}

class UserLoginSuccess extends UserStates {}

class AdminLoginSuccess extends UserStates {}

class UserLoginLoading extends UserStates {}

class UserLoginFailed extends UserStates {
  final String message;

  UserLoginFailed({required this.message});
}

class UserSignupSuccess extends UserStates {}

class UserSignupLoading extends UserStates {}

class UserSignupFailed extends UserStates {
  final String message;

  UserSignupFailed({required this.message});
}

class LoadPrice extends UserStates {}

class GetPriceSuccess extends UserStates {
  final PriceModel priceModel;

  GetPriceSuccess({required this.priceModel});
}

class GetPriceFailed extends UserStates {}

class SetState extends UserStates {}

class UserInfoLoading extends UserStates {}

class UserInfoFailed extends UserStates {
  final UserModel userInfo;

  UserInfoFailed({required this.userInfo});
}

class UserInfoSuccess extends UserStates {
  final UserModel userInfo;

  UserInfoSuccess({required this.userInfo});
}

class LoadCatLoading extends UserStates {}

class LoadCatSuccess extends UserStates {
  final List list;

  LoadCatSuccess({required this.list});
}

class LoadCatFailed extends UserStates {
  final String errMessage;

  LoadCatFailed({required this.errMessage});
}

class ChangeIndex extends UserStates {}
