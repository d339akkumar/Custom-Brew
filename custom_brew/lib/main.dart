import 'package:custom_brew/models/user.dart';
import 'package:custom_brew/screens/wrapper.dart';
import 'package:custom_brew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null, // Set initial data according to your requirements
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
