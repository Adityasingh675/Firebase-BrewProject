import 'package:brewi_crew/authenticate/authenticate.dart';
import 'package:brewi_crew/home/home.dart';
import 'package:brewi_crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Userdata>(context);
    print(user);
    // Return either home or authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
