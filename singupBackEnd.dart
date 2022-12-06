import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pno3/MyApp.dart';
import 'package:pno3/loginBackEnd.dart';
import 'package:pno3/main%20app.dart';
import 'package:pno3/sign up.dart';

// import this so we can go there after we're done with login or signing in
import 'dart:async';
import 'dart:convert';
import 'dart:io'; // token
import 'package:http/http.dart' as http;


// following function allows us to start the app
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// this is for the connection
Future<LoginResult> requestSignUp(String email, String password, String licenseplate) async {
  var response = await http.post(
    Uri.parse('http://192.168.137.200:8000/api/register'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'licenseplate': licenseplate

    }),
  );


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
/*
//state manager
class RequiresLogin extends ConsumerWidget {
  // ConsumerWidget is from flutter_riverpod, it makes sure we can use loginProvider
  // (see main app)
  const RequiresLogin({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context,WidgetRef ref){
    // we first take the value of loginResult from MyApp(using the provider, see main app)
    // and store it in a new variable
    final signUpResult = ref.watch(signUpProvider);
    // watch means it automatically updates when the value of the loginProvider changes

    // when you open the app, you can go to the login page if you're not logged in,
    // to the main page if you're logged in, or else you get an error
    if(signUpResult == null){
      return const SignUpPage();
    } else if(signUpResult.isSuccessful){
      return const MainPage();
      // the child defined in the initialisation, returns the page inside your requiredlogin
      // for example the main page
    } else {
      return const SignUpPage();
      //error page that shows when you don't have a password or there's an error
      // in the back end
    }
  }
}
*/