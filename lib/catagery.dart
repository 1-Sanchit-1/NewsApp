import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'models.dart';

class catagery extends StatefulWidget {
  // const catagery({Key? key}) : super(key: key);
  String nav;
  catagery({required this.nav});
  @override
  State<catagery> createState() => _catageryState();
}

class _catageryState extends State<catagery> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsbyQuery(widget.nav, navv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("NEWS" , style: TextStyle(
            color: Colors.tealAccent,
          ),) ,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.nav,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: isLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                       physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: navv.length,
                        itemBuilder: (context, index) {
                          try {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: InkWell(
                                onTap: () {},
                                child: Card(
                                  elevation: 02,
                                  shape: RoundedRectangleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              navv[index].newsImg,
                                              fit: BoxFit.cover,
                                            )),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Column(children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.black12
                                                          .withOpacity(0),
                                                      Colors.black,
                                                    ]),
                                              ),
                                              child: Text(
                                                navv[index].newsHead,
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.black12
                                                          .withOpacity(0),
                                                      Colors.black,
                                                    ]),
                                              ),
                                              child: Text(
                                                navv[index]
                                                    .newsDec
                                                    .substring(0, 100),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            return Container();
                          }
                        },
                      ),
              ),
            ]),
          ),
        ));
  }
}
