import 'package:ashristore/core/api/models/price_model.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

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
