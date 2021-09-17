import 'package:flutter/material.dart';

class WomenScreen extends StatelessWidget {
  const WomenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(
              color: Colors.white,
              width: double.infinity,
              height: 150,
              child: Image.network(
                  'https://assets.myntassets.com/f_webp,w_980,c_limit,fl_progressive,dpr_2.0/assets/images/2021/8/17/d7f67601-9c65-4556-8e8d-cf2417d261fa1629208024245-Dresses_Dk.jpg')),
          SizedBox(
            height: 20,
          ),
        ],

      )
    );
  }
}
