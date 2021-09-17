import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamyafashion/Screens/LoginScreen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 82.0, left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Let's Create\nYour Own Style",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 38.0),
            child: Text(
                'Each kids,man and woman has a unique style,we help you to create your very own\nstyle beacause you deserve to shine like\na star',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: GoogleFonts.poppins().fontFamily)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    primary: Color(0xFFf16c83),
                    padding: EdgeInsets.only(
                        left: 60.0, right: 60.0, top: 12.0, bottom: 12.0)),
                child: Text('Get Started',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ))),
          ),
        ],
      ),
      bottomSheet: Image.asset('assets/images/getstartedimage.png'),
    );
  }
}
