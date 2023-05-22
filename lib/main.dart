
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter_amazon_clone/constants/Loading_screen.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/loader.dart';
import 'package:flutter_amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter_amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:flutter_amazon_clone/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_amazon_clone/router.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  String? token='';
  bool? res=false;
  @override
  void initState() {
    super.initState();
    tryAutoLogin();
  }
  Future<bool?> tryAutoLogin() async {
    res = await authService.getUserData(context: context);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRouting(settings),
      home:Provider.of<UserProvider>(context).user.token.isNotEmpty?
        (Provider.of<UserProvider>(context).user.type=='user'? const BottomBar():const AdminScreen()):
      FutureBuilder(
          future: tryAutoLogin(),
          builder: (ctx,authResultSnapshot) =>
          authResultSnapshot.connectionState==ConnectionState.waiting? const LoadingScreen(): const AuthScreen(),
      ),
      // home:  Provider.of<UserProvider>(context).user.token.isNotEmpty?
      // (Provider.of<UserProvider>(context).user.type=='user'? const BottomBar()
      // :const AdminScreen())
      // :const AuthScreen(),
      routes: {
        AuthScreen.routeName:(ctx) => const AuthScreen(),
        //HomeScreen.routeName:(ctx) => const HomeScreen(),
        BottomBar.routeName:(ctx) => const BottomBar(),
        AddProductScreen.routeName:(ctx) => const AddProductScreen(),
      },
    );
  }
}
