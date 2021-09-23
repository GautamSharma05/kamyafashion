import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kamyafashion/Screens/CartScreen.dart';
import 'package:kamyafashion/Widgets/QuantityCounter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(Icons.shopping_bag_outlined)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget displayProduct(context, snapshot) {
    final product = snapshot.data!;
    var size = snapshot.data!.get('ProductSize');
    int price = int.parse(product['ProductSellingPrice']);
    List<dynamic> urlImages = snapshot.data!.get('ProductPicUrl');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = urlImages[index];
                        return buildImage(urlImage);
                      },
                      options: CarouselOptions(
                          height: 300.0,
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: true,
                          viewportFraction: 1.3,
                          autoPlay: true,
                          /*onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },*/
                          autoPlayCurve: Curves.easeInOut,
                          enlargeCenterPage: true)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    product['ProductName'],
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '₹ ' + product['ProductSellingPrice'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Free Delivery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.0, color: Colors.grey[700]),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select Size',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    for (var i in size)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            final String selectedSize = i;
                            print(selectedSize);
                          },
                          child: Container(
                            width: 65,
                            height: 30,
                            child: Text(
                              i.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey[700]),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product Details',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      product['ProductDescription'].replaceAll("\\n", "\n")),
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.55,
                          // decoration: BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Divider(
                                height: 10,
                                thickness: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Select Size',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                children: [
                                  for (var i in size)
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: 65,
                                        height: 30,
                                        child: Text(
                                          i.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey[700]),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                    ),
                                ],
                              ),
                              Divider(
                                height: 10,
                                thickness: 1,
                              ),
                              QuantityCart(price: price),
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 55), primary: Color(0xFFffffff)),
                    icon:
                        Icon(Icons.shopping_bag_outlined, color: Colors.black),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(180, 55), primary: Color(0xFFf16c83)),
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text('Buy Now')),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(urlImage) {
    return  Center(
        child: Image.network(
          urlImage,
          fit: BoxFit.fill

        ));
  }
}
