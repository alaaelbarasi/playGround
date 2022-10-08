import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:play_ground/services/helper.dart';

class PostsList extends StatelessWidget {
  PostsList({Key? key}) : super(key: key);

  Future<List<Map>> _futurePosts = Api().getItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts List',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurePosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check for errors
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          //Has data arrived
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;

            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Map thisItem = posts[index];
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${thisItem['title']}',
                        style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    subtitle: Text('${thisItem['body']}'),
                  );
                });
          }

          //Display a loader
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
