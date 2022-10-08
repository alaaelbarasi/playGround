import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:play_ground/screens/post_list.dart';
import 'package:play_ground/services/helper.dart';

class EditPost extends StatefulWidget {
  EditPost(this.post, {Key? key}) : super(key: key);
  Map post;
  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _controllerTitle = TextEditingController();
  final _controllerBody = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerTitle.text = widget.post['title'];
    _controllerBody.text = widget.post['body'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Edit",
            style: TextStyle(color: Colors.amber, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                TextField(
                  controller: _controllerTitle,
                ),
                TextField(
                  maxLines: 5,
                  controller: _controllerBody,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, String> data = {
                      'title': _controllerTitle.text,
                      'body': _controllerBody.text,
                    };
                    bool done = await Api()
                        .updateItem(widget.post['id'].toString(), data);
                    if (done) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar((const SnackBar(
                        content: Text("Post was updated"),
                      )));
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PostsList()));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Try again")));
                    }
                  },
                  child: const Text("Submit"),
                )
              ],
            ),
          ),
        ));
  }
}
