import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SearchPage extends StatefulWidget{

  String? searchTo;
  SearchPage({required this.searchTo});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  dynamic listSearched;
  dynamic productsDetails;


  @override
  void initState(){
    setState((){
      _loadSearch();
    });
    }
  void _loadSearch() async{
    String url="https://www.apollopharmacy.in/_next/data/1654626814708/search-medicines/${widget.searchTo}.json?text=${widget.searchTo}";
    http.Response reponce = await http.get(Uri.parse(url));
    if(reponce.statusCode==200){
      setState((){
        listSearched=jsonDecode(reponce.body);
        productsDetails=listSearched["pageProps"]["productsDetails"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index)=>ListTile(
                    title: Text("${productsDetails[index]["id"]} => " "${productsDetails[index]["name"]}"),
                  ),
                  separatorBuilder: (context, index)=> Divider(height: 3, color: Colors.deepOrange),
                  itemCount: productsDetails==null?0:productsDetails.length)
            ],
          ),
        ),
      ),
    );
  }
}

