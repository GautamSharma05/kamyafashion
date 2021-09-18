import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayFullProduct extends StatefulWidget {
  final String doc, id, gender, pId;
  DisplayFullProduct(
      {required this.doc,
      required this.id,
      required this.gender,
      required this.pId});

  @override
  _DisplayFullProductState createState() =>
      _DisplayFullProductState(doc, id, gender, pId);
}

class _DisplayFullProductState extends State<DisplayFullProduct> {
  String doc, id, gender, pId;
  _DisplayFullProductState(this.doc, this.id, this.gender, this.pId);

  @override
  Widget build(BuildContext context) {
    var productsDetail = FirebaseFirestore.instance
        .collection('Products')
        .doc(gender)
        .collection('subtype')
        .doc(doc)
        .collection(id)
        .doc(pId);
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: productsDetail.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayProduct(context, snapshot);
                }

                return Center(
                  child: CircularProgressIndicator(),
                );

              })
        ],
      ),
    );
  }

  Widget displayProduct(context, snapshot) {
    final product = snapshot.data!;
    return Image.network(product['ProductPicUrl']);
  }
}
