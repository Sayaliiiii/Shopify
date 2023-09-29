import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/custom_widgets/textField_widget.dart';
import 'package:shopify/features/Cart/domain/entities/cart_entity.dart';
import 'package:shopify/features/Home/presentation/home_screen.dart';
import 'package:shopify/features/Signup/presentation/bloc/sign_up_event.dart';
import 'package:shopify/features/Signup/presentation/bloc/sign_up_state.dart';
import '../../../core/custom_widgets/custom_button.dart';
import '../../../core/utils/colors.dart';
import '../../Login/login_page.dart';
import 'bloc/sign_up_bloc.dart';

class SignupScreen extends StatelessWidget {
  bool isGuest;

  SignupScreen({super.key, required this.isGuest});

  TextEditingController confirmpasswordTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController mobileTextController = TextEditingController();
  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsA().drawerColor,
        centerTitle: true,
        // elevation: 50,
        title: Text(
          isGuest ? "Delivery Information" : "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              //     gradient: LinearGradient(colors: [
              //   hexStringToColor("CB2B93"),
              //   hexStringToColor("9546C4"),
              //   hexStringToColor("5E61F4")
              // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
              color: Colors.white),
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) async {
              print('Statee $state');
              if (state is SignUpFailureState) {
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
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        )),
                      );
                    });
              }
              if (state is SignUpSuccessfullState) {
                confettiController.play();
                print('confettttt');
                await Cart().clearCart();
                await showDialog(
                    context: context,
                    builder: (context) {
                      // Future.delayed(const Duration(seconds: 5), () {
                      //   Navigator.of(context).pop();
                      // });
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: ConfettiWidget(
                              confettiController: confettiController,
                              blastDirectionality:
                                  BlastDirectionality.explosive,
                              // don't specify a direction, blast randomly
                              shouldLoop: true,
                              // start again as soon as the animation is finished
                              colors: const [
                                Colors.green,
                                Colors.blue,
                                Colors.pink,
                                Colors.orange,
                                Colors.purple
                              ],
                              // manually specify the colors to be used
                              createParticlePath: drawStar,
                            ),
                          ),
                          AlertDialog(
                            title: Column(
                              children: [

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 50),
                                      child: Center(
                                        child: Text(
                                          isGuest
                                              ? 'Hooray \n Your order has been placed successfully'
                                              : 'Congratulations\n You have Successfully Registered',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      )),
                                ),
                                CustomButton(
                                    context: context,
                                    title: isGuest ? 'Home' : 'Login',
                                    onTap: () {
                                      isGuest
                                          ? Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                              return HomeScreen(
                                                isLogin: false,
                                              );
                                            }))
                                          : Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                              return LoginScreen();
                                            }));
                                    })
                              ],
                            ),
                          ),
                        ],
                      );
                    });
                confettiController.stop();
                isGuest
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(isLogin: false),
                        ))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
              }
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                            text: isGuest ? "Name" : "Enter UserName",
                            icon: Icons.person_outline,
                            isPasswordType: false,
                            controller: userNameTextController,
                            onChange: (value) {
                              context.read<SignUpBloc>().add(OnChangedEvent(
                                  isGuest: isGuest,
                                  address: addressTextController.text,
                                  phoneNo: mobileTextController.text,
                                  confirmPassword:
                                      confirmpasswordTextController.text,
                                  email: emailTextController.text,
                                  password: passwordTextController.text,
                                  username: userNameTextController.text));
                            },
                          ),
                          BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              if (state is UsernameErrorState) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    state.error,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          reusableTextField(
                              text: "Enter Email Id",
                              icon: Icons.person_outline,
                              isPasswordType: false,
                              controller: emailTextController,
                              onChange: (value) {
                                context.read<SignUpBloc>().add(OnChangedEvent(
                                    isGuest: isGuest,
                                    address: addressTextController.text,
                                    phoneNo: mobileTextController.text,
                                    confirmPassword:
                                        confirmpasswordTextController.text,
                                    email: emailTextController.text,
                                    password: passwordTextController.text,
                                    username: userNameTextController.text));
                              }),
                          BlocBuilder<SignUpBloc, SignUpState>(
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
                            height: 15,
                          ),
                          reusableTextField(
                              text: "Mobile No",
                              icon: Icons.phone_android,
                              isPasswordType: false,
                              controller: mobileTextController,
                              onChange: (value) {
                                context.read<SignUpBloc>().add(OnChangedEvent(
                                    isGuest: isGuest,
                                    address: addressTextController.text,
                                    phoneNo: mobileTextController.text,
                                    confirmPassword:
                                        confirmpasswordTextController.text,
                                    email: emailTextController.text,
                                    password: passwordTextController.text,
                                    username: userNameTextController.text));
                              }),
                          BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              if (state is MobileErrorState) {
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
                              isAddress: true,
                              text: "Address",
                              icon: Icons.home_outlined,
                              isPasswordType: false,
                              controller: addressTextController,
                              onChange: (value) {
                                context.read<SignUpBloc>().add(OnChangedEvent(
                                    isGuest: isGuest,
                                    address: addressTextController.text,
                                    phoneNo: mobileTextController.text,
                                    confirmPassword:
                                        confirmpasswordTextController.text,
                                    email: emailTextController.text,
                                    password: passwordTextController.text,
                                    username: userNameTextController.text));
                              }),
                          BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              if (state is AddressErrorState) {
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
                          if (!isGuest)
                            Column(
                              children: [
                                reusableTextField(
                                    text: "Enter Password",
                                    icon: Icons.lock_outlined,
                                    isPasswordType: true,
                                    controller: passwordTextController,
                                    onChange: (value) {
                                      context.read<SignUpBloc>().add(
                                          OnChangedEvent(
                                              isGuest: isGuest,
                                              address:
                                                  addressTextController.text,
                                              phoneNo:
                                                  mobileTextController.text,
                                              confirmPassword:
                                                  confirmpasswordTextController
                                                      .text,
                                              email: emailTextController.text,
                                              password:
                                                  passwordTextController.text,
                                              username:
                                                  userNameTextController.text));
                                    }),
                                BlocBuilder<SignUpBloc, SignUpState>(
                                  builder: (context, state) {
                                    if (state is PasswordErrorState) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            state.error,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 15),
                                          ));
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableTextField(
                                    text: "Confirm Password",
                                    icon: Icons.lock_outlined,
                                    isPasswordType: true,
                                    controller: confirmpasswordTextController,
                                    onChange: (value) {
                                      context.read<SignUpBloc>().add(
                                          OnChangedEvent(
                                              isGuest: isGuest,
                                              address:
                                                  addressTextController.text,
                                              phoneNo:
                                                  mobileTextController.text,
                                              confirmPassword:
                                                  confirmpasswordTextController
                                                      .text,
                                              email: emailTextController.text,
                                              password:
                                                  passwordTextController.text,
                                              username:
                                                  userNameTextController.text));
                                    }),
                                BlocBuilder<SignUpBloc, SignUpState>(
                                  builder: (context, state) {
                                    if (state is ConfirmPasswordErrorState) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            state.error,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 15),
                                          ));
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    CustomButton(
                        context: context,
                        title: isGuest ? "Checkout" : "Sign Up",
                        onTap: () {
                          isGuest
                              ? context
                                  .read<SignUpBloc>()
                                  .add(GuestOrderEvent())
                              : context.read<SignUpBloc>().add(
                                  UserRegisterEvent(
                                      email: emailTextController.text,
                                      password: passwordTextController.text));
                        }),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
