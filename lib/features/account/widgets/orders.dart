import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/account/services/account_services.dart';
import 'package:flutter_amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter_amazon_clone/features/order_details/screens/order_details.dart';

import '../../../constants/loader.dart';
import '../../../models/order.dart';
import '../../order_details/screens/all_orders_details_screen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    super.initState();
    fetchOrdes();
  }

  void fetchOrdes() async {
    orders = await accountServices.fetchMyOrders(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text('Your Orders',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600))),
                    // TextButton(onPressed: (){
                       
                    // }, child: Text('See all',
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         color: GlobalVariables.selectedNavBarColor,
                    //       ))),
                  GestureDetector(
                    onTap: (() => Navigator.pushNamed(context, AllOrderDetailsScreen.routeName,)),
                    child: Container(
                        padding: const EdgeInsets.only(
                          right: 30,
                        ),
                        child: Text('See all',
                            style: TextStyle(
                              fontSize: 15,
                              color: GlobalVariables.selectedNavBarColor,
                            ))),
                  ),
                ],
              ),
              Container(
                height: 170,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrderDetailsScreen.routeName,
                            arguments: orders![index]);
                      },
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
