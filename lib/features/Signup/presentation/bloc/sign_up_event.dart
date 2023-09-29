abstract class SignUpEvent {}

class OnChangedEvent extends SignUpEvent {
  String username;
  String email;
  String password;
  String phoneNo;
  String address;
  String confirmPassword;
  bool isGuest;

  OnChangedEvent(
      { required this.isGuest,
        required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.phoneNo,
      required this.address});
}

class UserRegisterEvent extends SignUpEvent {
  String email;
  String password;

  UserRegisterEvent({required this.email, required this.password});
}
class GuestOrderEvent extends SignUpEvent {
}
