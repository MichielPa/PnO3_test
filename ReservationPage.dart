import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io'; // token
import 'package:http/http.dart' as http;

void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}

Future<LoginResult> requestAvailability(String email, String password, String timeslot1,
    String timeslot2, String timeslot3, String timeslot4, String timeslot5) async {
  var response = await http.post(
    Uri.parse('http://192.168.137.11:8000/api/check_availability'),
    // voor de sign up hetzelfde maar op het einde "/register", en ook license plate
    // doorsturen
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

      HttpHeaders.authorizationHeader: 'token',},


    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'timeslot1': timeslot1,
      'timeslot2': timeslot2,
      'timeslot3': timeslot3,
      'timeslot4': timeslot4,
      'timeslot5': timeslot5,

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

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPage();
}
class _ReservationPage extends State<ReservationPage> {
  var endHour;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // This widgets makes a list of grids you can scroll through
      slivers: <Widget>[
        // list of widgets
        SliverGrid(
          // we first define one grid
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                var hour = DateFormat('HH:00').format(DateTime.now().add(Duration(hours: index)));
                // always start with the current time and each
                //grid/timeslot is an hour later
                // parse changes a string in to an integer
                // HH gives the current hour (without minutes or seconds)
                var date = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(hours: index)));
                //Datetime.now() gives us the current time (date, hours, minutes, seconds)
                //DateFormat allows us to chose in what way we show the date
                return Container(
                    height: 50,
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(
                        30, 7, 30, 7),
                    // we'll make a list of buttons
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  24.0)),
                        ),
                        onPressed: () {
                          // we make a list with all of the possible end times
                          Set<String> endTimes = {
                            for(int i = index +1; i <= 168; i++)
                            // we start from 'index +1', that we don't have
                            // negative time or timeslots of length 0
                              DateFormat('dd-MM-yyyy - HH:00').format(
                                  DateTime.now().add(
                                      Duration(hours: i)))
                          };
                          showDialog(
                              context: context,
                              builder:
                                  (BuildContext context) {
                                return AlertDialog(
                                  // the pop up that will appear has 2 options:
                                  // yes to reserve a spot
                                  // and no to close the pop up
                                  content: SizedBox(
                                    height: 70,
                                    child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          const Text(
                                              "Choose an end time"),
                                          const Text("",textScaleFactor: 0.05),
                                          DropdownButtonHideUnderline(
                                            // a drop down list with different license plates which
                                            // you can select by pressing them
                                            child: DropdownButton(
                                              hint: const Text('Please select an end time'),
                                              value: endHour,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  endHour = newValue;
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return AlertDialog(
                                                          // another pop up will appear to confirm yoru timeslot
                                                          content: SizedBox(
                                                            height: 85,
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: <Widget>[
                                                                  const Text(
                                                                      "Are you sure you want to park from:"),
                                                                  Text(DateFormat('dd-MM-yyyy - HH:00').
                                                                  format(DateTime.now().add(Duration(hours: index))),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.bold)),
                                                                  const Text("to"),
                                                                  Text(endHour,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.bold))
                                                                ]),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                  foregroundColor:
                                                                  Colors
                                                                      .blue),
                                                              child:
                                                              const Text("Yes"),
                                                              onPressed: () {},
                                                            ),
                                                            TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                  backgroundColor:
                                                                  Colors
                                                                      .white),
                                                              child:
                                                              const Text("No"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                    true)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                });
                                              },
                                              items: endTimes.map((location) {
                                                return DropdownMenuItem(
                                                  value: location,
                                                  child: Text(location),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton
                                          .styleFrom(
                                          backgroundColor:
                                          Colors
                                              .white),
                                      child:
                                      const Text("Return"),
                                      onPressed: () {
                                        Navigator.of(
                                            context,
                                            rootNavigator:
                                            true)
                                            .pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        // next up is the text you can see on the buttons/grids
                        child: Column(children: <Widget>[
                          Text(date,
                            textAlign: TextAlign.start,
                            textScaleFactor: 1.5,),
                          Text(hour,
                              textAlign: TextAlign.start,
                              textScaleFactor: 2,
                              style: const TextStyle(
                                  fontWeight:
                                  FontWeight.bold)),
                          const Text(
                            "",
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                          ),
                          const Text(
                            "Available parking spots:",
                            textAlign: TextAlign.start,
                            textScaleFactor: 1.5,
                          ),
                          Row(
                          children: <Widget>[
                              setState(() async{
                                final filledSpots = await requestAvailability(email, password, "timeslot1",
                                    "timeslot2", "timeslot3", "timeslot4", "timeslot5");
                                Text(
                                    filledSpots.toString()
                                );
                              }),
                              const Text(
                                "/500",
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.5,
                              ),
                            ]
                          )
                        ]
                        )
                    )
                );
              },
              childCount: 168,
              // how many grids/buttons there are
            ),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 2.7
              // how many buttons you can see on the screen at once
            ))
      ],
    );
  }
}