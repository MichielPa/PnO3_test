import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pno3/main%20app.dart';
import 'package:pno3/sign up.dart';
import 'package:pno3/forgotPassword.dart';
import 'package:pno3/MyApp.dart';
import 'package:pno3/loginBackEnd.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// following function allows us to start the app
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// this is for the connection

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // allows you to use the text entered in a text field as a variable
  final formKey = GlobalKey<FormState>();

  final storage = const FlutterSecureStorage();
  // we use this to store our email/password when logging in so we don't need to
  //log in everytime we open the app
  bool isChecked = false;
  // this is needed for the "remember me"
  Future<void> _readFromStorage() async{
    mailController.text = await storage.read(key: "KEY_EMAIL") ?? "";
    passwordController.text = await storage.read(key: "KEY_PASSWORD") ?? "";
    // at the end we check if it's a string
  }
  @override
  void initState(){
    super.initState();
    _readFromStorage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // this widget decides the lay-out of the app
        appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text("SMARK")),
        // the app bar is the top part of the app
        body: Padding(
            // the main part of the app, padding is a widget that helps with
            // keeping the lay out clean and makes everything the same scale
            padding: const EdgeInsets.all(10),
            // makes sure everything is a distance of 10 pixels from eachother
            // and the edges of the screen
            child: ListView(
              children: <Widget>[
                // gives a list of widgets
                Container(
                    // container widgets allows us to take a limited part of the screen
                    // and putt something inside it, here that is the title
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset('images/smark logo.jpg')),
                Container(
                  // here you can write your email, the next text fields are
                  // mostly the same code
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    // a place to write in
                    controller: mailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  // the textfield for your password
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Form(
                    key: formKey,
                    // textformfields need a key so we can recall them later
                    child: TextFormField(
                        obscureText: true,
                        // changes the symbols in circles after typing them
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (_) =>
                            'Login failed, password or email is incorrect'
                        // this validator if the password matches up with the
                        // correct password of the email
                        ),
                  ),
                ),
                Row(
                    children: <Widget>[
                      const Text("Remember me"),
                      Checkbox(value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          })
                    ]
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const ForgotPassword();
                      //the navigator function makes you go to a new page
                      // you can see pages as layers, push adds a new page/layer
                      // on top of the previous ones (so you can still return
                      // to the previous pages)
                    }));
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
                LoginButton(
                    storage: storage,
                    isChecked: isChecked,
                    formKey: formKey,
                    mailController: mailController,
                    passwordController: passwordController),
                Row(
                  // row places the coming widgets next to each other
                  // (column places them beneath each other)
                  // following code is for a sentence with a button to create
                  // an account when you don't have one
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Need an account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const SignUpPage();
                          // makes you go to the sign up page when pressing the button
                        })
                        ); //signup screen
                      },
                    )
                  ],
                ),
              ],
            )
        )
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key? key,
    required this.formKey,
    required this.mailController,
    required this.passwordController,
    required this.isChecked,
    required this.storage
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final bool isChecked;
  final storage;
  @override
  State<LoginButton> createState() => _LoginButtonState();
}
class _LoginButtonState extends State<LoginButton> {
  var loginButtonText = 'LOGIN';
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,WidgetRef ref,_){
        return Container(
          // the button to log in
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
                child: Text(loginButtonText),
                onPressed: () async{
                  setState((){
                    loginButtonText= "Loading...";
                  });
                  setState((){
                    currentIndex = 1;
                  });
                  // async means this function needs to wait on something
                  // from the back end (it won't run synchronous, in order)
                  // we change the providers to this for the account page
                  final form = widget.formKey.currentState!;
                  final loginResult = await requestLogin(widget.mailController.text, widget.passwordController.text);
                  // await means we wait in this class for the back end
                  // to send a value, but other classes can continue
                  if(widget.isChecked == true){
                    await widget.storage.write(key: "KEY_EMAIL", value: widget.mailController.text);
                    await widget.storage.write(key: "KEY_PASSWORD", value: widget.passwordController.text);
                  }
                  ref.read(loginProvider.notifier).state = loginResult;
                  // this changes loginResult to your new value
                  form.validate();
                  // if your password is wrong it'll show an error on the screen
                  setState((){
                    loginButtonText= "LOGIN";
                  });
                }
            )
        );
      }
    );
  }
}
