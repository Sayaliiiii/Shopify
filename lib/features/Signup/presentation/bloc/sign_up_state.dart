abstract class SignUpState  {
}
class SignUpInitial extends SignUpState{}
class EmailErrorState extends SignUpState{
  String error;
  EmailErrorState({required this.error});
}
class MobileErrorState extends SignUpState{
  String error;
  MobileErrorState({required this.error});
}
class AddressErrorState extends SignUpState{
  String error;
  AddressErrorState({required this.error});
}
class PasswordErrorState extends SignUpState{
  String error;
  PasswordErrorState({required this.error});
}
class ConfirmPasswordErrorState extends SignUpState{
  String error;
  ConfirmPasswordErrorState({required this.error});
}
class UsernameErrorState extends SignUpState{
  String error;
  UsernameErrorState({required this.error});
}

class SignUpValidState extends SignUpState{}

class SignUpSuccessfullState extends SignUpState{}
class SignUpFailureState extends SignUpState{
  String error;
  SignUpFailureState({required this.error});
}