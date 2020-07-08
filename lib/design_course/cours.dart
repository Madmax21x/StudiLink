class Group {
  int id;
  int category_id;
  String title;
  String description;
  String place;
  String date;

  Group(
      {this.id,
      this.category_id,
      this.title,
      this.description,
      this.place, 
      this.date});

  // named constructor
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json['id'],
        category_id: json['category_id'],
        title: json['title'],
        date: json['date'],
        description: json['description'],
        place: json['place'],
        );
  }
}
