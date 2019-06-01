import 'package:flutter/material.dart';
import 'project.dart';
import './ui-widgets/text-icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectScreen extends StatelessWidget {
  final Project project;

  const ProjectScreen(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Builder(
                builder: (context) => FlatButton.icon(
                      icon: Icon(Icons.thumb_up),
                      label: Text("Like"),
                      textColor: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 256,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.jpg',
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.tag,
                              size: 20,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            project.project_team,
                            style: Theme.of(context).textTheme.title,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    project.project_title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 24.0),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.4),
                        bottom: BorderSide(color: Colors.grey, width: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextIcon(
                          icon: FontAwesomeIcons.github,
                          text: "${project.git_link ?? "#"}",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Summary",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(project.project_description),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "Tags",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
