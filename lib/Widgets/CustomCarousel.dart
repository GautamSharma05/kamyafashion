import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  CustomCarousel({Key? key}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  // int activeIndex = 0;
  var document = FirebaseFirestore.instance.collection("Slider").doc('Sliders');

  List<dynamic> urlImages = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
          builder: (context, constraints) {
            if(constraints.maxWidth < 768){
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 320,
                    color: Colors.white,
                    child: FutureBuilder(
                        future: document.get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            urlImages = snapshot.data!.get('Sliders');
                          }
                          else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CarouselSlider.builder(
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
                                  enlargeCenterPage: true));
                        }),
                  ),
                ],
              );
            }
            else{
              return Image.network('https://s3-ap-southeast-1.amazonaws.com/urbanclap-prod/images/growth/luminosity/1614591609525-df202d.jpeg');
            }

        }
      ),
    );
  }

  Widget buildImage(String urlImage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        image: DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.fill),
      ),
    );
  }
}
