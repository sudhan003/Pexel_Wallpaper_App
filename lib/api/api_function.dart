import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart ' as http;
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ApiProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  int currentPage = 1;
  List<dynamic> tinyUrl = [];

  bool isLoading = false;
  bool isTextRefresh = false;

  RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  int totalPages = 1;

  Future<List<dynamic>> apiPost(
      {bool isRefresh = false, String tag = "animals"}) async {
    if (isRefresh) {
      currentPage = 1;
      totalPages = 1;
      tinyUrl.clear();
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
      }
    }

    try {
      var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$tag&per_page=15&page=$currentPage"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "//YOUR SECRET API KEY HERE",
        },
      );
      if (response.statusCode == 200) {
        isLoading = true;
        notifyListeners();
        Map data = jsonDecode(response.body);

        List<dynamic> photos = data['photos'];
        print("the result is $photos 😎");

        if (isRefresh) {
          for (var photo in photos) {
            tinyUrl.add(photo['src']['tiny']);
            notifyListeners();
            print("the tinyUrl: $tinyUrl ✅");
            print("👉👉👉 if statement");
          }
        } else {
          for (var photo in photos) {
            tinyUrl.add(photo['src']['tiny']);
            notifyListeners();
            print("👉👉👉 else statement");
          }
          print("the tinyUrl: $tinyUrl ✅");
        }
        currentPage++;
        totalPages++;
        isLoading = false;
        notifyListeners();
        return tinyUrl;
      } else {
        throw Exception(
            "Failed to fetch image URLs. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
    // return apiResponse.src!.tiny!.toString();
  }
}
