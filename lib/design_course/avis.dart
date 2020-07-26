class Avis {
  int id;
  String description;
  int id_from;
  int etudiant_id;
  int nbr_etoile;

  Avis(
      {this.id,
      this.description,
      this.id_from,
      this.etudiant_id,
      this.nbr_etoile,
      });

  // named constructor
  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
        id: json['id'],
        description:json['description'],
        id_from: json['id_from'],
        etudiant_id: json['etudiant_id'],
        nbr_etoile: json['nbr_etoile'],
        );
  }
}