import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/auth/signin_screen.dart';


import 'package:task_manager/presentation/widgets/background_widgets.dart';
class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _PasswordTEcontroller = TextEditingController();
  final TextEditingController _ConfirmPasswordTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



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

                  Text('Set Password',
                    style: Theme.of(context).textTheme.titleLarge,

                  ),
                  const SizedBox(height: 12),
                  Text('Choose your password',
                    style: TextStyle(fontSize: 16,),

                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _PasswordTEcontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Password',

                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _ConfirmPasswordTEcontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',

                    ),
                  ),

                  const SizedBox(height: 8,),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){

                      }, child: Text('Confirm'))),
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
      ),

    );
  }

  @override
  void dispose() {
    _PasswordTEcontroller.dispose();
    _ConfirmPasswordTEcontroller.dispose();

    super.dispose();
  }
}
