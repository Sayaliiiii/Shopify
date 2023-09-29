import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopify/features/Login/bloc/login_event.dart';
import 'package:shopify/features/Login/bloc/login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LogInInitial()) {
    on<OnChangedEvent>((event, emit) {
      if (event.email.isEmpty) {
        emit(EmailErrorState(error: "Enter Email Id"));
      } else if (!event.email.contains('@') ||
          !event.email.contains(".") ) {
        emit(EmailErrorState(error: "Enter valid email"));
      }  else if (event.password.isEmpty ) {
        emit(PasswordErrorState(error: "Enter Password"));
      } else if (event.password.length <= 8 ) {
        emit(PasswordErrorState(
            error: "Password should be greter than 8 charachters"));
      } else if (!RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(event.password) ) {
        emit(PasswordErrorState(
            error:
                "Password should contain 1 Upper case ,1 lowercase,1 Numeric Number,Minimum 1 Special Character"));
      } else {
        emit(LoginValidState());
      }
    });



    on<UserLoginEvent>((event, emit) async{
      print('event call');
      if (state is LoginValidState) {
        print('event1');
        try{
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
          print('successs');
          emit(LoginSuccessfullState());
        }catch(e){
            emit(LoginFailureState(error: e.toString()));

        }

      }
    });
  }
}
