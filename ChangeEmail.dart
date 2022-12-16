import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/main app.dart';
import 'package:pno3/MyApp.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmail();
}
class _ChangeEmail extends State<ChangeEmail> {
  // most of the code in this class is copied from the sign up page
  TextEditingController passwordController = TextEditingController();
  TextEditingController newMailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      // the title
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Change email address',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )
                    ),
                    Container(
                      // a field to write your new email
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: newMailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'New email',
                          ),
                          validator: (mail) => mail != null && !EmailValidator.validate(email.trim())
                              ? 'Enter a valid email address'
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // a field to write your passsword
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Form(
                        key: formKey2,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (pass) => pass != password
                              ? "Incorrect password"
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // a button to change your email
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Change email'),
                          onPressed: () {
                            final form = formKey.currentState!;
                            final form2 = formKey2.currentState!;
                            if (form.validate() && form2.validate()) {
                              email = newMailController.text;
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                  builder: (context) => const MainPage()), (Route route) => false);
                            }
                          },
                        )
                    ),
                  ],
                )
            )
        );
  }
}