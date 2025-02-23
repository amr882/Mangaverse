import 'package:flutter/material.dart';
import 'package:mangaverse/auth/servers/auth_server.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        onPressed: () async {
          AuthServer.signOut(context);
        },
        color: Colors.green,
        child: Text(
          "sign out",
          style: TextStyle(color: Colors.white,fontSize: 50),
        ),
      )),
    );
  }
}
