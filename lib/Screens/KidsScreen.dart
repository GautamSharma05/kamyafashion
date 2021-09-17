import 'package:flutter/material.dart';

class KidsScreen extends StatelessWidget {
  const KidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              color: Colors.white,
              width: double.infinity,
              height: 150,
              child: Image.network(
                  'https://assets.myntassets.com/f_webp,w_980,c_limit,fl_progressive,dpr_2.0/assets/images/2021/8/17/497f8595-8ff5-4f17-a349-e5d9e4d8dbe51629207922898-DK_Kidswear--2-.jpg')),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
