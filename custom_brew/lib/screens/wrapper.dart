import 'package:custom_brew/screens/Authenticate/authenticate.dart';
import 'package:custom_brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_brew/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    //return either Home or Authenticate widget

    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
