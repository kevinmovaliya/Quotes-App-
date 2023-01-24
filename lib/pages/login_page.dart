import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 1,
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.black),
                ),
                children: [
                  TextSpan(text: "Hello,\n", style: TextStyle(fontSize: 16)),
                  TextSpan(
                      text: "Welcome to Quote!",
                      style: TextStyle(fontSize: 25)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
