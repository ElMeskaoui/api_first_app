import 'dart:convert';
import 'package:api_first_app/pages/categories/categories.page.dart';
import 'package:api_first_app/pages/product2/productPage2.dart';
import 'package:image_network/image_network.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ProductPage extends StatefulWidget{

  int? id;
  ProductPage({required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  dynamic product;
  dynamic productCat;


  @override
  void initState(){
    setState((){
      _loadProduct();
    });

  }
  Future<dynamic> _loadProduct() async{
    String url="https://theparapharmacy.ca/api/1/products/${widget.id}";
    http.Response reponce = await http.get(Uri.parse(url));
    if(reponce.statusCode==200){
      setState((){
        product=jsonDecode(reponce.body);
        productCat=product["categories"];
      });
    }
    return product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product ${widget.id}",)),
      body:FutureBuilder(
        future: _loadProduct(),
        builder:
            (BuildContext context, AsyncSnapshot usnapshot) {
          if (usnapshot.hasData) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                '${product["languages"]["fr"]["poster"]["prototype"]}'
                            ),
                            fit: BoxFit.contain
                        ),
                      ),
                      // child: Image.network(product["languages"]["fr"]["poster"]["prototype"], height: 100,),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.2),
                                offset: Offset(0,-4),
                                blurRadius: 8,
                              )
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0,top: 10, right: 10, bottom: 20),
                              child: Text("${product['languages']['fr']['name']}",
                                  style: TextStyle(fontSize: 30,
                                      fontFamily: "VarelaRound")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 310),
                              child: Text("${product['formats'][0]['pricer']['prices']['ListPrice']['value']}\$",
                                style: TextStyle(fontSize: 20,
                                    color: Colors.amber,
                                    fontFamily: "VarelaRound"),),
                            ),

                            //-------------------------------------------------------categories-----------------------------
                            if(productCat.length>=1) Container(
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                              padding: EdgeInsets.all(15),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: <Widget>[ SizedBox(
                                    height: 130,
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Categories:", style: TextStyle(fontSize: 20,fontFamily: "Amiri", ),
                                            )),
                                        Expanded(
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index)=>Container(
                                                margin: EdgeInsets.all(6),
                                                height: 150,
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder:
                                                            //------------------------------------=====
                                                            (context)=>CategoriesPage(id:productCat[index]['id'],)));
                                                  },
                                                  child: Card(
                                                    color: Colors.amberAccent,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Center(child: Row(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.center,
                                                              child: Text("${productCat[index]["localization"]["name"]}")),
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              itemCount: productCat==null?0:productCat.length),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ],

                                ),
                              ),
                            ),

                            //-----------------------------------------------------------------------------------------------
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0,left: 24.0, top: 10),
                              child: Container(
                                child: Text("${product["languages"]["fr"]["description"]}",
                                  style: TextStyle(fontSize: 19,
                                      color: Colors.black87,
                                      fontFamily: "Amiri"),),
                              ),
                            )
                          ],

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              width: double.infinity,
              child:Center(child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),),);
          }
        },
      )
    );
  }


}




