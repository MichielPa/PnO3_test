import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
// this import is for the email validation function used
import 'package:pno3/main app.dart';
// the last import imports the file the main part of the app in it, we need to
// import this so we can go there after we're done with login in or signing in


var password = 'password';
var email = 'test@gmail.com';
var license = '1-ABC-123';
var verification = "1234";
var newEmail = "";
var newPass = "";
var newLic = "";
// temporary variables

// following function allows us to start the app
void main() {
  runApp(const MyApp());
}

// this class decides the general theme of the app and is always active, it also
// makes sure the first thing you see when opening the app is the login page
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp is the app itself, so this functions returns the fysical app,
      // everything inside is building the app
      debugShowCheckedModeBanner: false,
      // removes the "debug-banner"
      title: 'SMARK',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(), // makes sure the login page is the first page you see
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}
class _LoginPage extends State<LoginPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // allows you to use the text entered in a text field as a variable
  final formKey = GlobalKey<FormState>();
  // we will later need this to recall the textfields

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                        child: const Text(
                          'SMARK',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 40),
                        )),
                    Container(
                        // text saying "login"
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20),
                        )),
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
                          validator: (pass) => pass != password
                              ? 'Login failed, password or email is incorrect'
                              : null,
                          // this validator if the password matches up with the
                          // correct password of the email
                        ),
                      ),
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
                    Container(
                        // the button to log in
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                            child: const Text('LOGIN'),
                            onPressed: () {
                              final form = formKey.currentState!;
                              if (form.validate()) {
                                // checks if the validator of the formfield is fulfilled,
                                // so in this case if it's the correct password
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  // normally when you use push it adds a new page on the previous one,
                                  // but with pushReplacement it replaces the old page with a new one,
                                  // meaning you can't go back to the login page after you logged in
                                  return const MainPage();
                                }));
                              }
                            })),
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
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const SignUpPage();
                              // makes you go to the sign up page when pressing the button
                            })); //signup screen
                          },
                        )
                      ],
                    ),
                  ],
                ))));
  }
}

// the code of the sign up page is very similar to that of the login page
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();

  // this is needed for the email validator, so the if-statement in the sign in-button
  // knows which text field we're talking about

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  // a function that validate user entered password:
  bool validatePassword(String pass){
    String _password = pass.trim();
    // trim() removes a space at the start or at the end of the password
    if(_password.isEmpty){
      setState(() {
        passwordStrength = 0;
      });
    }else if(_password.length < 6 ){
      setState(() {
        passwordStrength = 1 / 4;
      });
    }else if(_password.length < 8){
      setState(() {
        passwordStrength = 2 / 4;
      });
    }else{
      if(passValid.hasMatch(_password)){
        setState(() {
          passwordStrength = 4 / 4;
        });
        return true;
      }else{
        setState(() {
          passwordStrength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  // the next functions checks if a license plate is valid, a valid password
  // license plate looks like this: 1-ABC-123
  bool validateLicense(String lic){
    if(lic.length != 9)
      {return false;}
    if (double.tryParse(lic[0]) == null)
      {return false;}
    // checking if the first symbol is a number, double.tryParse checks if it's
    // numerical (when it equal null it isn't)
    if (lic[1] != "-")
      {return false;}
    if (lic.substring(2,5).toUpperCase() != lic.substring(2,5))
      {return false;}
    // toUpperCase transforms the string in all caps, if it doesn't equal the
    // string itself, we know it's not all capital letters
    // .substring(index) allows us to verify each symbol of the string
    if (lic[5] != "-")
      {return false;}
    if (double.tryParse(lic.substring(6)) == null)
      {return false;}
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      // the title
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'SMARK',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 40),
                        )),
                    Container(
                      // text saying "sign up"
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // the field for your email
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',

                          ),
                          validator: (email) => email != null && !EmailValidator.validate(email.trim())
                          // validates if the email is a correct email address
                              ? 'Enter a valid email'
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // the field for your license plate
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey2,
                      child: TextFormField(
                        controller: licensePlateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'License Plate',
                        ),
                        validator: (lic) => lic != null && !validateLicense(lic)
                            ? 'Enter a valid license plate (f.e.: 1-ABC-123)'
                            : null,
                        // checks if it's a correct license plate
                      ),
                    ),
                    ),
                    Container(
                      // the field for your password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: formKey3,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (pass) => pass != null && !validatePassword(pass)
                              ? "Weak password"
                              : null,
                          // checks if it's a correct password
                        ),
                      ),
                    ),
                    Container(
                      // the field to repeat your password
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey4,
                        child: TextFormField(
                          obscureText: true,
                          controller: repeatPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Repeat Password',
                          ),
                          validator: (pass) => pass != passwordController.text
                              ? "Passwords don't match up"
                              : null,
                          // checks if passwords match up
                        ),
                      ),
                    ),
                    TextButton(
                      // a button which when pressed gives you a pop up with
                      // information on what a strong password should have
                      onPressed: () {
                        {
                          showDialog(
                            // makes sure the pop up is shown
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // the pop up
                                  content: const Text(
                                      "A strong password has at least 6 symbols,"
                                      "and uses alphabetical, numerical, capital"
                                      " letters and special symbols."),
                                  actions: [
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        // pop only removes this page and returns
                                        // us the previous page (page underneath)
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text(
                        'Strong Password?',
                      ),
                    ),
                    Container(
                      // the button to sign up
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('SIGN UP'),
                          onPressed: () {
                            final form = formKey.currentState!;
                            final form2 = formKey2.currentState!;
                            final form3 = formKey3.currentState!;
                            final form4 = formKey4.currentState!;
                            if (form.validate() && form2.validate() && form3.validate() && form4.validate()) {
                              newEmail = emailController.text;
                              newPass = passwordController.text;
                              newLic = passwordController.text;
                              // we temporarily remember these variables
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                return const EmailVerification();
                                // if everything is filled in correctly, only
                                // the email verification is left
                              }));
                            }
                          },
                        )
                    ),
                  ],
                )
            )
        )
    );
  }
}

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerification();
}

