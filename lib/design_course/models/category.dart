class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.memberCount = 0,
    this.time = '',
    this.likes = 0,
  });

  String title;
  int memberCount;
  String time;
  int likes;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'Mathématiques Fondamentales',
      memberCount: 2,
      time: '15/09',
      likes: 4,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Séries Chronologiques',
      memberCount: 4,
      time: '15/09',
      likes: 5,
    ),
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      memberCount: 5,
      time: '15/09',
      likes: 3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      memberCount: 5,
      time: '15/09',
      likes: 6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Modélisation Statistique',
      memberCount: 5,
      time: '15/09',
      likes: 10,
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Web Design',
      memberCount: 2,
      time: '15/09',
      likes: 9,
    ),
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'App Design Course',
      memberCount: 3,
      time: '15/09',
      likes: 8,
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Web Design Course',
      memberCount: 4,
      time: '15/09',
      likes: 7,
    ),
  ];
}
