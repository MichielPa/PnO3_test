import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/main app.dart';
import 'package:pno3/MyApp.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerification();
}
class _EmailVerification extends State<EmailVerification> {
  TextEditingController codeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      // text
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'We send a verification code to your mail address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // a field to write your verification code
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            controller: codeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Verification Code',
                            ),
                            validator: (code) =>
                            code != null && code.trim() != verification
                                ? 'Incorrect verification code'
                                : null,
                          ),
                        )
                    ),
                    Row(
                      // buttons to verify your email or resend the mail
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                              child: const Text(
                                'Resend Email',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {}
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  final form = formKey.currentState;
                                  if (form != null && form.validate()){
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                        builder: (context) => const MainPage()), (Route route) => false);
                                    // pushAndRemoveUntil adds a new page and removes
                                    // all previous pages
                                  }
                                }
                            )
                        ),
                      ],
                    ),
                  ],
                )
            )
        );
  }
}