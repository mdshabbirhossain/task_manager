import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/presentation/screens/auth/set_password.dart';
import 'package:task_manager/presentation/screens/auth/signin_screen.dart';


import 'package:task_manager/presentation/utils/app_colors.dart';

import 'package:task_manager/presentation/widgets/background_widgets.dart';
class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),

                Text('Pin Verification',
                  style: Theme.of(context).textTheme.titleLarge,

                ),
                const SizedBox(height: 12),
                Text('A 6-digit verification code will be sent to your Email',
                  style: TextStyle(fontSize: 16,),),
                const SizedBox(height: 12),
                PinCodeTextField(
                  controller: _pinTEcontroller,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: AppColor.themeColor,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  //backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,



                  onCompleted: (v) {

                  },
                  onChanged: (value) {

                  },
                  beforeTextPaste: (text) {

                    return true;
                  }, appContext: context,
                ),


                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> const SetPassword()));

                    }, child: const Text('Verify'))),
                const SizedBox(height: 48,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?"),
                    TextButton(
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=> SignInScreen()), (route) => false);
                        },
                        child: const Text('Sign in')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
@override
  void dispose() {
  _pinTEcontroller.dispose();
    super.dispose();
  }

}
