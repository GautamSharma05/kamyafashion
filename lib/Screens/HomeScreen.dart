import 'package:flutter/material.dart';
import 'package:kamyafashion/Screens/CartScreen.dart';
import 'package:kamyafashion/Screens/KidsScreen.dart';
import 'package:kamyafashion/Screens/MensScreen.dart';
import 'package:kamyafashion/Screens/WomenScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(14.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFFf16c83),
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://t4.ftcdn.net/jpg/02/14/74/61/360_F_214746128_31JkeaP6rU0NzzzdFC4khGkmqc8noe6h.jpg'),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "Men's",
              ),
              Tab(
                text: 'Women',
              ),
              Tab(text: 'Kids'),
            ],
          ),
          title: Text(
            'Kamya Fashion',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(Icons.favorite_border)),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(Icons.shopping_bag_outlined)),
          ],
          elevation: 15.0,
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              MensScreen(),
              WomenScreen(),
              KidsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
