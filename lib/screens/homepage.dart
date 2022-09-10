import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/const/const.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> newsList = [];

  @override
  void didChangeDependencies() async {
    newsList = await NewsApiService().fetchNewsData();
    setState(() {});
    super.didChangeDependencies();
  }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "News App",
            style: myStyle(20, Colors.black, FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        ),
        drawer: Drawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("All News", style: myStyle(20, Colors.black))),
                SizedBox(
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (currentIndex > 1) {
                                  currentIndex--;
                                } else if (currentIndex < 1) {
                                  currentIndex--;
                                }
                              });
                            },
                            child: Text("Prev")),
                        SizedBox(width: 4),
                        Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 7.0),
                                child: MaterialButton(
                                    color: currentIndex == index + 1
                                        ? Colors.blue
                                        : Colors.white,
                                    minWidth: 5,
                                    onPressed: () {
                                      setState(() {
                                        currentIndex = index + 1;
                                      });
                                    },
                                    child: Text("${index + 1}")),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 4),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (currentIndex < 5) currentIndex++;
                              });
                            },
                            child: Text("Next"))
                      ]),
                ),
                SizedBox(height: 25),
                ListView.separated(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    "${newsList[index].urlToImage}",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  "${newsList[index].title}",
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 8,
                            width: 70,
                            color: Colors.blue,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 8,
                            width: 70,
                            color: Colors.blue,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 70,
                            width: 8,
                            color: Colors.blue,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 70,
                            width: 8,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                ),
              ],
            ),
          ),
        ));
  }
}
