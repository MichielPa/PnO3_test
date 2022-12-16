import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/main app.dart';
import 'package:pno3/MyApp.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePass();
}
class _ChangePass extends State<ChangePass> {
  // most of the code in this class is copied from the sign up page
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();


  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

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
                padding: const EdgeInsets.all(10),
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
                        )
                    ),
                    Container(
                      // a field to write your old password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          obscureText: true,
                          controller: oldPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Old password',
                          ),
                          validator: (pass) => pass != password
                              ? 'Incorrect password'
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // a field to write your new password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: formKey2,
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
                      // a field to repeat your new password
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey3,
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
                      // a button which when pressed show a pop up which tells
                      // you what a strong password should have
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
                              });
                        }
                      },
                      child: const Text(
                        'Strong Password?',
                      ),
                    ),
                    Container(
                      // a button to change your password
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Change password'),
                          onPressed: () {
                            final form = formKey.currentState!;
                            final form2 = formKey2.currentState!;
                            final form3 = formKey3.currentState!;
                            if (form.validate() && form2.validate() && form3.validate()) {
                              password = newPasswordController.text;
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