import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:play_ground/services/helper.dart';

class PostDetails extends StatelessWidget {
  PostDetails(this.itemID, {Key? key}) : super(key: key) {
    _futurePost = Api().getItem(itemID);
  }
  String itemID;
  late Future<Map> _futurePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post"),
        ),
        body: FutureBuilder<Map>(
          future: _futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error message: ${snapshot.error}");
            }
            if (snapshot.hasData) {
              Map post = snapshot.data!;
              return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 70),
                    child: Column(
                      children: [
                        Text(
                          "${post['title']}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "${post['body']}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal.shade100,
                          ),
                          onPressed: () {},
                          child: const ListTile(
                            trailing: Icon(Icons.edit),
                            title: Text(
                              "EDIT",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                          onPressed: () {},
                          child: const ListTile(
                            trailing: Icon(Icons.delete),
                            title: Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
