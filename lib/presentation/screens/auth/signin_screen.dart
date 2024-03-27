import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/data/models/login_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/screens/auth/email_verification_screen.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav.dart';
import 'package:task_manager/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_manager/presentation/utils/assets_path.dart';
import 'package:task_manager/presentation/widgets/background_widgets.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../../data/models/response_object.dart';
import '../../../data/services/networkcaller.dart';
import '../../controllers/auth_controller.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoginInProgress = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                   Text('Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,

                  ),
                  TextFormField(
                    controller: _emailTEcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                        
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your Email Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        )
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  SizedBox(
                    width: double.infinity,
                      child: Visibility(
                        visible: _isLoginInProgress==false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(onPressed: (){
                         if(_formkey.currentState!.validate()){
                           _signIn();

                         }
                        }, child: Icon(Icons.arrow_circle_right_outlined)),
                      )),
                  const SizedBox(height: 48,),
                  TextButton(
                      style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 18),
                          foregroundColor: Colors.pink),
                        
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> const EmailVerificationScreen ()));
                      },
                      child: const Text('Forgot Password?')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Don't have an account?"),
                       TextButton(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder:(context)=> const SignUpScreen()));
                           },
                           child: const Text('SignUp')),
                     ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  Future<void> _signIn() async{
    _isLoginInProgress =true;
    setState(() {});
    Map<String, dynamic> inputParams ={

    "email":_emailTEcontroller.text.trim(),
    "password":_passwordController.text,
    };
    final ResponseObject response =  await NetworkCaller.postRequest(Urls.login, inputParams,fromSignIn: true);
    _isLoginInProgress = false;
    setState(() {});
    if(response.isSuccess){
      if(!mounted){
        return;
      }

      LoginResponse loginResponse = LoginResponse.fromJson(response.responseBody);
      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);

      if(mounted){

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainBottomNavBarScreen()), (route) => false);

      }
    }else{
      if(mounted) {
        showSnackBarMessage(context, response.errorMessage?? 'Login Failed ! Try Again');
      }

    }

  }

  void _clearFields() {
    _emailTEcontroller.clear();
    _passwordController.clear();
  }
  @override
  void dispose() {
    _emailTEcontroller.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
