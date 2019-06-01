import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack/ui-widgets/project_list.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = TextEditingController();

  _handleSubmit(String username) {
      var db = Firestore.instance;

      db.collection("projects").add({
        "user_name": username,
        "project_team": "",
        "project_title": "",
        "project_description": "",
        "git_link": "",
        "vote_count": "",
        "created_at": DateTime.now()
      }).then((val){
        print("success");
        _controller.text = "";
        Navigator.push(context, MaterialPageRoute(builder: (builder)=> ProjectList(username)));
      }).catchError((err) {
        print("error" + err);
      });
    }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final textt = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text("FluttoCracy",style: const TextStyle(
          color:Colors.white,
          fontSize: 40.0,
          fontWeight:FontWeight.bold
        )),
      )
    );



    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          _handleSubmit(_controller.text);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Submit', style: TextStyle(color: Colors.white)),
      ),
    );

    



    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            textt,
            SizedBox(height: 20.0),
            logo,
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Add Your User Name'
                ),
              ),
            ),
            SizedBox(height: 48.0),
            loginButton
          ],
        ),
      ),
    );
  }
}