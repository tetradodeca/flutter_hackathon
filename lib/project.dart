class Project {
  String project_team;
  String project_title;
  String project_description;
  String git_link;
  int vote_count;

  Project(team_name, project_title, description, link, vote_count) {
    this.project_team = team_name;
    this.project_title = project_title;
    this.project_description = description;
    this.git_link = link;
    this.vote_count = vote_count;
  }
}
