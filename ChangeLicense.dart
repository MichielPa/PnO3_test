import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/main app.dart';
import 'package:pno3/MyApp.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pno3/sign%20up.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class ChangeLicense extends StatefulWidget {
  const ChangeLicense({Key? key}) : super(key: key);

  @override
  State<ChangeLicense> createState() => _ChangeLicense();
}
class _ChangeLicense extends State<ChangeLicense> {
  // most of the code in this class is copied from the sign up page
  TextEditingController passwordController = TextEditingController();
  TextEditingController newLicenseController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  bool validateLicense(String lic){
    if(lic.length != 9)
    {return false;}
    if (double.tryParse(lic[0]) == null)
    {return false;}
    if (lic[1] != "-")
    {return false;}
    if (lic.substring(2,5).toUpperCase() != lic.substring(2,5))
    {return false;}
    if (lic[5] != "-")
    {return false;}
    if (double.tryParse(lic.substring(6)) == null)
    {return false;}
    return true;
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
                          'Add license plate',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )
                    ),
                    Container(
                      // a field to write a new license plate
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: newLicenseController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'New license plate',
                          ),
                          validator: (lic) => lic != null && !validateLicense(lic)
                              ? 'Enter a new and valid license plate (f.e.: 1-ABC-123)'
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // a field to write your password
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
                      // a button to change your license plate
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Add license plate'),
                          onPressed: () {
                            final form = formKey.currentState!;
                            final form2 = formKey2.currentState!;
                            if (form.validate() && form2.validate()) {
                              plates.add(newLicenseController.text);
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