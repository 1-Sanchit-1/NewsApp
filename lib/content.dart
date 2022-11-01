import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'models.dart';

class Content extends StatefulWidget {


  int ind;
  Content({required this.ind});

  // const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {

  // String index ;


  bool isLoading = true;

  List<NewsQueryModel> navv = <NewsQueryModel>[];
  String? url;
  getNewsbyQuery(String query, List p) async {
    Map element;
    int i = 0;
    if (query == 'techcrunch') {
      url =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=63648439610949cab1368fbed94827eb";
    }
    url =
    "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&apiKey=63648439610949cab1368fbed94827eb";
    Response response = await get(Uri.parse(url!));
    Map data = jsonDecode(response.body);
    // print(data);
    setState(() {
      // data["articles"].forEach((element)
      for (element in data["articles"]) {
        try {
          i++;
          NewsQueryModel QueryModel = new NewsQueryModel();
          QueryModel = NewsQueryModel.fromMap(element);
          p.add(QueryModel);
          // print('added');
          setState(() {
            isLoading = false;
          });
          if (i == 50) break;
        } catch (e) {
          print(e);
        }
      }
      ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Content"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(

            itemBuilder: (context, ind)
          {
            return Container(
              padding: EdgeInsets.all(30),
              child: Card(
                child: Text(navv[ind].content),
              ),
            );
          }
          ,),

      )
    );
  }
}
