import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/main app.dart';

var password = 'password';
var email = 'test@gmail.com';
var license = '1-ABC-123';
var license2= '1-BCG-852';
// temporary variables

void main() {
  runApp(const MyApp());
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),  // makes sure everything is the right size
                child: ListView(
                  children: <Widget>[
                    Container( // the title
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Change email address',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
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
                ))
        )
    );
  }
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
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  //A function that validate user entered password
  bool validatePassword(String pass){
    String _password = pass.trim();
    // removes a space at the start or at the end of the password
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),  // makes sure everything is the right size
                child: ListView(
                  children: <Widget>[
                    Container( // the title
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
                ))
        )
    );
  }
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
    // checking if the first symbol is a number, double.tryParse checks if it's
    // numerical (when it equal null it isn't)
    if (lic[1] != "-")
    {return false;}
    if (lic.substring(2,5).toUpperCase() != lic.substring(2,5))
    {return false;}
    // toUpperCase transforms the string in all caps, if it doesn't equal the
    // string itself, we know it's not all capital letters
    // .substring(index) allows us to verify each symbol of the string
    if (lic[5] != "-")
    {return false;}
    if (double.tryParse(lic.substring(6)) == null)
    {return false;}
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),  // makes sure everything is the right size
                child: ListView(
                  children: <Widget>[
                    Container( // the title
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Add license plate',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
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
                ))
        )
    );
  }
}