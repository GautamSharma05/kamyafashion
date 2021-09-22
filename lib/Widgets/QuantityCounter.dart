import 'package:flutter/material.dart';

class QuantityCart extends StatefulWidget {
  final int price;
  QuantityCart({required this.price});

  @override
  _QuantityCartState createState() => _QuantityCartState(price);
}

class _QuantityCartState extends State<QuantityCart> {
  int price;
  _QuantityCartState(this.price);
  int qty = 1;
  void add() {
    setState(() {
      qty += 1;
    });
  }

  void remove() {
    setState(() {
      if (qty > 1) {
        qty -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Quantity',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      color: Colors.grey[200],
                      child: GestureDetector(
                          onTap: () {
                            add();
                          },
                          child: Icon(Icons.add))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(child: Text('$qty')),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      color: Colors.grey[200],
                      child: GestureDetector(
                          onTap: () {
                            remove();
                          },
                          child: Icon(Icons.remove))),
                ),
              ],
            ),
          ],
        ),
        Divider(
          height: 10,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Text('₹ '+(qty * price).toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
            ],
          ),
        ),
        Divider(
          height: 10,
          thickness: 1,
        ),
      ],
    );
  }
}
