class Etudiant{
  int id;
  String email;
  String nom;
  String prenom;
  String bio;
  int userimage_id;
  int avis_id;
  String motdepasse;

  Etudiant(
      {this.id,
      this.email,
      this.nom,
      this.prenom,
      this.bio, 
      this.userimage_id,
      this.avis_id,
      this.motdepasse});

  // named constructor
  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
        id: json['id'],
        email: json['email'],
        nom: json['nom'],
        prenom: json['prenom'],
        bio: json['bio'],
        userimage_id: json['userimage_id'],
        avis_id: json['avis_id'],
        motdepasse: json['motdepasse']
        );
  }
}
