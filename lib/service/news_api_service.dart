import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class NewsApiService {
  Future<List<Articles>> fetchNewsData() async {
    List<Articles> newsList = [];
    try {
      var apiLink =
          'https://newsapi.org/v2/everything?q=Apple&from=2022-09-10&sortBy=popularity&apiKey=c67b97e5a9c744eaab2196b21f9f3e0d&pageSize=10';

      var response = await http.get(Uri.parse(apiLink));
      print("Response is ${response.body}");

      var data = jsonDecode(response.body);

      Articles articles;

      for (var i in data['articles']) {
        articles = Articles.fromJson(i);
        newsList.add(articles);
      }
    } catch (e) {
      print(e);
    }

    return newsList;
  }
}
