import 'package:flutter/material.dart';
import 'package:mangaverse/auth/servers/auth_server.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  signOut() async {
    AuthServer.signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        onPressed: signOut,
        color: Colors.red,
        child: Text("sign out"),
      )),
    );
  }
}
