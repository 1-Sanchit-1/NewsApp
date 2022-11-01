import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/catagery.dart';
import 'package:newsapp/content.dart';
import 'models.dart';

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
    Map element ;
    int i=0;
      url =
          "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&apiKey=63648439610949cab1368fbed94827eb";
    Response response = await get(Uri.parse(url!));
    Map data = jsonDecode(response.body);
    // print(data);
    setState(()
    {
      // data["articles"].forEach((element)
      for(element in data["articles"])
      {
        try{

          i++;
          NewsQueryModel newsQueryModel = new NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(element);
          p.add(newsQueryModel);
          // print('added');
          setState(() {
            isLoading = false;
          });
          if(i==50)
            break;
        }
        catch(e){
          print(e) ;
        };

      };

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
        title: Text("News App" , style: TextStyle(
          color: Colors.tealAccent,
        ),),
        elevation: 0.2,
        centerTitle: true,
        backgroundColor: Colors.black26,
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
                    // if (value.isEmpty) {
                    //   MaterialState.focused ;
                    //
                    // } else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                catagery(nav: ser.text ),
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
                      ? CircularProgressIndicator()
                      :
                  CarouselSlider(
                          options:
                          CarouselOptions(
                            // height: MediaQuery.of(context).size.height,
                            autoPlay: true,
                            height: 220,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                          ),
                          items: crousallist.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                try{
                                return Container(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
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
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
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
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                );
                                }catch(e){print(e);
                                return Container() ; } ;
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
                            "Latest news",
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
                            ? CircularProgressIndicator()
                            : Container(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                  itemCount: newslist.length,
                                  itemBuilder: (context, index) {
                                    try{
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: InkWell(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Content(ind: index),)) ;
                                        },
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
                                                      newslist[index].newsImg,
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
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.black12
                                                                  .withOpacity(0),
                                                              Colors.black,
                                                            ]),
                                                      ),
                                                      child: Text(
                                                        newslist[index].newsHead,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.black12
                                                                  .withOpacity(0),
                                                              Colors.black,
                                                            ]),
                                                      ),
                                                      child: Text(
                                                        newslist[index]
                                                            .newsDec
                                                            .substring(0, 55),
                                                        style: TextStyle(
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
                                    }catch(e){print(e); return Container(); }
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => catagery(nav: 'ABP News'),)) ;
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
