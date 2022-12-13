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

Future<History> requestHistory(String email, String token) async {
  var response = await http.post(
    Uri.parse('http://192.168.137.50:8000/api/reserve'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'token': token
    }),
  );
  //var antwoord = jsonDecode(response.statusCode as String);
  //print("Dit is de response.body");0
  print(response.body);

  try{
    return History.fromJson(jsonDecode(response.body));
  } on  FormatException catch(_) {
    return const History(result: []);
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
class History {
  final List result;

  const History({required this.result});

  // this function is to see if the login is successful
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      result: json['result'] as List
      // result = [json[time_entered], json[time_left], json[price], json[payed]]
    );
  }
}