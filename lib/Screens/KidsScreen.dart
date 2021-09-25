import 'package:flutter/material.dart';
import 'package:kamyafashion/Widgets/KidsCarousel.dart';

class KidsScreen extends StatelessWidget {
  const KidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          KidsCarousel(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
