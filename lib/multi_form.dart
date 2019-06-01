import 'package:flutter/material.dart';
import 'empty_state.dart';
import 'form.dart';
import 'project.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<ProjectForm> projects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: Icon(
          Icons.wb_cloudy,
        ),
        title: Text('Your Projects'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF30C1FF),
              Color(0xFF2AA7DC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: projects.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'No Projects added',
                  message: 'Add your Projects by tapping the add icon below!',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: projects.length,
                itemBuilder: (_, i) => projects[i],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(Project _user) {
    setState(() {
      var find = projects.firstWhere(
        (it) => it.project == _user,
        orElse: () => null,
      );
      if (find != null) projects.removeAt(projects.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = Project();
      projects.add(ProjectForm(
        project: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (projects.length > 0) {
      var allValid = true;
      projects.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = projects.map((it) => it.project).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('List of Projects'),
                  ),
                  body: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, i) => ListTile(
                          leading: CircleAvatar(
                            child: Text(data[i].project_team.substring(0, 1)),
                          ),
                          title: Text(data[i].project_team),
                          subtitle: Text(data[i].project_title),
                        ),
                  ),
                ),
          ),
        );
      }
    }
  }
}
