import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kamyafashion/Widgets/WomenCarousel.dart';
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
  CollectionReference nightSuitProduct = FirebaseFirestore.instance
      .collection('Products')
      .doc('Women')
      .collection('subtype')
      .doc('NightSuit')
      .collection('NightSuitProduct');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          WomenCarousel(),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            //height: 105,
            child: Image.network(
                'https://assets.myntassets.com/f_webp,w_980,c_limit,fl_progressive,dpr_2.0/assets/images/2021/9/24/a6ae8a21-c3cb-43c6-8fb2-d16878c337ec1632491529662-Download-App--Logo-with-Dates----Desktop.jpg'),
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
                    Text(
                      "EXPLORE TOP BRANDS",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image:
                                    'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/25/f6e40444-b1a4-4c91-bb3c-fe213356e7de1598348260541-Only.jpg',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image:
                                    'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/5/a6de806a-b58b-460b-97fd-d78d80eab39b1596641021693-Women-s-Ethnic-Wear_Anouk.jpg',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image:
                                    'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/25/8d13b55d-a6a0-40ae-b39f-16f43e7911681598348260460-MAC.jpg',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image:
                                    'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/25/046ab589-87d5-4afa-8ab3-10e06fdbe6a61598348260596-W.jpg',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image:
                                    'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/25/f2fdda02-423c-4f11-8f1b-618ba807e5841598348260323-H_M.jpg',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProductScreen(
                                      doc: 'Bra',
                                      id: 'BraProduct',
                                      gender: 'Women')));
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
                                    (e) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayFullProduct(
                                                        doc: 'Bra',
                                                        id: 'BraProduct',
                                                        gender: 'Women',
                                                        pId: e['ProductId'])));
                                      },
                                      child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/loading.gif',
                                          image: e['ProductPicUrl'][0]),
                                    ),
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
                        "Women NightSuit",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProductScreen(
                                      doc: 'NightSuit',
                                      id: 'NightSuitProduct',
                                      gender: 'Women')));
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
                    stream: nightSuitProduct.limit(4).snapshots(),
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
                                    (e) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayFullProduct(
                                                        doc: 'NightSuit',
                                                        id: 'NightSuitProduct',
                                                        gender: 'Women',
                                                        pId: e['ProductId'])));
                                      },
                                      child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/loading.gif',
                                          image: e['ProductPicUrl'][0]),
                                    ),
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
    ));
  }
}
