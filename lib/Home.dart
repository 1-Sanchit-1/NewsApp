import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/catagery.dart';
import 'package:newsapp/content.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'models.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NewsQueryModel> newslist = <NewsQueryModel>[];
  List<NewsQueryModel> crousallist = <NewsQueryModel>[];

  TextEditingController ser = TextEditingController();
  List<String> list = [
    "Top News",
    "Uttar Pradesh",
    "Andhra Pradesh",
    "Assam",
    "Bihar",
    "Goa",
    "Gujarat",
    "Arunachal Pradesh",
    "Chhattisgarh",
    "Himachal Pradesh",
    "jharkhand",
    "karnataka",
    "keral",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mezoram",
    "Nagaland",
    "Odisha",
    "punjab",
    "Sikkim",
    "Tamil Nadu",
    "Telengana",
    "Tripura",
    "Uttarakhand",
    "West Bengla",
  ];

  bool isLoading = true;
  String? url;
  getNewsByQuery(String query, List p) async {
    Map element;
    int i = 0;
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
          NewsQueryModel newsQueryModel = new NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(element);
          p.add(newsQueryModel);
          // print('added');
          setState(() {
            isLoading = false;
          });
          if (i == 50) break;
        } catch (e) {
          print(e);
        }
        ;
      }
      ;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery("Aajtak", newslist);
    getNewsByQuery("India Tv", crousallist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('News' ,style: TextStyle(
          color: Colors.tealAccent
        ),),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                TextField(
                  controller: ser,
                  autocorrect: true,
                  onTap: () {
                    ser.clear();
                  },
                  onSubmitted: (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => catagery(nav: ser.text),
                        ));
                  },
                  decoration: InputDecoration(
                    label: Text("Search"),
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    catagery(nav: list[index]),
                              ));
                          // print(list[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            list[index],
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  child: isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.tealAccent,
                        )
                      : CarouselSlider(
                          options: CarouselOptions(
                            // height: MediaQuery.of(context).size.height,
                            autoPlay: true,
                            height: 220,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                          ),
                          items: crousallist.map((i) {
                            return Builder(
                              builder: (BuildContext context ,) {
                                try {
                                  return Container(
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Scaffold(
                                                    appBar: AppBar(
                                                      centerTitle: true,
                                                      title: Text("News Content",style: TextStyle(
                                                          color: Colors.tealAccent
                                                      ),),
                                                    ),
                                                    body : SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Divider(),
                                                          Text("News Image",style: TextStyle(
                                                              color: Colors.tealAccent
                                                          ),) ,
                                                          Divider(),
                                                          Container(
                                                            padding:
                                                            EdgeInsets.all(10),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(20),
                                                                child: Image.network(
                                                                  i.newsImg,
                                                                  fit: BoxFit.cover,
                                                                )),
                                                          ),
                                                          Divider(),
                                                          Text("News Link",style: TextStyle(
                                                              color: Colors.tealAccent
                                                          ),) ,
                                                          Divider(),
                                                          Container(
                                                            padding:
                                                            EdgeInsets.all(10),
                                                            child: Linkify(
                                                              text: i.newsUrl,
                                                              style: TextStyle(color: Colors.blue),
                                                              linkStyle: TextStyle(color: Colors.green),
                                                            ),
                                                          ),
                                                          Divider(),
                                                          Text("News Headline",style: TextStyle(
                                                              color: Colors.tealAccent
                                                          ),) ,
                                                          Divider(),
                                                          Container(
                                                            padding:
                                                            EdgeInsets.all(10),
                                                            child: Text(
                                                                i.newsHead),
                                                          ),
                                                          Divider(),
                                                          Text("News Description",style: TextStyle(
                                                              color: Colors.tealAccent
                                                          ),) ,
                                                          Divider(),
                                                          Container(
                                                            padding:
                                                            EdgeInsets.all(10),
                                                            child: Text(
                                                                i.newsDec),
                                                          ),
                                                          Divider(),
                                                          Text("News Author",style: TextStyle(
                                                              color: Colors.tealAccent
                                                          ),) ,
                                                          Divider(),
                                                          Container(
                                                            padding:
                                                            EdgeInsets.all(10),
                                                            child: Text(
                                                                    i.author),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                i.newsImg,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 3,
                                                left: 10,
                                                right: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.black12
                                                              .withOpacity(0),
                                                          Colors.black,
                                                        ]),
                                                  ),
                                                  child: Text(
                                                    i.newsHead,
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                  return Container();
                                }
                                ;
                              },
                            );
                          }).toList(),
                        ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Headlines",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.tealAccent,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: isLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.tealAccent,
                              )
                            : Container(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: newslist.length,
                                  itemBuilder: (context, index) {
                                    try {
                                      return Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
                                                        appBar: AppBar(
                                                          centerTitle: true,
                                                          title: Text("News Content",style: TextStyle(
                                                              color: Colors.tealAccent
                                                          ),),
                                                        ),
                                                       body : SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Divider(),
                                                        Text("News Image",style: TextStyle(
                                                            color: Colors.tealAccent
                                                        ),) ,
                                                        Divider(),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.all(10),
                                                         child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                              child: Image.network(
                                                                newslist[index]
                                                                    .newsImg,
                                                                fit: BoxFit.cover,
                                                              )),
                                                        ),
                                                        Divider(),
                                                        Text("News Link",style: TextStyle(
                                                            color: Colors.tealAccent
                                                        ),) ,
                                                        Divider(),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.all(10),
                                                          child: Linkify(
                                                            text: newslist[index].newsUrl,
                                                            style: TextStyle(color: Colors.blue),
                                                            linkStyle: TextStyle(color: Colors.green),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Text("News Headline",style: TextStyle(
                                                            color: Colors.tealAccent
                                                        ),) ,
                                                        Divider(),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.all(10),
                                                          child: Text(
                                                              newslist[index]
                                                                  .newsHead),
                                                        ),
                                                        Divider(),
                                                        Text("News Description",style: TextStyle(
                                                            color: Colors.tealAccent
                                                        ),) ,
                                                        Divider(),
                                                        Container(
                                                            padding:
                                                                EdgeInsets.all(10),
                                                            child: Text(
                                                                newslist[index]
                                                                    .newsDec),
                                                        ),
                                                        Divider(),
                                                        Text("News Author",style: TextStyle(
                                                            color: Colors.tealAccent
                                                        ),) ,
                                                        Divider(),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.all(10),
                                                          child: Text(
                                                              newslist[index]
                                                                  .author),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                      ),
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              Card(
                                                elevation: 02,
                                                shape: RoundedRectangleBorder(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.network(
                                                            newslist[index]
                                                                .newsImg,
                                                            fit: BoxFit.cover,
                                                          )),
                                                      Positioned(
                                                        bottom: 8,
                                                        left: 0,
                                                        right: 9,
                                                        child:
                                                            Column(children: [
                                                          Card(
                                                            elevation: 0,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  colors: [
                                                                    Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0),
                                                                    Colors
                                                                        .black,
                                                                  ]),
                                                            ),
                                                            child: Text(
                                                              newslist[index]
                                                                  .newsDec
                                                                  .substring(
                                                                      0, 55),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  newslist[index].newsHead,
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          catagery(nav: 'ABP News'),
                                    ));
                              },
                              child: Text("Show more"))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  final items = ["san ", "sama", "asds", " asdsf"];
}
