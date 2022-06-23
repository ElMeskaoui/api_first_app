import 'dart:convert';

import 'package:api_first_app/pages/product/productPage.dart';
import 'package:api_first_app/pages/product2/productPage2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesPage extends StatefulWidget{

  int? id;
  CategoriesPage({required this.id});


  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  dynamic listSearchedproducts;
  dynamic productsDetails;


  @override
  void initState(){
    setState((){
      _loadSearch();
    });
  }
  Future<dynamic>  _loadSearch() async{
    String url="https://theparapharmacy.ca/api/1/categories/${widget.id}/products";
    print(url);
    http.Response reponce = await http.get(Uri.parse(url));
    if(reponce.statusCode==200){
      setState((){
        listSearchedproducts=jsonDecode(reponce.body);
      });
    }
    return listSearchedproducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("categories")),
      body: FutureBuilder(
        future: _loadSearch(),
        builder:
            (BuildContext context, AsyncSnapshot usnapshot) {
          if (usnapshot.hasData) {
            return Center(
              child:SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index)=>Container(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context)=>ProductPage(id:listSearchedproducts[index]['id'],)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                      child:CircleAvatar(
                                        backgroundImage: NetworkImage('${listSearchedproducts[index]["languages"]["fr"]["poster"]["prototype"]}'),
                                      ),),
                                    SizedBox(width: 18,),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text("${listSearchedproducts[index]["languages"]["fr"]["name"]}",style: TextStyle(fontSize: 15 ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        separatorBuilder: (context, index)=> Divider(height: 9, color: Colors.deepOrange),
                        itemCount: listSearchedproducts==null?0:listSearchedproducts.length)
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
      ),
    );
  }
}

