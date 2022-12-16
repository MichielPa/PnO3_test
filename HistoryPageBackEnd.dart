
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
    Uri.parse('http://192.168.137.99:8000/api/get_history'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'token': token
    }),
  );

  try{
    return History.fromJson(jsonDecode(response.body));
  } on  FormatException catch(_) {
    return History(result:  []);
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
class Result{
  final List<History> result;

  Result({required this.result});

  factory HistoryList.fromJson(List<dynamic> parsedJson) {

    List<History> result = <History>[];
    result = parsedJson.map((i)=>History.fromJson(i)).toList();

    return HistoryList(
        result: result
    );
  }
}
class History {
  final String email;
  final String licenseplate;
  final String time_entered;
  final String time_left;
  final String price;
  final String payed;

  const History({required this.time_entered, required this.time_left,
  required this.price, required this.payed, required this.email,
  required this.licenseplate});

  // this function is to see if the login is successful
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        email: json['email'] as String,
        licenseplate: json['licenseplate'] as String,
        time_entered: json['time_entered'] as String,
        time_left: json['time_left'] as String,
        price: json['price'] as String,
        payed: json['payed'] as String
        // result = [json[time_entered], json[time_left], json[price], json[payed], json[time_entered], json[time_left], json[price], json[payed]]
    );
  }
}*/

class History {
  final List<Result> result;


  History({required this.result});
  // we use required so it can be null

  factory History.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['result'] as List;
    List<Result> resultList = list.map((i) => Result.fromJson(i)).toList();
    return History(
      result: resultList
    );
  }
}

class Result {
  final String email;
  final String licenseplate;
  final String time_entered;
  final String time_left;
  final String price;
  final String payed;

  Result(
      {required this.email, required this.licenseplate, required this.time_entered,
        required this.time_left, required this.price, required this.payed});

  factory Result.fromJson(Map<String, dynamic> parsedJson){
    return Result(
      email: parsedJson['email'] as String,
      licenseplate: parsedJson['licenseplate'] as String,
      time_entered: parsedJson['time_entered'] as String,
      time_left: parsedJson['time_left'] as String,
      price: parsedJson['price'] as String,
      payed: parsedJson['payed'] as String
    );
  }
}