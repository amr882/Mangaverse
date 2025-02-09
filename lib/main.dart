import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mangaverse/auth/view/lets_you_in.dart';
import 'package:mangaverse/auth/view/sign_in.dart';
import 'package:mangaverse/services/favorite_provider.dart';
import 'package:mangaverse/view/latest_manga.dart';
import 'package:mangaverse/view/intro_page.dart';
import 'package:mangaverse/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: FirebaseAuth.instance.currentUser == null
                ? const IntroPage()
                : const CustomBottomNavigationBar(),
            routes: {
              'letsYouIn': (context) => const LetsYouIn(),
              'SignIn': (context) => const SignIn(),
              "LatestManga": (context) => const LatestMangaPage(),
              "nav": (context) => const CustomBottomNavigationBar()
            });
      },
    );
  }
}
