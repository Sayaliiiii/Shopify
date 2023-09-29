abstract class LoginState  {
}
class LogInInitial extends LoginState{}
class EmailErrorState extends LoginState{
  String error;
  EmailErrorState({required this.error});
}
class PasswordErrorState extends LoginState{
  String error;
  PasswordErrorState({required this.error});
}

class LoginValidState extends LoginState{}
class LoginSuccessfullState extends LoginState{}
class LoginFailureState extends LoginState{
  String error;
  LoginFailureState({required this.error});
}