import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/order_details/widgets/order_format.dart';

import '../../../constants/global_variables.dart';
import '../../../models/order.dart';
import '../../account/services/account_services.dart';
import '../../search/screens/search_screen.dart';

class AllOrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/all-orders-screen';
  const AllOrderDetailsScreen({super.key});

  @override
  State<AllOrderDetailsScreen> createState() => _AllOrderDetailsScreenState();
}

class _AllOrderDetailsScreenState extends State<AllOrderDetailsScreen> {
  List<Order>? orders = [];
  bool flag = false;
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
    setState(() {
      flag=true;
    });
  }

  void navigateToSearchPage(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchPage,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.search,
                                  color: Colors.black, size: 23),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ]),
        ),
      ),
      body: flag == false
          ? const Center(child: CircularProgressIndicator(color: Colors.blue,))
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                return OrderFormat(order: orders![index]);
              },
            ),
    );
  }
}
