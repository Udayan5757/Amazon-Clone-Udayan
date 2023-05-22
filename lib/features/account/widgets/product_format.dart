import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_amazon_clone/models/product.dart';

class ProductFormat extends StatelessWidget {
  final Product product;
  const ProductFormat({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 3,
          color: Colors.black12,
        ),
      ),
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, ProductDetailsScreen.routeName,
                arguments: product),
            child: Image.network(
              product.images[0],
              height: 120,
              width: 120,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                product.price.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
