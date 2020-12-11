import 'package:contact_list_app/screens/login_screen.dart';
import 'package:contact_list_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import './screens/contact_list_screen.dart';
import './screens/add_contact_screen.dart';
import 'package:contact_list_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //Firebase need to be initialize at the start of the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ContactListScreen.id: (context) => ContactListScreen(),
        AddContactScreen.id: (context) => AddContactScreen(),
      },
    );
  }
}
