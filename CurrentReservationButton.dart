import 'package:flutter/material.dart';
import 'package:pno3/MyApp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class CurrentReservationButton extends ConsumerWidget {
  const CurrentReservationButton({Key? key}) : super(key: key);

  bool inFuture(var endTime){
    if (endTime == null) {
      return false;
    } else if (int.parse(endTime.substring(6, 10)) < DateTime
        .now()
        .year) {
      return false;
    } else if (int.parse(endTime.substring(3, 5)) < DateTime
        .now()
        .month) {
      return false;
    } else if (int.parse(endTime.substring(0, 2)) < DateTime
        .now()
        .day) {
      return false;
    } else if (int.parse(endTime.substring(13, 15)) < DateTime
        .now()
        .hour) {
      return false;
    } else {
      return true;
    }
  }
  @override
  Widget build(context, WidgetRef ref) {
    return FloatingActionButton(
      // this will be a button to show you your current reservation
      onPressed: () async{
        String endTime = await historyStorage.read(key: "KEY_ENDTIME") ?? "";
        String beginTime = await historyStorage.read(key: "KEY_BEGINTIME") ?? "";
        showDialog(
            context: context,
            builder: (BuildContext context) {
              if (endTime == null) {
                return AlertDialog(
                    content: const SizedBox(
                        height: 40,
                        child: Text(
                            "You currently don't have a reservation")),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Return"))
                    ]);
              } else if (inFuture(endTime) == false) {
                return AlertDialog(
                    content: const SizedBox(
                        height: 40,
                        child: Text(
                            "You currently don't have a reservation")),
                    actions: [TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Return")
                    )
                    ]
                );
              } else {
                return AlertDialog(
                    content: SizedBox(
                        height: 90,
                        child: Column(
                            children: <Widget>[
                              const Text(
                                  "You have a reservation from"),
                              Text(
                                  beginTime.toString(),
                                  style: const TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold)),
                              const Text(
                                  "to"),
                              Text(
                                  endTime.toString(),
                                  style: const TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold))
                            ])),
                    actions: [TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Return")
                    )
                    ]
                );
              }
            });
      },
      child: const Icon(
          Icons.access_time_outlined
      ),
    );
  }
}