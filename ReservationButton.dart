import 'package:flutter/material.dart';
import 'package:pno3/MyApp.dart';
import 'ReservationPopUp.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}


class ReservationButton extends StatefulWidget {
  const ReservationButton({
    Key? key,
    required this.index,
    required this.color,
    required this.filledSpots,
    required this.maxPlaces,
    required this.fullHours,
    required this.date,
    required this.hour
  }) : super(key: key);

  final color;
  final int index;
  final int filledSpots;
  final int maxPlaces;
  final List<String> fullHours;
  final date;
  final hour;

  @override
  State<ReservationButton> createState() => _ReservationButton();
}
class _ReservationButton extends State<ReservationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 200,
        margin: const EdgeInsets.fromLTRB(30, 7, 30, 7),
        // we'll make a list of buttons
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
            ),
            onPressed: () {
              if (widget.filledSpots == widget.maxPlaces) {
                // hour is filled
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: const SizedBox(
                              height: 40,
                              child: Text(
                                  "There are no available parking places at this time")),
                          actions: [TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Return")
                          )]
                      );
                    });
              } else {
                /*
                // we make a list with all of the possible end times
                var min;
                fullHours = fullHours.sort();
                for(int i = 0;i <= fullHours.length - 1;i++){
                  if(fullHours[i] < index){
                    if(fullHours.length == 1){
                      min = fullHours[0];
                      print(min);
                    }else{
                      min = fullHours[i+1];
                      print(min);
                    }
                  }
                }
                Set<String> endTimes = {
                  for (int i = index + 1; i <= min; i++)
                    // we start from 'index +1', so that we don't have
                    // negative time or timeslots of length 0
                    // the end is either 168 or the first timeslot which
                    // is completely filled
                    DateFormat('dd-MM-yyyy - HH:00')
                        .format(DateTime.now().add(Duration(hours: i)))
                };
                print(endTimes);*/

                // we make a list with all of the possible end times
                List<String> endTimes = [
                  for(int i = widget.index + 1; i <= 168; i++)
                  // we start from 'index +1', that we don't have
                  // negative time or timeslots of length 0
                    DateFormat('dd-MM-yyyy - HH:00').format(
                        DateTime.now().add(
                            Duration(hours: i)))
                ];
                if(widget.fullHours.isNotEmpty){
                for(int i=0;i < widget.fullHours.length;i++){
                  if(endTimes.contains(widget.fullHours[i])){
                    endTimes = endTimes.sublist(0,endTimes.indexOf(widget.fullHours[i])+1);
                    // the list with all the endtimes now ends with a full hour
                    // so you cant reserve then
                  }
                }}
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ReservationPopUp(endTimes: endTimes, index: widget.index);
                    });
              }
            },
            // next up is the text you can see on the buttons/grids
            child: Column(children: <Widget>[
              Text(
                widget.date,
                textAlign: TextAlign.start,
                textScaleFactor: 1.5,
              ),
              Text(widget.hour,
                  textAlign: TextAlign.start,
                  textScaleFactor: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
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
              Text(
                "${widget.filledSpots.toString()}/3",
                textAlign: TextAlign.start,
                textScaleFactor: 1.5,
              )
            ]
            )
        )
    );
  }
}