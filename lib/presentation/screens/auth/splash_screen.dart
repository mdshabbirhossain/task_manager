import 'package:flutter/material.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/signin_screen.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav.dart';
import 'package:task_manager/presentation/screens/new_task_screen.dart';



import 'package:task_manager/presentation/widgets/Applogo_widget.dart';
import 'package:task_manager/presentation/widgets/background_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   super.initState();
   _moveToNextScreen();
  }

  Future<void> _moveToNextScreen ()async {
    await Future.delayed(const Duration(seconds:1));
    bool isLoggedIn = await AuthController.isUserLoggedIn();


    if(mounted){
      if(isLoggedIn){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainBottomNavBarScreen()));

      } else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child:Center(
          child: AppLogo(),
        ) ,
      ),
    );
  }


}


