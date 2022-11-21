import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/accountpage extra.dart';


var license2= '1-BCG-852';
List<String> timeslots = [
  "00:00 - 02:00", "02:00 - 04:00", "04:00 - 06:00", "08:00 - 10:00", "10:00 - 12:00",
  "12:00 - 14:00", "14:00 - 16:00", "16:00 - 18:00", "18:00 - 20:00", "20:00 - 22:00",
  "22:00-00:00"
];
Set<String> plates = {license, license2}; // set so you can't have double plates
// temporary variables

int currentIndex = 1;
// we will need this variable to change pages with the navigation bar
void main() {  // a simple functions which allows us to open the app
  runApp(const MyApp());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}
class _MainPage extends State<MainPage> {
  var currentPlate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                builder: (context) => const LoginPage()), (Route route) => false);
                                            // "pushAndRemoveUntil" makes us go to the right page
                                            // and removes all the other pages we've been through
                                            // from the stack
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
                                              // what happens when you press one of the buttons
                                              // a popup will appear
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
                                                            // y-as voor column, x-as voor row
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              const Text(
                                                                  "Are you sure you want to park during timeslot:"),
                                                              Text(timeslots[
                                                                  index]),
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
                                            },
                                            // next up is the text you can see on the buttons
                                            child: Column(children: <Widget>[
                                              Text(timeslots[index],
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
                                  childCount: 11,
                                  // how many grids/buttons there are
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, childAspectRatio: 3
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
                                            child: Column(children: <Widget>[
                                              const Text('You parked from:',
                                                  textAlign: TextAlign.start,
                                                  textScaleFactor: 1.5,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text(timeslots[index],
                                                  textAlign: TextAlign.left,
                                                  textScaleFactor: 1.5,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              const Text("",
                                                  textAlign: TextAlign.start,
                                                  textScaleFactor: 1),
                                              const Text("You payed:",
                                                  textAlign: TextAlign.start,
                                                  textScaleFactor: 1.5,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              const Text("500 euros",
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
    );
  }
}
