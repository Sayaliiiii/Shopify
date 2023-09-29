abstract class LoginEvent {}

class OnChangedEvent extends LoginEvent {

  String email;
  String password;


  OnChangedEvent(
      {
      required this.email,
      required this.password,
     });
}

class UserLoginEvent extends LoginEvent {
  String email;
  String password;

  UserLoginEvent({required this.email, required this.password});
}

