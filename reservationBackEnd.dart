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

Future<Reserve> requestReservation(String email, String token, String begin_hour,
    String begin_day, String begin_month, String begin_year, String end_hour, String end_day,
    String end_month, String end_year) async {
  var response = await http.post(
    Uri.parse('http://192.168.137.50:8000/api/reserve'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'token': token,
      'begin_hour': begin_hour,
      'begin_day': begin_day,
      'begin_month': begin_month,
      'begin_year': begin_year,
      'end_hour': end_hour,
      'end_day': end_day,
      'end_month': end_month,
      'end_year': end_year,
    }),
  );
  //var antwoord = jsonDecode(response.statusCode as String);
  //print("Dit is de response.body");0
  print(response.body);

  try{
    return Reserve.fromJson(jsonDecode(response.body));
  } on  FormatException catch(_) {
    return const Reserve(result: "error from server");
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
class Reserve {
  final String result;

  const Reserve({required this.result});

  // this function is to see if the login is successful
  factory Reserve.fromJson(Map<String, dynamic> json) {
    return Reserve(
      result: json['result'] as String,

    );
  }
}