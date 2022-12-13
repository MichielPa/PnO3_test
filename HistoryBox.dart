import 'package:flutter/material.dart';
import 'package:pno3/MyApp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class HistoryBox extends StatefulWidget {
  const HistoryBox({Key? key,
    required this.history
  }) : super(key: key);

  final List history;

  @override
  State<HistoryBox> createState() => _HistoryBoxState();
}
class _HistoryBoxState extends State<HistoryBox> {
  @override
  Widget build(BuildContext context) {
    if(widget.history.isNotEmpty){
      int end = widget.history.length;
      for(int i = 0;i <= widget.history.length;i++){
        String payed = "";
        if(widget.history[end - i -1] == true){
          // if you already payed or not
          payed = "You payed";
        }else{
          payed = "You need to pay";
        }
        return ListView(
            children: <Widget>[
              Container(
                // now we use containers instead of buttons as grids
                // we first design the lay out of the container
                  height: 50,
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(
                      10, 10, 10, 1),
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
                    Text(widget.history[end - i - 3].toString(),
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
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Colors.white)),
                    Text(widget.history[end - i - 2].toString(),
                        // end hour
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            color: Colors.white)),
                    Text(payed,
                        // if you payed or not
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            color: Colors.white)),
                    Text(widget.history[end - i].toString(),
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
        );
      }
    }else{
      return const Text("an error occurred");
    }
    return const Text("an error occurred");
  }
}