import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pno3/main app.dart';
import 'package:pno3/sign up.dart';
import 'package:pno3/forgotPassword.dart';

// import this so we can go there after we're done with login or signing in
import 'dart:async';
import 'dart:convert';
import 'dart:io'; // token

import 'package:http/http.dart' as http;

var password = 'testtest';
var email = 'robbe@gmail.com';
var license = '1-ABC-123';
var verification = "1234";
var newEmail = "";
var newPass = "";
var newLic = "";
// temporary variables

var value;
// following function allows us to start the app
void main() {
  runApp(const MyApp());
}

// this is for the connection
Future<LoginResult> requestLogin(String email, String password) async {
  var response = await http.post(
    Uri.parse('http://192.168.137.11:8000/api/login'),
    // voor de sign up hetzelfde maar op het einde "/register", en ook license plate
    // doorsturen
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,

    }),
  );


  //var antwoord = jsonDecode(response.statusCode as String);
  //print("Dit is de response.body");0
  print(response.body);

  try{
    return LoginResult.fromJson(jsonDecode(response.body));
  } on  FormatException catch(_) {
    return const LoginResult(description: "error from server", token: "");
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

class LoginResult {
  final String description;
  final String token;

  const LoginResult({required this.description, required this.token});

  bool get isSuccessful => description == "Logged in successfully";
  // this function is to see if the login is successful
  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
        token: json['token'],
        description: json['result']
    );
  }
}

class RequiresLogin extends ConsumerWidget {
  // ConsumerWidget is from flutter_riverpod, it makes sure we can use loginProvider
  // (see main app)
  const RequiresLogin({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context,WidgetRef ref){
    // we first take the value of loginResult from MyApp(using the provider, see main app)
    // and store it in a new variable
    final loginResult = ref.watch(loginProvider);
    // watch means it automatically updates when the value of the loginProvider changes
    print("requireslogin");
    print(loginResult?.description);
    // when you open the app, you can go to the login page if you're not logged in,
    // to the main page if you're logged in, or else you get an error
    if(loginResult == null){
      return LoginPage();
    } else if(loginResult.isSuccessful){
      return child;
      // the child defined in the initialisation, returns the page inside your requiredlogin
      // for example the main page
    } else {
      return LoginPage();
      //error page that shows when you don't have a password or there's an error
      // in the back end
    }
  }
}

class ErrorPage extends ConsumerWidget {
  const ErrorPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final loginResult = ref.read(loginProvider);
    return Scaffold(
      // error page
      body: SafeArea(child: Column(
        children: [
          Text(loginResult?.description??"There's was an error"),
          // ?? means if it's zero, it returns a value (this normally shouldn't happen)
          ElevatedButton(onPressed: () {
            ref.read(loginProvider.notifier).state = null;
          }, child: const Text('Return'))
        ],
      )),
    );
  }
}

// this class decides the general theme of the app and is always active, it also
// makes sure the first thing you see when opening the app is the login page
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp is the app itself, so this functions returns the physical app,
      // everything inside is building the app
      debugShowCheckedModeBanner: false,
      // removes the "debug-banner"
      title: 'SMARK',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // allows you to use the text entered in a text field as a variable
  final formKey = GlobalKey<FormState>();
  // we will later need this to recall the text fields
  var value;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // this widget decides the lay-out of the app
            appBar: AppBar(
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: const Text("SMARK")),
            // the app bar is the top part of the app
            body: Padding(
              // the main part of the app, padding is a widget that helps with
              // keeping the lay out clean and makes everything the same scale
                padding: const EdgeInsets.all(10),
                // makes sure everything is a distance of 10 pixels from eachother
                // and the edges of the screen
                child: ListView(
                  children: <Widget>[
                    // gives a list of widgets
                    Container(
                      // container widgets allows us to take a limited part of the screen
                      // and putt something inside it, here that is the title
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
                      // text saying "login"
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // here you can write your email, the next text fields are
                      // mostly the same code
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        // a place to write in
                        controller: mailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      // the textfield for your password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: formKey,
                        // textformfields need a key so we can recall them later
                        child: TextFormField(
                          obscureText: true,
                          // changes the symbols in circles after typing them
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (_) =>
                              'Login failed, password or email is incorrect'
                          // this validator if the password matches up with the
                          // correct password of the email
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const ForgotPassword();
                              //the navigator function makes you go to a new page
                              // you can see pages as layers, push adds a new page/layer
                              // on top of the previous ones (so you can still return
                              // to the previous pages)
                            }));
                      },
                      child: const Text(
                        'Forgot Password',
                      ),
                    ),
                    LoginButton(formKey: formKey, mailController: mailController, passwordController: passwordController),
                    Row(
                      // row places the coming widgets next to each other
                      // (column places them beneath each other)
                      // following code is for a sentence with a button to create
                      // an account when you don't have one
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Need an account?'),
                        TextButton(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const SignUpPage();
                                  // makes you go to the sign up page when pressing the button
                                })
                            ); //signup screen
                          },
                        )
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key? key,
    required this.formKey,
    required this.mailController,
    required this.passwordController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController mailController;
  final TextEditingController passwordController;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}
class _LoginButtonState extends State<LoginButton> {
  var loginButtonText = 'LOGIN';
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,WidgetRef ref,_){
        return Container(
          // the button to log in
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
                child: Text(loginButtonText),
                onPressed: () async{
                  setState((){
                    loginButtonText= "Loading...";
                  });
                  // async means this function needs to wait on something
                  // from the back end (it won't run synchronous, in order)
                  final form = widget.formKey.currentState!;
                  final loginResult = await requestLogin(widget.mailController.text, widget.passwordController.text);
                  // await means we wait in this class for the back end
                  // to send a value, but other classes can continue
                  ref.read(loginProvider.notifier).state = loginResult;
                  // this changes loginResult to your new value
                  form.validate();
                  // if your password is wrong it'll show an error on the screen
                  setState((){
                    loginButtonText= "LOGIN";
                  });
                }
            )
        );
      }
    );
  }
}
