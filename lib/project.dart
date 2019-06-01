class Project {
  String project_team;
  String project_title;
  String project_description;
  String git_link;

  Project(team_name, project_title, description, link) {
    this.project_team = team_name;
    this.project_title = project_title;
    this.project_description = description;
    this.git_link = link;
  }
}
