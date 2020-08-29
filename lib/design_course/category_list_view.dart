import 'package:best_flutter_ui_templates/design_course/design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/design_course/course_info_screen.dart';
import 'package:best_flutter_ui_templates/design_course/category.dart';
import 'package:best_flutter_ui_templates/design_course/membre.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryListView extends StatefulWidget {
  List user;
  List newdata;

  CategoryListView(this.newdata, this.user);

  

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List _newdata;
  List _user;
  var category = new List<Category>();
  var membre = new List<Membre>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    getCategory();
    getMembre();
    _newdata = widget.newdata;
    _user = widget.user;
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  // access localhost from the emulator/simulator
  
  
  String _hostnameCategory() {
    return 'http://studilink.online/studibase.category';
  }

  Future getCategory() async {
    http.Response response = await http.get(_hostnameCategory());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      category = list.map((model) => Category.fromJson(model)).toList();
    });
  }

  String _hostnameMembre() {
    return 'http://studilink.online/studibase.membre';
  }

  Future getMembre() async {
    http.Response response = await http.get(_hostnameMembre());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      membre = list.map((model) => Membre.fromJson(model)).toList();
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: _newdata.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = _newdata.length > 10 ? 10 : _newdata.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return CategoryView(
                    index: index,
                    newdata: _newdata,
                    user: _user,
                    membre: membre,
                    category:category,
                    animation: animation,
                    animationController: animationController,
                    
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key key,
    this.index,
    this.newdata,
    this.user,
    this.membre,
    this.category,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int index;
  final List newdata;
  final List category;
  final List user;
  final List membre;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation.value), 0.0, 0.0),
              // Each course
              child: InkWell(
                splashColor: Colors.transparent,
                child: SizedBox(
                  width: 280,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 48,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#F8FAFB'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 48 + 24.0,
                                    ),
                                    // 1st course
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Text(
                                                newdata[index].title,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  letterSpacing: 0.27,
                                                  color: DesignCourseAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              child: SizedBox(),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16, bottom: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    _nbrMembre(newdata[index].id, membre).toString() + ' membre(s)',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 12,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          '0',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            fontSize: 15,
                                                            letterSpacing: 0.27,
                                                            color:
                                                                DesignCourseAppTheme
                                                                    .grey,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.favorite,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .nearlyBlue,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16, right: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${newdata[index].date.substring(0, newdata[index].date.indexOf("T"))}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8.0)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .nearlyWhite,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 24, left: 16),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Image.asset(categoryImage(newdata[index].category_id, category)),
                              )
                              )],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  //imagePath = categoryImage(newdata[index].category_id, category);

                  Navigator.push(context, MaterialPageRoute(builder : (context){
                    return CourseInfoScreen(user, newdata[index]);
                  }));
                },
              )),
        );
      },
    );
  }

int _nbrMembre(int valeur, List membre){
    List nbrMem = [];
    for (var i = 0; i < membre.length; i++) {
      if (membre[i].group_id == valeur){
        nbrMem.add(membre[i]);
      }
      else{
        continue;
      }
    }
    return nbrMem.length;
  }


String categoryImage(int valeur, List category){
  for (var i = 0; i < category.length; i++) {
    if (category[i].id == valeur){
      return category[i].image;
    }
    else{
      continue;
    }
    }
  return "assets/design_course/white.png";
}


}
