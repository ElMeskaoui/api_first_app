import 'package:api_first_app/pages/home/homePage.dart';
import 'package:api_first_app/pages/product/productPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context)=>HomePage(),
        "/product":(context)=>ProductPage(id: null,)
      },
      initialRoute: "/",

    );
  }
}
