import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  Future<List<Map>> getItems() async {
    List<Map> itemList = [];
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      // String jsonBody = response.body;
      List data = json.decode(response.body);
      itemList = data.cast<Map>();
    }
    return itemList;
  }

  Future<Map> getItem(String itemID) async {
    Map item = {};
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemID"));
    if (response.statusCode == 200) {
      item = json.decode(response.body);
    }
    return item;
  }

  Future<bool> addItem(Map data) async {
    bool status = false;

    //Add the item to the database, call the API
    http.Response response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 201) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  Future<bool> updateItem(String itemId, Map data) async {
    bool done = false;
    final response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      done = response.body.isNotEmpty;
    }
    return done;
  }

  Future<bool> deleteItem(String itemId) async {
    bool done = false;
    final response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));
    if (response.statusCode == 200) {
      done = true;
    }
    return done;
  }
}
