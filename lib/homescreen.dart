import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:blog_app/add_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbRef = FirebaseDatabase.instance.reference().child('Posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Blog"),
        centerTitle: true,
        actions: [
          InkWell(
            child: Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPost()),
              );
            },
          ),
          SizedBox(width: 20,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef.child('Post List'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  if (snapshot.value == null) {
                    return CircularProgressIndicator();
                  }
                  final Map<dynamic, dynamic> postMap = snapshot.value as Map<dynamic, dynamic>;
                  final post = postMap['pImage'] as String;
                  final title = postMap['pTitle'] as String;
                  final description = postMap['pDescription'] as String;
                  return Column(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: 'null',
                        image: post,
                      ),
                      SizedBox(height: 19,),
                      Text(title, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                      SizedBox(height: 19,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(description,style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                      ),

                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
