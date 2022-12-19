import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pno3/MyApp.dart';
import 'package:pno3/availabilityBackEnd.dart';
import 'ReservationButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPage();
}
class _ReservationPage extends State<ReservationPage> {
  List<String> fullHours = [];
  var timeslots = 5;
  final ScrollController _scrollController = ScrollController();
  int maxPlaces = 3;


  Future<void> _handleRefresh() async{
    return await Future.delayed(const Duration(seconds: 2));
  }
  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        // "maxscrollextent" is the maximum you can scroll down in your app
        timeslots += 6;
        setState(() {});
      }
    });
    return Consumer(
      builder: (context,WidgetRef ref,_){
        final loginResult = ref.watch(loginProvider.notifier).state;
        // we call the same token and email we used when we logged in using the loginProvider
        Future<int> freePlaces(int index) async{
          final availability = await requestAvailability(loginResult!.email, loginResult.token,
            DateFormat('dd-MM-yyyy HH').format(DateTime.now().add(Duration(hours: index))).toString(),
          );
          int filledSpots = availability.timestamp;
          return filledSpots;
        }
      return LiquidPullToRefresh(
        // this lets us reload the screen by scrolling down from the top
        onRefresh: _handleRefresh,
        color: Colors.blueAccent,
        height: 200,
        backgroundColor: Colors.white70,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        child: CustomScrollView(
            controller: _scrollController,
            // This widgets makes a list of grids you can scroll through
            slivers: <Widget>[
              // list of widgets
            SliverGrid(
                // we first define one grid
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index == timeslots) {
                      return const CupertinoActivityIndicator();
                    }
                    var color = Colors.blue;
                    var hour = DateFormat('HH:00')
                        .format(DateTime.now().add(Duration(hours: index)));
                    // always start with the current time and each
                    //grid/timeslot is an hour later
                    // parse changes a string in to an integer
                    // HH gives the current hour (without minutes or seconds)
                    var date = DateFormat('dd-MM-yyyy')
                        .format(DateTime.now().add(Duration(hours: index)));
                    //Datetime.now() gives us the current time (date, hours, minutes, seconds)
                    //DateFormat allows us to chose in what way we show the date
                    return FutureBuilder<int>(
                        future: freePlaces(index),
                        // saves it in snapshot
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            int filledSpots = snapshot.data!;
                            // filledSpots is now equal to the amount of reserved parking
                            // places during the timestamp
                            return _buildData(
                                color, context, index, date, hour, filledSpots);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                            // there was an error from the back end
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                            // a loading symbol while we wait on the server
                          }
                        });
                  },
                  childCount: timeslots + 1,
                  // how many grids/buttons there are
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 2.7
                    // how many buttons you can see on the screen at once
                    )
            )
          ],
        ),
      );
    });
  }

  Widget _buildData(MaterialColor color, BuildContext context, int index,
      String date, String hour, int filledSpots) {
    if (filledSpots == maxPlaces) {
      color = Colors.red;
      fullHours.add(DateFormat('dd-MM-yyyy - HH:00')
          .format(DateTime.now().add(Duration(hours: index))));
    }
    return ReservationButton(index: index, color: color, filledSpots: filledSpots,
        maxPlaces: maxPlaces, fullHours: fullHours, date: date, hour: hour);
  }
}


