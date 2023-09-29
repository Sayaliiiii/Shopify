import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/constants/sharedPref.dart';
import 'package:shopify/features/Home/presentation/home_screen.dart';
import 'package:shopify/features/Login/bloc/login_bloc.dart';
import 'package:shopify/features/Login/bloc/login_state.dart';
import '../../core/custom_widgets/custom_button.dart';
import '../../core/custom_widgets/logo_widget.dart';
import '../../core/custom_widgets/textField_widget.dart';
import '../../core/utils/colors.dart';
import '../Signup/presentation/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_event.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc,LoginState>(
        listener: (context, state) async{
          if(state is LoginSuccessfullState){
            await UserPreferences.setLogged(true);
            Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(isLogin: true),));
          }
          if(state is LoginFailureState){
            showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(Duration(seconds: 5), () {
                    Navigator.of(context).pop(true);
                  });
                  return AlertDialog(
                    title: Center(
                        child: Text(
                          '${state.error}',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        )),
                  );
                });
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
          color: ColorsA().appbarColor,
          //     gradient: LinearGradient(colors: [
          //   hexStringToColor("CB2B93"),
          //   hexStringToColor("9546C4"),
          //   hexStringToColor("5E6154")
          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
    ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 50, 20, 0),
              child: Column(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () async {
                      await UserPreferences.setLogged(false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(isLogin: false),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          " Skip",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
                logoWidget(imagePath: "assets/images/logoog.png"),
                SizedBox(
                  height: 70,
                ),
                reusableTextField(
                  text: "Enter Email",
                  icon: Icons.person_2_outlined,
                  isPasswordType: false,
                  controller: emailController,
                  onChange: (p0) {
                    context.read<LoginBloc>().add(OnChangedEvent(email: emailController.text,password: passwordController.text));
                  },
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is EmailErrorState) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            state.error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 15),
                          ));
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  text: "Enter Password",
                  icon: Icons.lock_outline,
                  isPasswordType: true,
                  controller: passwordController,
                  onChange: (p0) {
                    context.read<LoginBloc>().add(OnChangedEvent(email: emailController.text,password: passwordController.text));
                  },
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is PasswordErrorState) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            state.error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 15),
                          ));
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                    context: context,
                    title: "Log In",
                    onTap: () async {
                      context.read<LoginBloc>().add(UserLoginEvent(email: emailController.text,password: passwordController.text));

                    }),
                const SizedBox(
                  height: 5,
                ),
                signUpOption(context),
                const SizedBox(
                  height: 5,
                ),

              ]),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignupScreen(
                          isGuest: false,
                        )));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
