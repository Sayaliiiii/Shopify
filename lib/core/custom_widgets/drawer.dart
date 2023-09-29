import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopify/features/Login/login_page.dart';
import 'package:shopify/features/Signup/presentation/sign_up.dart';

import '../utils/colors.dart';

final List<String> drawerList = [
  'Home',
  'Cart',
  'Offers',
  'My Bookings',
  'My Profile',
  'Support'
];

Drawer customDrawer(BuildContext context,bool isLogin){
  return Drawer(
    backgroundColor: ColorsA().drawerColor,
    child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 60.0),
                      color: ColorsA().appbarColor,
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/dp.png',
                            height: 92,
                            width: 92,
                          ),
                          Text(
                            isLogin ? 'Emily Cyrus' : 'Guest',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                      //height: 1000,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: ListTile(
                              leading: Text(drawerList[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                          );
                        },
                        itemCount: drawerList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 10,
                            color: Colors.black,
                            thickness: 0.5,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: InkWell(
                    onTap: () async {
                      if(isLogin) {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(isGuest: false),));

                      }

                    },
                    child:  SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(isLogin ? "Log Out" : "Sign Up",style: TextStyle(color: Colors.black),),
                          SizedBox(width: 4,),
                          Icon(Icons.logout_outlined,color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ))),
  );
}