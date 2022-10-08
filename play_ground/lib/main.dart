import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_ground/screens/post_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayGround',
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.amberAccent,
        ),
        primarySwatch: Colors.blueGrey,
        fontFamily: GoogleFonts.tajawal().fontFamily,
      ),
      home: PostsList(),
    );
  }
}
