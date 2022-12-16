import 'package:flutter/material.dart';
import 'package:pno3/MyApp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class HistoryBox extends StatefulWidget {
  const HistoryBox({Key? key, required this.history}) : super(key: key);

  final List history;

  @override
  State<HistoryBox> createState() => _HistoryBoxState();
}
class _HistoryBoxState extends State<HistoryBox> {

  Future<void> _handleRefresh() async{
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    if(widget.history.isNotEmpty){
      int end = widget.history.length - 1;
        return LiquidPullToRefresh(
          // this lets us reload the screen by scrolling down from the top
          onRefresh: _handleRefresh,
          color: Colors.blueAccent,
          height: 200,
          backgroundColor: Colors.white70,
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          child: ListView(
              children: <Widget>[
                for(int i = 0;i <= end;i++)
                  if(widget.history[end - i].payed == "True")
                  Container(
                  // now we use containers instead of buttons as grids
                  // we first design the lay out of the container
                    height: 190,
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(
                        30, 10, 30, 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                        BorderRadius.circular(24),
                        border: Border.all(
                            color: Colors.blue,
                            width: 0.5)),
                    alignment: Alignment.center,
                    // next up is the text you see
                    child: Column(children: <Widget>[
                      const Text('You parked from:',
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.white)),
                      Text(widget.history[end - i].time_entered,
                          // we sort the list from newest to oldest so we start
                          // at the end
                          // this is the start hour
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.5,
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.white)),
                      const Text("to",
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.white)),
                      Text(widget.history[end - i].time_left,
                          // end hour
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.5,
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.white)),
                      const Text("",
                          // if you payed or not
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.white)),
                      const Text("You payed",
                          // if you payed or not
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.white)),
                      Text(widget.history[end - i].price + " " + "euro",
                          // the price
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.5,
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.white))
                    ]
                    )
                )
                else
                    Container(
                      // now we use containers instead of buttons as grids
                      // we first design the lay out of the container
                        height: 190,
                        width: 200,
                        margin: const EdgeInsets.fromLTRB(
                            30, 10, 30, 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                            BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.blue,
                                width: 0.5)),
                        alignment: Alignment.center,
                        // next up is the text you see
                        child: Column(children: <Widget>[
                          const Text('You parked from:',
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  color: Colors.white)),
                          Text(widget.history[end - i].time_entered,
                              // we sort the list from newest to oldest so we start
                              // at the end
                              // this is the start hour
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.5,
                              style: const TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white)),
                          const Text("to",
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  color: Colors.white)),
                          Text(widget.history[end - i].time_left,
                              // end hour
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.5,
                              style: const TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white)),
                          const Text("",
                              // if you payed or not
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  color: Colors.white)),
                          const Text("You need to pay",
                              // if you payed or not
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  color: Colors.white)),
                          Text(widget.history[end - i].price + " " + "euro",
                              // the price
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.5,
                              style: const TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white))
                        ]
                        )
                    )
              ]
          ),
        );
    }else{
      return const Text("an error occurred");
    }
  }
}