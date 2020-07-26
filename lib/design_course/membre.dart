class Membre {
  int id;
  int group_id;
  int etudiant_id;

  Membre(
      {this.id,
      this.group_id,
      this.etudiant_id,
      });

  // named constructor
  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
        id: json['id'],
        group_id: json['group_id'],
        etudiant_id: json['etudiant_id'],
        );
  }
}