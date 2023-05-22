import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/order.dart';

class OrderFormat extends StatelessWidget {
  final Order order;
  const OrderFormat({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < order.products.length; i++)
            Row(
              children: [
                Image.network(
                  order.products[i].images[0],
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.products[i].name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Qty: ${order.quantity[i]}',
                      ),
                      Text('Order Date: ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          order.orderedAt),
                    )}'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
