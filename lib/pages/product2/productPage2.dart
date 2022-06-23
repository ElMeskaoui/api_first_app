import 'dart:convert';
import 'package:image_network/image_network.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ProductPage2 extends StatefulWidget{

  String? url_key;
  ProductPage2({required this.url_key});

  @override
  State<ProductPage2> createState() => _ProductPage2State();
}

class _ProductPage2State extends State<ProductPage2> {

  dynamic product;
  dynamic productSub;
  dynamic productcros;



  @override
  void initState(){
    setState((){
      _loadProduct();
    });

  }
  Future<dynamic> _loadProduct() async{
    String url="https://www.apollopharmacy.in/_next/data/1655835583810/otc/${widget.url_key}.json?doNotTrack=true&sku=${widget.url_key}";
    http.Response reponce = await http.get(Uri.parse(url));
    if(reponce.statusCode==200){
      setState((){
        product=jsonDecode(reponce.body);
        productSub=product["pageProps"]["productDetails"]["productSubstitutes"]["products"];
        productcros=product["pageProps"]["productDetails"]["crosssell_products"];
      });
    }
    return jsonDecode(reponce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product ${widget.url_key}",)),
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
                                  'https://newassets.apollo247.com/pub/media/${product["pageProps"]["productDetails"]["productdp"][0]["small_image"]}'
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
                                child: Text("${product["pageProps"]["productDetails"]["productdp"][0]["name"]}",
                                    style: TextStyle(fontSize: 30,
                                        fontFamily: "VarelaRound")),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 310),
                                child: Text("${product["pageProps"]["productDetails"]["productdp"][0]["price"]}\$",
                                  style: TextStyle(fontSize: 20,
                                      color: Colors.amber,
                                      fontFamily: "VarelaRound"),),
                              ),if(productSub!=null) Container(
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
                                              child: Text("Substitutes Products:", style: TextStyle(fontSize: 20,fontFamily: "Amiri", ),
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
                                                              (context)=>ProductPage2(url_key:productSub[index]['url_key'],)));
                                                    },
                                                    child: Card(
                                                      color: Colors.amberAccent,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(40.0),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Center(child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage('https://newassets.apollo247.com/pub/media/${productSub[index]['thumbnail']}'),
                                                            ),
                                                            Text("${productSub[index]["name"]}"),
                                                          ],
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                itemCount: productSub==null?0:productSub.length),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ],

                                  ),
                                ),
                              ),
                              //----------------------------------------------------------------------------0000crosssell_products


                              //-------------------------------------------------------------------------------------000000000000Substitutes Products
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Description:", style: TextStyle(fontSize: 20,fontFamily: "Amiri", ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0,left: 24.0, top: 10),
                                child: Container(
                                  child: Text("${product["pageProps"]["productDetails"]["productdp"][0]["description"]}",
                                    style: TextStyle(fontSize: 19,
                                        color: Colors.black87,
                                        fontFamily: "Amiri"),),
                                ),
                              ),
                              //=------------------------------------------------------crosssell_products--------------------------
                              if(productcros!=null) Container(
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
                                              child: Text("Crosssell Products:", style: TextStyle(fontSize: 20,fontFamily: "Amiri", ),
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
                                                              (context)=>ProductPage2(url_key:productcros[index]['url_key'],)));
                                                    },
                                                    child: Card(
                                                      color: Colors.amberAccent,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(40.0),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Center(child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage('https://newassets.apollo247.com/pub/media/${productSub[index]['thumbnail']}'),
                                                            ),
                                                            Text("${productcros[index]["name"]}"),
                                                          ],
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                itemCount: productcros==null?0:productcros.length),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ],

                                  ),
                                ),
                              ),
                              //--------------------------------------------------------------000000productSub
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
                child: Center(
                  child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),),);
            }
          },
        )
    );
  }


}




