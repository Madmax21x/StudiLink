class UserImage {
  int id;
  String chemin;

  UserImage(
      {this.id,
      this.chemin});

  // named constructor
  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
        id: json['id'],
        chemin: json['chemin'],
        );
  }
}
