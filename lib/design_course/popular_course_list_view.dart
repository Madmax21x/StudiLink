import 'package:best_flutter_ui_templates/design_course/design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/design_course/course_info_screen.dart';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:best_flutter_ui_templates/design_course/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/design_course/membre.dart';

class PopularCourseListView extends StatefulWidget {
  List user;

  PopularCourseListView(this.user);

  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List _user;
  var group = new List<Group>();
  var category = new List<Category>();
  var membre = new List<Membre>();
  var newData = new List<Group>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    getCategory();
    getCours();
    getMembre();
    _user = widget.user;
    newData = popularCourseData();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  // access localhost from the emulator/simulator
  String _hostname() {
    return 'http://studilink.online/studibase.group';
  }

  Future getCours() async {
    http.Response response = await http.get(_hostname());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      group = list.map((model) => Group.fromJson(model)).toList();
      newData = popularCourseData();
    });
  }

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
      newData = popularCourseData();
    });
  }

  List _nbrMembre(int valeur){
    List nbrMem = [];
    for (var i = 0; i < membre.length; i++) {
      if (membre[i].group_id == valeur){
        nbrMem.add(membre[i]);
      }else{
        continue;
      }
    print("list des membres");
    print(nbrMem);
  }
  return nbrMem;
  }

  List popularCourseData(){
    newData.clear();
    for(var i=0; i < group.length; i++){
      print(_nbrMembre(group[i].id).length);
      if(_nbrMembre(group[i].id).length >=2)
      {
        newData.add(group[i]);
      }    
    }
      return newData;
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
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                newData.length,
                (int index) {
                  final int count = newData.length;
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
                    index: index,
                    group: group,
                    newData: newData,
                    user: _user,
                    category:category,
                    membre: membre,
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
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
      this.group,
      this.newData,
      this.user,
      this.category,
      this.membre,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final int index;
  final List group;
  final List category;
  final List membre;
  final List user;
  final List newData;
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
                  0.0, 50 * (1.0 - animation.value), 0.0),
              // Each course
              child: InkWell(
                splashColor: Colors.transparent,
                child: SizedBox(
                  height: 400,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#F8FAFB'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  // border: new Border.all(
                                  //     color: DesignCourseAppTheme.notWhite),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, left: 16, right: 16),
                                              child: Text(
                                                newData[index].title,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  letterSpacing: 0.27,
                                                  color: DesignCourseAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14,
                                                  left: 16,
                                                  right: 16),
                                              child: 
                                              Column(children: <Widget>[
                                                Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    _nbrMembre(newData[index].id, membre).toString() + ' membre(s)',
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
                                                  
                                                ],
                                              ),

                                              Padding(
                                              padding: const EdgeInsets.only(top: 8),
                                              child:
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${newData[index].date.substring(0, newData[index].date.indexOf("T"))}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                    ),
                                                  )
                                                ]))
                                              ],)
                                              
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24, right: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              // boxShadow: <BoxShadow>[
                              //   BoxShadow(
                              //       color: DesignCourseAppTheme.nearlyWhite
                              //           .withOpacity(0.2),
                              //       offset: const Offset(0.0, 0.0),
                              //       blurRadius: 6.0),
                              // ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.28,
                                  child:
                                      Image.asset(categoryImage(newData[index].category_id, category)),
                              
                            ),
                          ),
                        ),
                      ),
                      )],
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder : (context){
                    return CourseInfoScreen(user, newData[index]);
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
  return "assets/design_course/interFace2.png";
}
  
}
