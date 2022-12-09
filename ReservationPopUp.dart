import 'package:flutter/material.dart';
import 'package:pno3/MyApp.dart';
import 'reservationBackEnd.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}


class ReservationPopUp extends StatefulWidget {
  const ReservationPopUp({
    Key? key,
    required this.endTimes,
    required this.index
  }) : super(key: key);

  final List<String> endTimes;
  final int index;

  @override
  State<ReservationPopUp> createState() => _ReservationPopUp();
}
class _ReservationPopUp extends State<ReservationPopUp> {
  var endTime;
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context,WidgetRef ref,_){
          return AlertDialog(
            // the pop up that will appear has 2 options:
            // yes to reserve a spot
            // and no to close the pop up
            content: SizedBox(
              height: 70,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text("Choose an end time"),
                    const Text("", textScaleFactor: 0.05),
                    DropdownButtonHideUnderline(
                      // a drop down list with different license plates which
                      // you can select by pressing them
                      child: DropdownButton(
                        hint:
                        const Text('Please select an end time'),
                        value: endTime,
                        onChanged: (newValue) {
                          setState(() {
                            endTime = newValue;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // another pop up will appear to confirm your timeslot
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
                                            Text(
                                                DateFormat(
                                                    'dd-MM-yyyy - HH:00')
                                                    .format(DateTime
                                                    .now()
                                                    .add(Duration(
                                                    hours:
                                                    widget.index))),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold)),
                                            const Text("to"),
                                            Text(endTime,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold))
                                          ]),
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                            Colors.blue),
                                        child: const Text("Yes"),
                                        onPressed: () async{
                                          var startTime = DateTime.now().add(Duration(hours: widget.index));
                                          final loginResult = ref.watch(loginProvider.notifier).state;
                                          // 'dd-MM-yyyy - HH:00'
                                          print("hier");
                                          final confirmReservation = await requestReservation(
                                              loginResult!.email, loginResult.token,
                                              DateFormat("HH").format(startTime), DateFormat("dd").format(startTime), DateFormat("MM").format(startTime),
                                              startTime.year.toString(), endTime.toString().substring(13,15),
                                              endTime.toString().substring(0,2), endTime.toString().substring(3,5),
                                              endTime.toString().substring(6,10));
                                          if(confirmReservation.result == 'reservation successfully made'){
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                      content: const SizedBox(
                                                          height: 40,
                                                          child: Text("Successfully reserved a parking place")),
                                                      actions: [TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context,
                                                                        rootNavigator:
                                                                        true)
                                                                        .pop();
                                                                  },
                                                                  child: const Text("Return")
                                                              )]
                                                      );
                                                });
                                          }else{
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                      content: const SizedBox(
                                                          height: 40,
                                                          child: Text(
                                                              "Something went wrong while making a reservation")),
                                                      actions: [TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context,
                                                                rootNavigator:
                                                                true)
                                                                .pop();
                                                          },
                                                          child: const Text("Return")
                                                      )]
                                                  );
                                                });
                                          }
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                            Colors.white),
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.of(context,
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
                        items: widget.endTimes.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                      ),
                    ),
                  ]),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white),
                child: const Text("Return"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        }
    );
  }
}
