import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopify/features/Signup/presentation/bloc/sign_up_event.dart';
import 'package:shopify/features/Signup/presentation/bloc/sign_up_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<OnChangedEvent>((event, emit) {
      if (event.username.isEmpty) {
        emit(UsernameErrorState(error: "Enter a Username"));
      } else if (event.email.isEmpty) {
        emit(EmailErrorState(error: "Enter Email Id"));
      } else if (!event.email.contains('@') ||
          !event.email.contains(".") ) {
        emit(EmailErrorState(error: "Enter valid email"));
      } else if (!RegExp(
          r'(^(?:[+0]9)?[0-9]{10,12}$)')
          .hasMatch(event.phoneNo)) {
        emit(MobileErrorState(
            error:
            "Enter a Valid Number"));
      }else if (event.phoneNo.length != 10) {
        emit(MobileErrorState(
            error:
            "Number should contain 10 digits"));
      } else if (event.address.isEmpty) {
        emit(AddressErrorState(
            error:
            "Enter Full Address"));
      } else if (event.password.isEmpty && !event.isGuest) {
        emit(PasswordErrorState(error: "Enter Password"));
      } else if (event.password.length <= 8 && !event.isGuest) {
        emit(PasswordErrorState(
            error: "Password should be greter than 8 charachters"));
      } else if (!RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(event.password) && !event.isGuest) {
        emit(PasswordErrorState(
            error:
                "Password should contain 1 Upper case ,1 lowercase,1 Numeric Number,Minimum 1 Special Character"));
      } else if (event.password != event.confirmPassword && !event.isGuest) {
        emit(ConfirmPasswordErrorState(error: "Password does not match"));
      } else {
        emit(SignUpValidState());
      }
    });

    on<GuestOrderEvent>((event, emit) async{
      print('event call');
      if(state is SignUpValidState){
        emit(SignUpSuccessfullState());
      }

    });

    on<UserRegisterEvent>((event, emit) async{
      print('event call');
      if (state is SignUpValidState) {
        print('event1');
        try{
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          print('successs');
          emit(SignUpSuccessfullState());
          //     .then((value) {
          //   print('Success value $value');
          //   emit(SignUpSuccessfullState());
          // })
          //     .onError((error, stackTrace) {
          //   print('Success value ${error.toString()}');
          //   emit(SignUpFailureState(error: error.toString()));});
        }catch(e){
            emit(SignUpFailureState(error: e.toString()));

        }

      }
    });
  }
}
