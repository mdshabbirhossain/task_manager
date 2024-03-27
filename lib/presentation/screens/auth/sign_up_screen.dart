import 'package:flutter/material.dart';
import 'package:task_manager/data/services/networkcaller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/widgets/background_widgets.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../../data/models/response_object.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNamecontroller = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _MobileController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isRegistrationInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(height: 60,),
                  Text('Join With Us',style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 16,),
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
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _firstNamecontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'FirstName',

                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your FirstName Address';
                      }
                      return null;
                    },


                  ),
                  const SizedBox(height: 8,),
                  TextFormField(controller: _lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'LastName',

                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your lastName ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(controller: _MobileController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your Mobile Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField( controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Password',

                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your password';
                      }
                      if (value!.length<=6){
                        return 'Password should be 6 digit';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _isRegistrationInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(onPressed: (){
                          if(_formkey.currentState!.validate()){
                            _signUp();
                          }
                        }, child: Icon(Icons.arrow_circle_right_outlined)),
                      )),
                  const SizedBox(height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(" Have an account!"),
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text('Sign In')),
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


  Future<void> _signUp() async{
    _isRegistrationInProgress = true;
    setState(() {
    });
    Map<String, dynamic> inputParams={

      "email":_emailTEcontroller.text.trim(),
      "firstName":_firstNamecontroller.text.trim(),
      "lastName":_lastNameController.text.trim(),
      "mobile":_MobileController.text.trim(),
      "password":_passwordController.text.trim(),
    };
    final ResponseObject response = await
    NetworkCaller.postRequest(Urls.registration, inputParams);
    _isRegistrationInProgress = false;
    setState(() {});
    if(response.isSuccess){
      if(mounted){

        showSnackBarMessage(context, 'Registration Success ! Please Login');
      }
      Navigator.pop(context);


    }else{
      if(mounted){
        showSnackBarMessage(context, 'Registration Failed ! Try Again',true);
      }
    }
  }
  @override
  void dispose() {
  _emailTEcontroller.dispose();
  _firstNamecontroller.dispose();
  _lastNameController.dispose();
  _MobileController.dispose();
  _passwordController.dispose();
  
    super.dispose();
  }
}
