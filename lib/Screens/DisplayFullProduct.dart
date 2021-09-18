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
      appBar: AppBar(

      ),
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
    return Column(

      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
              width: double.infinity,
              height: 460,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Center(child: Image.network(product['ProductPicUrl'],height: 350,)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(product['ProductName'],style: TextStyle(fontSize: 14,color: Colors.grey[500],fontWeight: FontWeight.w600),),
                  SizedBox(
                    height: 8,
                  ),
                  Text(product['ProductSellingPrice'],style: TextStyle(fontSize:24,fontWeight: FontWeight.w600),)
                ],
                ),
              ),
          ),
        )

      ],
    );
  }
}
