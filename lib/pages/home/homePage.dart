import 'dart:convert';
import 'package:api_first_app/pages/product/productPage.dart';
import 'package:api_first_app/pages/search/search.page.dart';
import 'package:image_network/image_network.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  dynamic bestSal;
  TextEditingController queryTextEditingController=new TextEditingController();
  ScrollController scrollController=new ScrollController();
  String query="";
  bool notVisible=false;
  @override
  void initState(){
    setState((){
      _bestSaler();
    });
  }

  Future<void> _bestSaler() async {
    String url="https://theparapharmacy.ca/api/1/products/topSellers";
    await http.get(Uri.parse(url)).then((data){
      setState((){
        this.bestSal=jsonDecode(data.body);
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      drawer: Drawer(),
      body: Center(
        child: Column(
          children: [
            //-------------------------------------------------------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      obscureText: notVisible,
                      onChanged: (value){
                        setState((){
                          this.query=value;
                        });
                      },
                      controller: queryTextEditingController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context)=>SearchPage(searchTo:query,)));
                          }, icon: Icon(
                              Icons.search
                          )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                  width: 4, color: Colors.deepOrange
                              )
                          )
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  setState((){
                    this.queryTextEditingController.clear();
                  });
                }, icon: Icon(Icons.add))
              ],
            ),
            //--------------------------------------------------------------------------------------------------
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 320,
                                      width: 300,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context)=>ProductPage(id:bestSal[index]['id'],)));
                                        },
                                        child: Card(
                                          shadowColor: Colors.black,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(32)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(32),
                                                // ignore: prefer_const_literals_to_create_immutables
                                               ),
                                            child: Column(children: [
                                                Image.network(bestSal[index]['languages']['fr']['poster']['prototype'],
                                                  height: 220,
                                                  width: 200,
                                                ),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 20.0),
                                                    child: Text(
                                                      "${bestSal[index]['languages']['fr']['name']}",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontFamily: "Andika",
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 1.5,
                                                      ),
                                                    ),
                                                  ))
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(height: 2,color: Colors.deepOrange,),
                  itemCount: bestSal==null?0:bestSal.length
              ),
            )
          ],
        ),
      ),
    );
  }
}