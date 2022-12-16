import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/MyApp.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}
class _ForgotPassword extends State<ForgotPassword> {
  TextEditingController mailController = TextEditingController();

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
                          'Please enter your email address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // a field to fill in your email address
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: mailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (mail) =>
                          mail != null && mail.trim() != email
                              ? 'This mail address does not have an account'
                              : null,
                        ),
                      ),
                    ),
                    Row(
                      // a button
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                            child: const Text(
                              'Continue',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              final form = formKey.currentState!;
                              if (form.validate()) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const VerificationPassword();
                                    }));
                              }
                            })
                      ],
                    ),
                  ],
                )
            )
        );
  }
}

// a page similar to the email verification page, only now it's used for when you
// you forgot your password and need to add a new one
class VerificationPassword extends StatefulWidget {
  const VerificationPassword({Key? key}) : super(key: key);

  @override
  State<VerificationPassword> createState() => _VerificationPassword();
}
class _VerificationPassword extends State<VerificationPassword> {
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
                      // a button
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
                                  'Continue',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  final form = formKey.currentState;
                                  if (form != null && form.validate()){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (BuildContext context) {
                                          return const NewPass();
                                        }));}
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

class NewPass extends StatefulWidget {
  const NewPass({Key? key}) : super(key: key);

  @override
  State<NewPass> createState() => _NewPass();
}
class _NewPass extends State<NewPass> {
  // most of the code in this class is copied from the sign up page
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();


  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;
  bool validatePassword(String pass){
    String _password = pass.trim();
    if(_password.isEmpty){
      setState(() {
        passwordStrength = 0;
      });
    }else if(_password.length < 6 ){
      setState(() {
        passwordStrength = 1 / 4;
      });
    }else if(_password.length < 8){
      setState(() {
        passwordStrength = 2 / 4;
      });
    }else{
      if(passValid.hasMatch(_password)){
        setState(() {
          passwordStrength = 4 / 4;
        });
        return true;
      }else{
        setState(() {
          passwordStrength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),  // makes sure everything is the right size
                child: ListView(
                  children: <Widget>[
                    Container(
                      // the title
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Change password',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      // a field to enter your new password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          obscureText: true,
                          controller: newPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'New password',
                          ),
                          validator: (pass) => pass != null && !validatePassword(pass)
                              ? "Weak password"
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // a field to repeat your password
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey2,
                        child: TextFormField(
                          obscureText: true,
                          controller: repeatPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Repeat Password',
                          ),
                          validator: (pass) => pass != newPasswordController.text
                              ? "Passwords don't match up"
                              : null,
                        ),
                      ),
                    ),
                    TextButton(
                      // a pop up that tells you what a good password needs
                      onPressed: () {
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: const Text(
                                      "A strong password has at least 6 symbols,"
                                          "and uses alphabetical, numerical, capital"
                                          " letters and special symbols."),
                                  actions: [
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pop();
                                      },
                                    )
                                  ],
                                );
                              }
                          );
                        }
                      },
                      child: const Text(
                        'Strong Password?',
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Change password'),
                          onPressed: () {
                            final form = formKey.currentState!;
                            final form2 = formKey2.currentState!;
                            if (form.validate() && form2.validate()) {
                              password = newPasswordController.text;
                              // changes old password to the new one
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                  builder: (context) => LoginPage()), (Route route) => false);
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