class _EmailVerification extends State<EmailVerification> {
  TextEditingController codeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        // text
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'We send a verification code to your mail address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // a field to write your verification code
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            controller: codeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Verification Code',
                            ),
                            validator: (code) =>
                            code != null && code.trim() != verification
                                ? 'Incorrect verification code'
                                : null,
                          ),
                        )
                    ),
                    Row(
                      // buttons to verify your email or resend the mail
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                              child: const Text(
                                'Resend Email',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {}
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  final form = formKey.currentState;
                                  if (form != null && form.validate()){
                                    email = newEmail;
                                    license = newLic;
                                    password = newPass;
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                        builder: (context) => const MainPage()), (Route route) => false);
                                    // pushAndRemoveUntil adds a new page and removes
                                    // all previous pages
                                  }
                                }
                            )
                        ),
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  TextEditingController mailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        // text
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Please enter your email address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // a field to fill in your email address
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: mailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (mail) =>
                              mail != null && mail.trim() != email
                                  ? 'This mail address does not have an account'
                                  : null,
                        ),
                      ),
                    ),
                    Row(
                      // a button
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                            child: const Text(
                              'Continue',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              final form = formKey.currentState!;
                              if (form.validate()) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const VerificationPassword();
                                }));
                              }
                            })
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}

// a page similar to the email verification page, only now it's used for when you
// you forgot your password and need to add a new one
class VerificationPassword extends StatefulWidget {
  const VerificationPassword({Key? key}) : super(key: key);

  @override
  State<VerificationPassword> createState() => _VerificationPassword();
}
class _VerificationPassword extends State<VerificationPassword> {
  TextEditingController codeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      // text
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'We send a verification code to your mail address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      // a field to write your verification code
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Verification Code',
                          ),
                          validator: (code) =>
                          code != null && code.trim() != verification
                              ? 'Incorrect verification code'
                              : null,
                        ),
                      )
                    ),
                    Row(
                      // a button
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                              child: const Text(
                                'Resend Email',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {}
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  final form = formKey.currentState;
                                  if (form != null && form.validate()){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (BuildContext context) {
                                        return const NewPass();
                                      }));}
                                }
                            )
                        ),
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}

class NewPass extends StatefulWidget {
  const NewPass({Key? key}) : super(key: key);

  @override
  State<NewPass> createState() => _NewPass();
}
class _NewPass extends State<NewPass> {
  // most of the code in this class is copied from the sign up page
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();


  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;
  bool validatePassword(String pass){
    String _password = pass.trim();
    if(_password.isEmpty){
      setState(() {
        passwordStrength = 0;
      });
    }else if(_password.length < 6 ){
      setState(() {
        passwordStrength = 1 / 4;
      });
    }else if(_password.length < 8){
      setState(() {
        passwordStrength = 2 / 4;
      });
    }else{
      if(passValid.hasMatch(_password)){
        setState(() {
          passwordStrength = 4 / 4;
        });
        return true;
      }else{
        setState(() {
          passwordStrength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,centerTitle: true,title: const Text("SMARK")),
            body: Padding(
                padding: const EdgeInsets.all(10),  // makes sure everything is the right size
                child: ListView(
                  children: <Widget>[
                    Container(
                      // the title
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Change password',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      // a field to enter your new password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          obscureText: true,
                          controller: newPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'New password',
                          ),
                          validator: (pass) => pass != null && !validatePassword(pass)
                              ? "Weak password"
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      // a field to repeat your password
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey2,
                        child: TextFormField(
                          obscureText: true,
                          controller: repeatPasswordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Repeat Password',
                          ),
                          validator: (pass) => pass != newPasswordController.text
                              ? "Passwords don't match up"
                              : null,
                        ),
                      ),
                    ),
                    TextButton(
                      // a pop up that tells you what a good password needs
                      onPressed: () {
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: const Text(
                                      "A strong password has at least 6 symbols,"
                                          "and uses alphabetical, numerical, capital"
                                          " letters and special symbols."),
                                  actions: [
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pop();
                                      },
                                    )
                                  ],
                                );
                              }
                              );
                        }
                      },
                      child: const Text(
                        'Strong Password?',
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Change password'),
                          onPressed: () {
                            final form = formKey.currentState!;
                            final form2 = formKey2.currentState!;
                            if (form.validate() && form2.validate()) {
                              password = newPasswordController.text;
                              // changes old password to the new one
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                  builder: (context) => const LoginPage()), (Route route) => false);
                            }
                          },
                        )
                    ),
                  ],
                )
            )
        )
    );
  }
}