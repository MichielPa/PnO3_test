import 'package:flutter/material.dart';
import 'package:pno3/ReservationPage.dart';
import 'package:pno3/main app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pno3/loginBackEnd.dart';
import 'package:pno3/singupBackEnd.dart';
// a simple functions which allows us to open the app

var password = 'testtest';
var email = 'dirk';
var license = '1-ABC-123';
var verification = "1234";
var newEmail = "";
var newPass = "";
var newLic = "";
// temporary variables

final loginProvider = StateProvider<LoginResult?>((ref) => null);
final signUpProvider = StateProvider<SignUpResult?>((ref) => null);
// because of ref, we can call the value of loginProvider everywhere we want
// the questionmark after LoginResult means it can be null

final availabilityProvider = StateProvider<Availability?>((ref) => null);
final passwordProvider = StateProvider<String?>((ref) => null);
final emailProvider = StateProvider<String?>((ref) => null);
final licenseProvider = StateProvider<String?>((ref) => null);

void main() {
  runApp(const ProviderScope(child: MyApp()));
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