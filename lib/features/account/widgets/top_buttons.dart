import 'package:flutter/cupertino.dart';
import 'package:flutter_amazon_clone/features/account/screens/wishlist_screen.dart';
import 'package:flutter_amazon_clone/features/account/services/account_services.dart';
import 'package:flutter_amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter_amazon_clone/features/order_details/screens/all_orders_details_screen.dart';

import '../../../models/order.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
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
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          AccountButton(text: 'Your Orders', onTap: (){
            Navigator.pushNamed(context, AllOrderDetailsScreen.routeName,);
          },),
          AccountButton(text: 'Turn Seller', onTap: () {}),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          AccountButton(
            text: 'Log Out',
            onTap: () => AccountServices().logOut(context),
          ),
          AccountButton(text: 'Your WishList', onTap: (){
            Navigator.pushNamed(context, WishListScreen.routeName,);
          }),
        ],
      ),
    ]);
  }
}
