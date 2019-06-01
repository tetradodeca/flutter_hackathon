import 'package:flutter/material.dart';
import 'project.dart';

typedef OnDelete();

class ProjectForm extends StatefulWidget {
  final Project project;
  final state = _ProjectFormState();
  final OnDelete onDelete;

  ProjectForm({Key key, this.project, this.onDelete}) : super(key: key);
  @override
  _ProjectFormState createState() => state;

  bool isValid() => state.validate();
}

class _ProjectFormState extends State<ProjectForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Project Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.project.project_team,
                  onSaved: (val) => widget.project.project_team = val,
                  validator: (val) =>
                      val.length > 3 ? null : 'Team name is invalid',
                  decoration: InputDecoration(
                    labelText: 'Team Name',
                    hintText: 'Enter your team name',
                    icon: Icon(Icons.person),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  initialValue: widget.project.project_title,
                  onSaved: (val) => widget.project.project_title = val,
                  validator: (val) =>
                      val.length > 3 ? null : 'Project Title is invalid',
                  decoration: InputDecoration(
                    labelText: 'Project Title',
                    hintText: 'Enter the title of your project',
                    icon: Icon(Icons.title),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  initialValue: widget.project.project_title,
                  onSaved: (val) => widget.project.project_title = val,
                  validator: (val) => val.length > 50 && val.length < 200
                      ? null
                      : 'Description must be between 50-200 characte',
                  decoration: InputDecoration(
                    labelText: 'Project Description',
                    hintText: 'Describe your project',
                    icon: Icon(Icons.description),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.project.project_title,
                  onSaved: (val) => widget.project.project_title = val,
                  validator: (val) =>
                      val.contains('github') ? null : 'Link is invalid',
                  decoration: InputDecoration(
                    labelText: 'Link to GitHub',
                    hintText: 'Your project\'s GitHub link',
                    icon: Icon(Icons.link),
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
