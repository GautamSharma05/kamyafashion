import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DisplayFullProduct.dart';

class AllProductScreen extends StatefulWidget {
  final String id;
  final String doc;
  final String gender;
  AllProductScreen({required this.doc, required this.id, required this.gender});

  @override
  _AllProductScreenState createState() =>
      _AllProductScreenState(doc, id, gender);
}

class _AllProductScreenState extends State<AllProductScreen> {
  String id, doc, gender;
  _AllProductScreenState(this.doc, this.id, this.gender);

  @override
  Widget build(BuildContext context) {
    CollectionReference allProducts = FirebaseFirestore.instance
        .collection('Products')
        .doc(gender)
        .collection('subtype')
        .doc(doc)
        .collection(id);
    return Scaffold(
        appBar: AppBar(
          title: Text('All ${widget.doc}'),
        ),
        body: StreamBuilder(
          stream: allProducts.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(8.0),
                childAspectRatio: 2.2 / 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: snapshot.data!.docs
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DisplayFullProduct(
                                        doc: doc,
                                        id: id,
                                        gender: gender,
                                        pId: e["ProductId"])));
                          },
                          child: Container(
                            color: Colors.white,
                            height: 450,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/loading.gif',
                                        image: e['ProductPicUrl'][0],
                                        height: 150)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    e['ProductName'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Text(
                                    '₹ ' + e['ProductSellingPrice'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Text(
                                    'Free Delivery',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFf16c83)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
