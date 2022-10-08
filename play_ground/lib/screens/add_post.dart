import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:play_ground/screens/post_list.dart';
import 'package:play_ground/services/helper.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final titleConroller = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Add",
          style: TextStyle(
            fontSize: 30,
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.title),
                hintText: "Title ..",
              ),
              controller: titleConroller,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.article),
                hintText: "Post body ..",
              ),
              controller: bodyController,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, String> data = {
                  'title': titleConroller.text,
                  'body': bodyController.text,
                };
                bool done = await Api().addItem(data);
                if (done) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Post was added")));
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop(MaterialPageRoute(
                    builder: ((context) => PostsList()),
                  ));
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Try again")));
                }
              },
              child: const Text(
                "Create",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
