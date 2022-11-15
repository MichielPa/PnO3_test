import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pno3/main app.dart';
// the last import imports the file the main part of the app in it, we need to
// import this so we can go there after we're done with loging or signing in


var password = 'password';
var email = 'test@gmail.com';
var license = '1-ABC-123';
// temporary variables

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  // allows you to use the text entered in a text field as a variable
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // the stuff in purple above is the text you write in the field (variable)

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
                    Container( // the title
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'SMARK',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 40),
                        )),
                    Container( // text saying "login"
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
                      child: TextField( // a place to write in
                        controller: mailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                      key: formKey,
                        child: TextFormField(
                        obscureText: true, // changes the symbols in circles after typing them
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                          validator: (pass) => pass != password
                              ? 'Login failed, password or email is incorrect'
                              : null,
                      ),
                    ),
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return const ForgotPassword();
                        }));
                      },
                      child: const Text('Forgot Password',),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                            child: const Text('LOGIN'),
                            onPressed: () {
                              final form = formKey.currentState!;
                                    if (form.validate()) {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
                                        // normally when you use push it adds a new page on the previous one,
                                        // but with pushReplacement it replaces the old page with a new one,
                                        // meaning you can't go back to the login page after you logged in
                                        return const MainPage();
                                      }));
                                    }
                            })),
                    Row(
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return const SignUpPage();
                              // makes you go to the sign up page when pressing the button
                            }));//signup screen
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

  // this is needed for the emailvalidator, so the if-statement in the sign in-button
  // knows which text field we're talking about

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  //A function that validate user entered password
  bool validatePassword(String pass){
    String _password = pass.trim();
    // removes a space at the start or at the end of the password
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

  // the next functions checks if a password is valid, a valid password looks
  // like this: 1-ABC-123
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
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          // TextFormField if you use validator and Form()
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',

                          ),
                          validator: (email) => email != null && !EmailValidator.validate(email.trim())
                          // .trim() makes it so it doesn't matter if there's a space
                          // before or after the email
                              ? 'Enter a valid email'
                              : null,
                        ),
                      ),
                    ),
                    Container(
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
                      ),
                    ),
                    ),
                    Container(
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
                        ),
                      ),
                    ),
                    Container(
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
                        ),
                      ),
                    ),
                    TextButton(
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
                              });
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
                          child: const Text('SIGN IN'),
                          onPressed: () {
                            final form = formKey.currentState!;
                            final form2 = formKey2.currentState!;
                            final form3 = formKey3.currentState!;
                            final form4 = formKey4.currentState!;
                            if (form.validate() && form2.validate() && form3.validate() && form4.validate()) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'We send a verification code to your mail address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        // a place to write in
                        controller: codeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Verification Code',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                            child: const Text(
                              'Resend Email',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {}) //signup screen
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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Please enter your email address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: mailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',

                          ),
                          validator: (mail) => mail != null && mail.trim() != email
                              ? 'Enter the correct email address'
                              : null,
                        ),
                      ),
                    ),
                    Row(
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
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                  return const VerificationPassword();
                                }));
                              }
                            }) //signup screen
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}

class VerificationPassword extends StatefulWidget {
  const VerificationPassword({Key? key}) : super(key: key);

  @override
  State<VerificationPassword> createState() => _VerificationPassword();
}
class _VerificationPassword extends State<VerificationPassword> {
  TextEditingController codeController = TextEditingController();

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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'We send a verification code to your mail address',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        // a place to write in
                        controller: codeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Verification Code',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                            child: const Text(
                              'Resend Email',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {}) //signup screen
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}

// wanneer je de juiste verificatie code invult, zal je naar een andere pagina worden
// gestuurd waar je je nieuwe wachtwoord 2 keer moet invullen, en hierna wordt
// je terug naar de login pagina gestuurd