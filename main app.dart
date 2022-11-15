import 'package:flutter/material.dart';
import 'package:pno3/login.dart';
import 'package:pno3/accountpage extra.dart';

var password = 'password';
var email = 'test@gmail.com';
var license = '1-ABC-123';
var license2= '1-BCG-852';
List<String> timeslots = [
  "00:00 - 02:00", "02:00 - 04:00", "04:00 - 06:00", "08:00 - 10:00", "10:00 - 12:00",
  "12:00 - 14:00", "14:00 - 16:00", "16:00 - 18:00", "18:00 - 20:00", "20:00 - 22:00",
  "22:00-00:00"
];
Set<String> plates = {license, license2}; // set so you can't have double plates
// temporary variables
// license plate voor de account pagina misschien in een lijst zetten om zo meerdere
// te kunnen gebruiken

// manier vinden om een pagina te herladen zodat we de change email enzo pagina's
// boven de account pagina kunnen maken zodat we die gewoon kunnen poppen en niet
// replacen

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
    return MaterialApp( // MaterialApp is the app itself, so this functions
      // returns the app, everything inside is building the app
      debugShowCheckedModeBanner: false, // remove the "debug-banner"
      home: Scaffold( // the lay-out of the app
          appBar: AppBar(
            centerTitle: true,
            title: const Text('SMARK'),
          ),
          body: Center( // inside this widget are multiple if-statements which
            // make sure the lay-out switches when changing page,
            // we use the index of the pages for this
            child: currentIndex == 0
                ? SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView(children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Account information',
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
                    // how much space there is between containers
                    child: TextField(
                      enabled: false, // makes sure you can't change the text
                      controller: TextEditingController(text: email),
                      // makes the text inside the text field correspond
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
                     margin: const EdgeInsets.fromLTRB(10, 10, 10, 1),
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(6),
                         border: Border.all(color: Colors.grey, width: 0.5)),
                     // makes the edge of the box visible
                     child: DropdownButtonHideUnderline(
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
                    // change your email
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
                    ? CustomScrollView(
                        slivers: <Widget>[
                          // list of widgets
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                  return Container(
                                    height: 50,
                                      width: 200,
                                      margin: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(24.0)),
                                        ),
                                        // the last thing adds color variation
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  // A pop up that will appear with 2 options:
                                                  // yes to reserve a spot
                                                  // and no to close the pop up
                                                  content: Text(
                                                      "Are you sure you want to park during timeslot $index?"
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
                                        },
                                        child: Column(
                                            children: <Widget>[
                                          Text(timeslots[index],
                                          textAlign: TextAlign.start,

                                            style: const TextStyle(fontWeight: FontWeight.bold))
                                        ]
                                        )

                                      )
                                  );

                                },
                                childCount: 12,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                  childAspectRatio: 3
                                )
                          )
                        ],
                      )
                    : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: const [
                  Text('Hier komt de geschiedenis'),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  label: 'Account', icon: Icon(Icons.account_circle_outlined)),
              BottomNavigationBarItem(
                  label: 'Reservations',
                  icon: Icon(Icons.local_parking_rounded)),
              BottomNavigationBarItem(label: 'History', icon: Icon(Icons.feed))
            ],
            currentIndex: currentIndex, // these lines of code make sure we can
            // can change page using the navigator
            onTap: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
          )),
    );
  }
}
