import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pno3/MyApp.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io'; // token
import 'package:http/http.dart' as http;

void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}

Future<Availability> requestAvailability(String email, String token, String timestamp1) async {
  var response = await http.post(
    Uri.parse('http://192.168.137.99:8000/api/check_availability'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'token': token,
      'timestamp1': timestamp1
    }),
  );
  //var antwoord = jsonDecode(response.statusCode as String);
  //print("Dit is de response.body");0
  print(response.body);

  try{
    return Availability.fromJson(jsonDecode(response.body));
  } on  FormatException catch(_) {
    return const Availability(result: "error from server", timestamp: 0);
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
class Availability {
  final String result;
  final int timestamp;

  const Availability({required this.result, required this.timestamp});

  // this function is to see if the login is successful
  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      timestamp: json['timestamp1'] as int,
      result: json['result'] as String,
    );
  }
}