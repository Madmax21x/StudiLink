class Cours {

      int id;
      String category;
      String title;
      int memberCount;
      String time;
      int likes;
      String imagePath;
      String description;
      String place;
      String day;

      Cours(this.id, this.category, this.title, this.memberCount, this.day, this.likes, this.description, this.imagePath, this.place, this.time );

      // named constructor
      Cours.fromJson(Map<String, dynamic> json)
          : category = json['category'],
            title = json['title'],
            memberCount = json['memberCount'],
            time = json['time'],
            likes = json['likes'],
            imagePath = json['imagePath'],
            description = json['description'],
            place = json['place'],
            day = json['day'];
    }