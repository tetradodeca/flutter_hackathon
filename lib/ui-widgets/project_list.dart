import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../multi_form.dart';
import '../project.dart';
import '../project_screen.dart';

class ProjectList extends StatefulWidget {
  ProjectList(this.username);

  final String username;

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fluttocracy Projects"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => MultiForm()));
            },
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Fluttocracy'),
                      subtitle: Text(
                          'An app to vote for your favourite Flutter projects.'),
                    ),
                    ButtonTheme.bar(
                      // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          Icon(Icons.thumb_up),
                          FlatButton(
                            child: const Text('VIEW'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ProjectScreen(Project(
                                          'Fluttocracy',
                                          'Fluttocracy',
                                          'An app to vote for your favourite Flutter projects.',
                                          'https://github.com/tetradodeca/flutter_hackathon',
                                          1))));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("projects")
                    .orderBy("created_by")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (_, int index) {
                      DocumentSnapshot document =
                          snapshot.data.documents[index];

                      return projectList(context, document);
                    },
                    itemCount: snapshot.data.documents.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget projectList(BuildContext context, DocumentSnapshot document) {
    String projectTitle = document["project_title"];
    String projectDescription = document["project_description"];
    String projectTeam = document["project_team"];
    String projectLink = document["git_link"];
    int projectVote = document["vote_count"];

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => ProjectScreen(Project(
                      projectTeam,
                      projectTitle,
                      projectDescription,
                      projectLink,
                      projectVote))));
        },
        child: ListTile(
          title: Text(document["project_title"]),
          subtitle: Text(document["project_description"]),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
