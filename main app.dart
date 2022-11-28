import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/ChangeEmail.dart';
import 'package:pno3/ChangePassword.dart';
import 'package:pno3/ChangeLicense.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// riverpod is a package used so we can access a login token anywhere in the app

final loginProvider = StateProvider<LoginResult?>((ref) => null);
// because of ref, we can call the value of loginProvider everywhere we want
// the questionmark after LoginResult means it can be null

// temporary variables:
var license2= '1-BCG-852';
Set<String> plates = {license, license2}; // set so you can't have double plates

int currentIndex = 1;
// we will need this variable to change pages with the navigation bar
void main() {  // a simple functions which allows us to open the app
  runApp(const ProviderScope(child: MyApp()));
}
// ProviderScope is the first widget in the app and all the providers
// this means that from now on we can use loginProvider in all the widgets/classes
// after MyApp

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
                  ? SizedBox(
                  // SizedBox is similar to Container
                  width: double.infinity,
                  height: double.infinity,
                  child: ListView(children: <Widget>[
                    Container(
                      // text
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Account information',
                          style: TextStyle(fontSize: 25, color: Colors.blue),
                        )),
                    Container(
                      // a field with in it the user's email
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
                      child: TextField(
                        enabled: false,
                        // makes sure you can't change the text inside the field
                        controller: TextEditingController(text: email),
                        // makes the text inside the text field corresponds
                        // with the user's email
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                      ),
                    ),
                    Row(
                      // following code is for a sentence with a button to
                      // change your email
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                            ' Change email',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return const ChangeEmail();
                            }));
                          },
                        )
                      ],
                    ),
                     Container(
                       // a field with inside it a popup menu with all the user's
                       // license plates
                       margin: const EdgeInsets.fromLTRB(10, 10, 10, 1),
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(6),
                           // makes the box circular
                           border: Border.all(color: Colors.grey, width: 0.5)),
                       // makes the edge of the box visible
                       child: DropdownButtonHideUnderline(
                         // a drop down list with different license plates which
                         // you can select by pressing them
                         child: DropdownButton(
                           hint: const Text('Please select a plate'),
                           value: currentPlate,
                           onChanged: (newValue) {
                             setState(() {
                               currentPlate = newValue;
                             });
                           },
                           items: plates.map((location) {
                             return DropdownMenuItem(
                               value: location,
                               child: Text(location),
                             );
                           }).toList(),
                         ),
                       ),
                    ),
                        Row(
                      // following code is for a sentence with a button to
                      // add or remove a license plate
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                              ' Add',
                              style: TextStyle(fontSize: 15)
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return const ChangeLicense();
                            }));
                          },
                        ),
                        const Text('or',style: TextStyle(fontSize: 15)),
                        TextButton(
                          child: const Text(
                            'remove',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            // a pop up that shows when you want to remove a license plate
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // A pop up that will appear with 2 options:
                                    // yes to return to the login page(log out)
                                    // and no to close the pop up
                                    content: const Text(
                                        "Are you sure you want to remove this license plate?"
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor: Colors.red
                                        ),
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          if(currentPlate != null){
                                          plates.remove(currentPlate);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => super.widget));
                                          // this navigator also refreshes the screen
                                        }
                                          },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.white
                                        ),
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.of(context,
                                              rootNavigator: true)
                                              .pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        const Text('license plate',style: TextStyle(fontSize: 15))
                      ],
                    ),
                    Row(
                      // a text button to change your password
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                            'Change password',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return const ChangePass();
                            }));
                          },
                        )
                      ],
                    ),
                    Container(
                      // a button to log out
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                            ),
                            child: const Text('LOG OUT'),
                            onPressed: () {
                              {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // A pop up that will appear with 2 options:
                                        // yes to return to the login page(log out)
                                        // and no to close the pop up
                                        content: const Text(
                                            "Are you sure you want to log out?"
                                        ),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.red
                                            ),
                                            child: const Text("Yes"),
                                            onPressed: () {

                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.white
                                            ),
                                            child: const Text("No"),
                                            onPressed: () {
                                              Navigator.of(context,
                                                  rootNavigator: true)
                                                  .pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            })),
                      ]))
                    : currentIndex == 1
                        // the reservation page
                        ? CustomScrollView(
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
                                                const Text(
                                                  "0/500",
                                                  textAlign: TextAlign.start,
                                                  textScaleFactor: 1.5,
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
                          )
                        // finally we have the history page (else), it's very similar to
                        // the reservation page
                        : CustomScrollView(
                            slivers: <Widget>[
                              // list of widgets
                              SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return Container(
                                          height: 50,
                                          width: 200,
                                          margin: const EdgeInsets.fromLTRB(
                                              30, 7, 30, 7),
                                          child: Container(
                                              // now we use containers instead of buttons as grids
                                              // we first design the lay out of the container
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
                                              child: Column(children: const <Widget>[
                                                Text('You parked from:',
                                                    textAlign: TextAlign.start,
                                                    textScaleFactor: 1.5,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                Text('69uur',
                                                    textAlign: TextAlign.left,
                                                    textScaleFactor: 1.5,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                                Text("",
                                                    textAlign: TextAlign.start,
                                                    textScaleFactor: 1),
                                                Text("You payed:",
                                                    textAlign: TextAlign.start,
                                                    textScaleFactor: 1.5,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                Text("500 euros",
                                                    textAlign: TextAlign.start,
                                                    textScaleFactor: 1.5,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))
                                              ]
                                              )
                                          )
                                      );
                                    },
                                    childCount: 10,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          childAspectRatio: 2.5))
                            ],
                          )
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
