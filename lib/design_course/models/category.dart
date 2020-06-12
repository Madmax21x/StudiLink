class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.memberCount = 0,
    this.time = '',
    this.likes = 0,
    this.description = '',
    this.place = '',
    this. day = '',
  });

  String title;
  int memberCount;
  String time;
  int likes;
  String imagePath;
  String description;
  String place;
  String day;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'Mathématiques Fondamentales',
      memberCount: 2,
      day: '15/09',
      likes: 4,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks Sainte Catherine",
      time : "14:00",


    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Séries Chronologiques',
      memberCount: 4,
      day: '15/09',
      likes: 5,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks",
      time : "14:00",
    ),
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      memberCount: 5,
      day: '15/09',
      likes: 3,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks",
      time : "14:00",
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      memberCount: 5,
      day: '15/09',
      likes: 6,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks",
      time : "14:00",
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Modélisation Statistique',
      memberCount: 5,
      day: '15/09',
      likes: 10,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks",
      time : "14:00",
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Web Design',
      memberCount: 2,
      day: '15/09',
      likes: 9,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks",
      time : "14:00",
    ),
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'App Design Course',
      memberCount: 3,
      day: '15/09',
      likes: 8,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks",
      time : "14:00",
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Web Design Course',
      memberCount: 4,
      day: '15/09',
      likes: 7,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
      place: "Starbucks",
      time : "14:00",
    ),
  ];
}
