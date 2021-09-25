import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class KidsCarousel extends StatefulWidget {
  const KidsCarousel({Key? key}) : super(key: key);

  @override
  _KidsCarouselState createState() => _KidsCarouselState();
}

class _KidsCarouselState extends State<KidsCarousel> {
  int activeIndex = 0;
  var document = FirebaseFirestore.instance.collection("Kids").doc('Sliders');
  List<dynamic> urlImages = [];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 350,
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
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          CarouselSlider.builder(
                              itemCount: urlImages.length,
                              itemBuilder: (context, index, realIndex) {
                                final urlImage = urlImages[index];
                                return buildImage(urlImage);
                              },
                              options: CarouselOptions(
                                  height: 350.0,
                                  aspectRatio: 16 / 9,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 0.9,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 4),
                                  onPageChanged: (index, reason) {
                                    // setState(() => activeIndex = index),
                                  },
                                  autoPlayCurve: Curves.easeInOut,
                                  enlargeCenterPage: true)),
                          //const SizedBox(height: 32),
                          // buildIndicator(),
                        ],
                      );
                    }),
              ),
            ],
          );
        } else {
          return Image.network(
              'https://s3-ap-southeast-1.amazonaws.com/urbanclap-prod/images/growth/luminosity/1614591609525-df202d.jpeg');
        }
      }),
    );
  }
  Widget buildImage(String urlImage) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        image: DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.fill),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: urlImages.length,
  );
}
