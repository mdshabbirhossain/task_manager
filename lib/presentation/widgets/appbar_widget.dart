import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/UpdateProfileScreen.dart';
import 'package:task_manager/presentation/screens/auth/signin_screen.dart';

import '../utils/app_colors.dart';

PreferredSizeWidget get ProfileAppBar {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: AppColor.themeColor,
    title: GestureDetector(
      onTap: ()   {

        Navigator.push(TaskManager.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
      },
      child: Row(
        children: [
          CircleAvatar(),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName??'',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  (AuthController.userData?.email??''),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async{
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                    TaskManager.navigatorKey.currentState!.context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
    ),
  );
}
