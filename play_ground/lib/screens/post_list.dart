import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_ground/screens/post_details.dart';

import 'package:play_ground/services/helper.dart';

class PostsList extends StatelessWidget {
  PostsList({Key? key}) : super(key: key);

  Future<List<Map>> _futurePosts = Api().getItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Posts List',
          style: TextStyle(
            fontSize: 30,
            color: Colors.amber,
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
                  return Card(
                    elevation: 10,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PostDetails(thisItem['id'].toString()),
                        ));
                      },
                      title: Card(
                        // margin: EdgeInsets.zero,
                        color: Colors.amber.shade200,
                        elevation: 5,
                        shadowColor: Colors.black38,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 8, 9, 8),
                          child: Text(
                            '${thisItem['title']}',
                            style: TextStyle(
                              color: Colors.blueGrey.shade900,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 8, 10),
                        child: Text(
                          '${thisItem['body']}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
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
