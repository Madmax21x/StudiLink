import 'package:best_flutter_ui_templates/design_course/design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/design_course/course_info_screen.dart';
import 'package:best_flutter_ui_templates/design_course/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/design_course/membre.dart';

class MesGroupsView extends StatefulWidget {
  List user;
  List newdata;
  MesGroupsView(this.newdata, this.user);

  @override
  _MesGroupsViewState createState() => _MesGroupsViewState();
}

class _MesGroupsViewState extends State<MesGroupsView>
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
    _user = widget.user;
    _newdata = widget.newdata;
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

   String _hostnameCategory() {
    return 'http://studilink.online/studibase.category';
  }

  Future getCategory() async {
    http.Response response = await http.get(_hostnameCategory());
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
    setState(() {
      Iterable list = json.decode(response.body);
      membre = list.map((model) => Membre.fromJson(model)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.only(left: 10, right: 30, top: 15),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                _newdata.length,
                (int index) {
                  final int count = _newdata.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    newdata: _newdata,
                    user: _user,
                    index: index,
                    category:category,
                    membre: membre,
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 22.0,
                childAspectRatio: 2.4,
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
      this.index,
      this.newdata,
      this.user,
      this.category,
      this.membre,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final int index;
  final List newdata;
  final List user;
  final List category;
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
                  width: 200,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 50,
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
                                      width: 48 + 40.0,
                                    ),
                                    // 1st course
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 16, bottom: MediaQuery.of(context).size.height > 600 ? 25 : 10,),
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
                                               maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16, bottom: 0),
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
                                                      fontSize: MediaQuery.of(context).size.height > 600 ? 14 : 10,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(newdata[index].date.substring(11,16),
                                                      textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: MediaQuery.of(context).size.height > 600 ? 17 : 14,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .grey,
                                                    ),
                                                    )
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20, right: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${newdata[index].date.substring(0, newdata[index].date.indexOf("T"))}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: MediaQuery.of(context).size.height > 600 ? 17 : 12,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                    ),
                                                  ),
                                                  
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
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder : (context){
                    return CourseInfoScreen(user, newdata[index]);
                  }));
                },
              ),
            ));
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
  return "assets/design_course/interFace2.png";
}
}
