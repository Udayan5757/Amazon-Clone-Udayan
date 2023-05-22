import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/stars.dart';
import 'package:flutter_amazon_clone/models/product.dart';

class SerachedProduct extends StatelessWidget {
  final Product product;
  const SerachedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
     double totalRating = 0;
    for(int i=0;i<product.rating!.length;i++){
      totalRating+=product.rating![i].rating;
    }
    double avgRating=0;
    if(totalRating!=0){
      avgRating = totalRating/product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(children: [
            SizedBox(
              height: 135,
              width: 135,
              child: Image.network(
                product.images[0],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.name,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Stars(
                    rating: avgRating,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\$${product.price}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10),
                  child:
                      const Text('Eligible for free Shipping'), // child: Text(
                  //   '\$${product.price}',
                  //   style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  //   maxLines: 2,
                  // ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: const Text(
                    'In Stock',
                    style: TextStyle(color: Colors.teal),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
