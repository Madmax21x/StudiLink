class Category {
  int id;
  String nom;
  String image;

  Category(
      {this.id,
      this.nom,
      this.image});

  // named constructor
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        nom: json['nom'],
        image: json['image']
        );
  }
}
