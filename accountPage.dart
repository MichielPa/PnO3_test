import 'package:flutter/material.dart';
import 'package:pno3/ChangeEmail.dart';
import 'package:pno3/ChangePassword.dart';
import 'package:pno3/ChangeLicense.dart';
import 'package:pno3/MyApp.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pno3/main app.dart';

void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPage();
}
class _AccountPage extends State<AccountPage> {
  var currentPlate;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, WidgetRef ref, _) {
        final loginResult = ref.read(loginProvider.notifier).state!;
        // the exclamation mark means it can't be null
        return SizedBox(
          // SizedBox is similar to Container
            width: double.infinity,
            height: double.infinity,
            child: ListView(children: <Widget>[
              Container(
                // text
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Account information',
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                  )),
              Container(
                // a field with in it the user's email
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
                child: TextField(
                  enabled: false,
                  // makes sure you can't change the text inside the field
                  controller: TextEditingController(text: loginResult.email),
                  // makes the text inside the text field corresponds
                  // with the user's email
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "email"),
                ),
              ),
              Row(
                // following code is for a sentence with a button to
                // change your email
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      ' Change email',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const ChangeEmail();
                          }));
                    },
                  )
                ],
              ),
              Container(
                // a field with in it the user's email
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
                child: TextField(
                  enabled: false,
                  // makes sure you can't change the text inside the field
                  controller: TextEditingController(text: loginResult.licenseplate),
                  // makes the text inside the text field corresponds
                  // with the user's email
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "license plate"),
                ),
              ),
              Row(
                // following code is for a sentence with a button to
                // add or remove a license plate
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                        ' Add',
                        style: TextStyle(fontSize: 15)
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const ChangeLicense();
                          }));
                    },
                  ),
                  const Text('or', style: TextStyle(fontSize: 15)),
                  TextButton(
                    child: const Text(
                      'remove',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      // a pop up that shows when you want to remove a license plate
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // A pop up that will appear with 2 options:
                              // yes to return to the login page(log out)
                              // and no to close the pop up
                              content: const Text(
                                  "Are you sure you want to remove this license plate?"
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.red
                                  ),
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    if (currentPlate != null) {
                                      plates.remove(currentPlate);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              super.widget));
                                      // this navigator also refreshes the screen
                                    }
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white
                                  ),
                                  child: const Text("No"),
                                  onPressed: () {
                                    Navigator.of(context,
                                        rootNavigator: true)
                                        .pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  const Text('license plate', style: TextStyle(fontSize: 15))
                ],
              ),
              Row(
                // a text button to change your password
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      'Change password',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const ChangePass();
                          }));
                    },
                  )
                ],
              ),
              Container(
                // a button to log out
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                      ),
                      child: const Text('LOG OUT'),
                      onPressed: () {
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // A pop up that will appear with 2 options:
                                  // yes to return to the login page(log out)
                                  // and no to close the pop up
                                  content: const Text(
                                      "Are you sure you want to log out?"
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.red
                                      ),
                                      child: const Text("Yes"),
                                      onPressed: () {
                                        ref
                                            .read(loginProvider.notifier)
                                            .state = null;
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pop();
                                        setState(() {
                                          currentIndex = 1;
                                        });
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white
                                      ),
                                      child: const Text("No"),
                                      onPressed: () {
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      })),
            ]));
      },

    );
  }
}