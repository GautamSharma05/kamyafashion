import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:kamyafashion/Screens/AllProductScreen.dart';
import 'package:kamyafashion/Widgets/MenCarousel.dart';

import 'DisplayFullProduct.dart';

class MensScreen extends StatefulWidget {
  const MensScreen({Key? key}) : super(key: key);

  @override
  _MensScreenState createState() => _MensScreenState();
}

class _MensScreenState extends State<MensScreen> {
  CollectionReference tProduct = FirebaseFirestore.instance
      .collection('Products')
      .doc('Men')
      .collection('subtype')
      .doc('Tshirt')
      .collection('TshirtProduct');
  CollectionReference sProduct = FirebaseFirestore.instance
      .collection('Products')
      .doc('Men')
      .collection('subtype')
      .doc('Shirt')
      .collection('ShirtProduct');
  CollectionReference lowerProduct = FirebaseFirestore.instance
      .collection('Products')
      .doc('Men')
      .collection('subtype')
      .doc('Lower')
      .collection('LowerProduct');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          // Container(
          //     color: Colors.white,
          //     width: double.infinity,
          //     height: 150,
          //     child:
          //     Image.network(
          //         'https://assets.myntassets.com/f_webp,w_980,c_limit,fl_progressive,dpr_2.0/assets/images/2021/9/16/b46f4fec-c7f4-445c-8ed3-9be64cecf02a1631802152070-Weekend-sale_DK.jpg')),
          MenCarousel(),
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
                                  'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/25/a88b9390-5adb-493b-a1b3-702c59ccf53a1598348260502-Nike.jpg',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image:
                                  'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/25/c9f66558-feab-4d76-aa3c-adc68d81dce21598348260415-Levis.jpg',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image:
                                  'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/5/178c1e5d-69f2-402f-a2a5-ef44700a0f691596640983793-Roadster---.jpg',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image:
                                  'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/25/085719b1-c71e-4f47-950c-9a6b7f291fac1598348260370-Jack-_-Jones.jpg',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image:
                                  'https://assets.myntassets.com/f_webp,w_196,c_limit,fl_progressive,dpr_2.0/assets/images/2020/8/5/774f42c4-f459-4514-9b90-cf8a60a5f68c1596644478087-hrx30.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        "Men's Shirts",
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
                                      doc: 'Shirt', id: 'ShirtProduct', gender: 'Men')));
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
                    stream: sProduct.limit(4).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                                builder: (context) => DisplayFullProduct(
                                                    doc: 'Shirt',
                                                    id: 'ShirtProduct',
                                                    gender: 'Men',
                                                    pId: e['ProductId'])));
                                      },
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/images/loading.gif',
                                        image: e['ProductPicUrl'][0],
                                      ),
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
                        "Men's Lower",
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
                                      doc: 'Lower', id: 'LowerProduct', gender: 'Men')));
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
                    stream: lowerProduct.limit(4).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                                builder: (context) => DisplayFullProduct(
                                                    doc: 'Lower',
                                                    id: 'LowerProduct',
                                                    gender: 'Men',
                                                    pId: e['ProductId'])));
                                      },
                                      child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/images/loading.gif',
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
