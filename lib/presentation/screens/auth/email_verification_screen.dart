import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';



import 'package:task_manager/presentation/widgets/background_widgets.dart';
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();

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

                  Text('Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,

                  ),
                  const SizedBox(height: 12),
                  Text('A 6-digit verification code will be sent to your Email',
                    style: TextStyle(fontSize: 16,),

                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailTEcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',

                    ),
                  ),

                  const SizedBox(height: 8,),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> const PinVerificationScreen()));
                      }, child: Icon(Icons.arrow_circle_right_outlined))),
                  const SizedBox(height: 48,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?"),
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
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
    _emailTEcontroller.dispose();

    super.dispose();
  }


  Future<void> sendEmail() async {

  }


}


