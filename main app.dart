import 'package:flutter/material.dart';
import 'package:pno3/loginBackEnd.dart';
import 'package:pno3/accountPage.dart';
import 'package:pno3/ReservationPage.dart';
import 'package:pno3/MyApp.dart';
import 'package:pno3/HistoryPage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// riverpod is a package used so we can access a login token anywhere in the app

// temporary variables:
var license2= '1-BCG-852';
Set<String> plates = {license, license2}; // set so you can't have double plates


void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}
// ProviderScope is the first widget in the app and all the providers
// this means that from now on we can use loginProvider in all the widgets/classes
// after MyApp

int currentIndex = 1;
// we will need this variable to change pages with the navigation bar
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}
class _MainPage extends State<MainPage> {
  var currentPlate;
  var endHour;


  @override
  Widget build(BuildContext context) {
    return RequiresLogin(
      // we use the widget we made in the login file to check if
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold( // the lay-out of the app
            appBar: AppBar(
              centerTitle: true,
              title: const Text('SMARK'),
            ),
            body: Center(
              // inside this widget are multiple if-statements which
              // make sure the lay-out switches when changing page,
              // we use the index of the pages for this
              child: currentIndex == 0
              // the account information page
                  ? const AccountPage()
                    : currentIndex == 1
                        // the reservation page
                        ? const ReservationPage()
                        // finally we have the history page (else), it's very similar to
                        // the reservation page
                        : const HistoryPage()
            ),
            bottomNavigationBar: BottomNavigationBar(
              // this function defines the look of the bottom navigator we've been
              // using the change pages
              items: const [
                BottomNavigationBarItem(
                    label: 'Account', icon: Icon(Icons.account_circle_outlined)),
                BottomNavigationBarItem(
                    label: 'Reservations',
                    icon: Icon(Icons.local_parking_rounded)),
                BottomNavigationBarItem(label: 'History', icon: Icon(Icons.feed))
              ],
              // these lines of code make sure we can change page using the navigator
              currentIndex: currentIndex,
              onTap: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )
        ),
      ),
    );
  }
}