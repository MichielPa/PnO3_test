import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
// this import is for the email validation function used
import 'package:pno3/singupBackEnd.dart';
import 'package:pno3/MyApp.dart';
/*
import 'dart:async';
import 'dart:convert';
import 'dart:io'; // token
import 'package:http/http.dart' as http;
*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/*
Future<Register> requestSingUp(String email, String password, String licensePlate) async {
  var response = await http.post(
    Uri.parse('http://192.168.137.11:8000/api/register'),
    // voor de sign up hetzelfde maar op het einde "/register", en ook license plate
    // doorsturen
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'licensePlate': licensePlate,

    }),
  );


  //var answer = jsonDecode(response.statusCode as String);
  //print("Dit is de response.body");0
  print(response.body);

  try{
    return Register.fromJson(jsonDecode(response.body));
  } on  FormatException catch(_) {
    return const Register(description: "error from server", token: "");
  }
  // this checks if there's an error from the back end
/*
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album. ' + response.statusCode.toString());
  }
 */
}

class Register {
  final String description;
  final String token;

  const Register({required this.description, required this.token});

  bool get isSuccessful => description == "Logged in successfully";
  // this function is to see if the login is successful
  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        token: json['token'],
        description: json['result']
    );
  }
}
*/


// the code of the sign up page is very similar to that of the login page
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();

  // this is needed for the email validator, so the if-statement in the sign in-button
  // knows which text field we're talking about

  var signUpButtonText = "SIGN UP";

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  // a function that validate user entered password:
  bool validatePassword(String pass){
    String _password = pass.trim();
    // trim() removes a space at the start or at the end of the password
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

  // the next functions checks if a license plate is valid, a valid password
  // license plate looks like this: 1-ABC-123
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
    return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      // the title
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'SMARK',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 40),
                        )),
                    Container(
                      // text saying "sign up"
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // the field for your email
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',

                          ),
                          validator: (email) => email != null && !EmailValidator.validate(email.trim())
                          // validates if the email is a correct email address
                              ? 'Enter a valid email'
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // the field for your license plate
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey2,
                        child: TextFormField(
                          controller: licensePlateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'License Plate',
                          ),
                          validator: (lic) => lic != null && !validateLicense(lic)
                              ? 'Enter a valid license plate (f.e.: 1-ABC-123)'
                              : null,
                          // checks if it's a correct license plate
                        ),
                      ),
                    ),
                    Container(
                      // the field for your password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: formKey3,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (pass) => pass != null && !validatePassword(pass)
                              ? "Weak password"
                              : null,
                          // checks if it's a correct password
                        ),
                      ),
                    ),
                    Container(
                      // the field to repeat your password
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey4,
                        child: TextFormField(
                          obscureText: true,
                          controller: repeatPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Repeat Password',
                          ),
                          validator: (pass) => pass != passwordController.text
                              ? "Passwords don't match up"
                              : null,
                          // checks if passwords match up
                        ),
                      ),
                    ),
                    TextButton(
                      // a button which when pressed gives you a pop up with
                      // information on what a strong password should have
                      onPressed: () {
                        {
                          showDialog(
                            // makes sure the pop up is shown
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // the pop up
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
                                        // pop only removes this page and returns
                                        // us the previous page (page underneath)
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
                    Consumer(
                      builder: (context,WidgetRef ref,_){
                      return Container(
                        // the button to sign up
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: Text(signUpButtonText),
                            onPressed: () async{
                              setState((){
                                signUpButtonText= "Loading...";
                              });
                              final form = formKey.currentState!;
                              final form2 = formKey2.currentState!;
                              final form3 = formKey3.currentState!;
                              final form4 = formKey4.currentState!;

                              final signUpResult = await requestSignUp(emailController.text, passwordController.text,licensePlateController.text);
                              ref.read(loginProvider.notifier).state = signUpResult;
                              if(signUpResult.isSuccessful){
                                Navigator.of(context).pop();
                              }
                              form.validate();
                              form2.validate();
                              form3.validate();
                              form4.validate();

                                // we change the providers to this for the account page


                                  // if everything is filled in correctly, only
                                  // the email verification is left

                                  // hierin de functie steken om de mail voor verificatie te versturen
                                  // de rest doen we in de emailverification widget
                                  // als de mail correct is zetten we de nieuwe
                              setState((){
                                signUpButtonText= "SIGN UP";
                              });
                              }
                          )
                      );}
                    ),
                  ],
                )
            )
        );
  }
}