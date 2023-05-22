import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/account/screens/wishlist_screen.dart';
import 'package:flutter_amazon_clone/features/address/screens/address_screen.dart';
import 'package:flutter_amazon_clone/features/order_details/screens/all_orders_details_screen.dart';
import 'package:flutter_amazon_clone/features/order_details/screens/order_details.dart';
import 'package:flutter_amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter_amazon_clone/models/order.dart';
import 'package:flutter_amazon_clone/models/product.dart';

import 'features/home/screens/category_deals_screen.dart';

Route<dynamic> generateRouting(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(
          order: order,
        ),
      );
    case AllOrderDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllOrderDetailsScreen(),
      );
    case WishListScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WishListScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${routeSettings.name}'),
          ),
        ),
      );
  }
}
