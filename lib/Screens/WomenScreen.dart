import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AllProductScreen.dart';
import 'DisplayFullProduct.dart';

class WomenScreen extends StatefulWidget {
  const WomenScreen({Key? key}) : super(key: key);

  @override
  State<WomenScreen> createState() => _WomenScreenState();
}

class _WomenScreenState extends State<WomenScreen> {
  CollectionReference kProduct = FirebaseFirestore.instance
      .collection('Products')
      .doc('Women')
      .collection('subtype')
      .doc('Kurtis')
      .collection('KurtisProduct');
  CollectionReference braProduct = FirebaseFirestore.instance
      .collection('Products')
      .doc('Women')
      .collection('subtype')
      .doc('Bra')
      .collection('BraProduct');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
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
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 390,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Women Kurtis",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllProductScreen(doc:'Kurtis',id:'KurtisProduct',gender: 'Women')));
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xFFf16c83),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    StreamBuilder(
                      stream: kProduct.limit(4).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return Expanded(
                            child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(8.0),
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 20.0,
                                crossAxisCount: 2,
                                childAspectRatio: 2.5 / 2,
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map(
                                      (e) =>GestureDetector(onTap:(){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayFullProduct(
                                                        doc: 'Kurtis',
                                                        id: 'KurtisProduct',
                                                        gender: 'Women',
                                                        pId:
                                                        e['ProductId'])));
                                      },child: Image.network(e['ProductPicUrl'])),
                                )
                                    .toList()
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 390,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Women Bra",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProductScreen(doc:'Bra',id: 'BraProduct',gender: 'Women')));
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xFFf16c83),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    StreamBuilder(
                      stream: braProduct.limit(4).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return Expanded(
                            child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(8.0),
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 20.0,
                                crossAxisCount: 2,
                                childAspectRatio: 2.5 / 2,
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map(
                                      (e) => GestureDetector(onTap:(){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayFullProduct(
                                                        doc: 'Bra',
                                                        id: 'BraProduct',
                                                        gender: 'Women',
                                                        pId:
                                                        e['ProductId'])));
                                      },child: Image.network(e['ProductPicUrl'])),
                                )
                                    .toList()),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                color: Colors.white,
                width: double.infinity,
                height: 150,
                child: Image.network(
                    'https://hotdealszone.com/wp-content/uploads/2018/10/flipkart-axis-cards-offer.png')),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 390,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Women Bra",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProductScreen(doc:'Bra',id: 'BraProduct',gender: 'Women')));
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xFFf16c83),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    StreamBuilder(
                      stream: braProduct.limit(4).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return Expanded(
                            child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(8.0),
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 20.0,
                                crossAxisCount: 2,
                                childAspectRatio: 2.5 / 2,
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map(
                                      (e) => GestureDetector(onTap:(){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayFullProduct(
                                                        doc: 'Bra',
                                                        id: 'BraProduct',
                                                        gender: 'Women',
                                                        pId:
                                                        e['ProductId'])));
                                      },child: Image.network(e['ProductPicUrl'])),
                                )
                                    .toList()),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],

        ),
      )
    );
  }
}
