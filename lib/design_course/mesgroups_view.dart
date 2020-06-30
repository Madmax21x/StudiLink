import 'package:best_flutter_ui_templates/design_course/design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/design_course/course_info_screen.dart';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/design_course/models/http.dart';


class MesGroupsView extends StatefulWidget {
  const MesGroupsView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _MesGroupsViewState createState() => _MesGroupsViewState();
}

class _MesGroupsViewState extends State<MesGroupsView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  var cours = new List<Cours>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    getCours();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  // access localhost from the emulator/simulator
  String _hostname() {
    return 'http://studilink.online/cours';
  }

  Future getCours() async {
    http.Response response = await http.get(_hostname());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      cours = list.map((model) => Cours.fromJson(model)).toList();
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
                cours.length,
                (int index) {
                  final int count = cours.length;
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
                    callback: () {
                      widget.callBack();
                    },
                    index: index,
                    cours: cours,
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 32.0,
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
      this.cours,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final int index;
  final List cours;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    String titre = '';
    String jour = '';
    String creneau = '';
    String description = '';
    String lieu = '';
    int coeur = 0;
    int membres = 0;
    String imagePath = '';

    void moveTo(
        titre, jour, coeur, membres, imagePath, creneau, description, lieu) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CourseInfoScreen(titre, jour,
              coeur, membres, imagePath, creneau, description, lieu),
        ),
      );
    }

  

    void _showDialog(int valeur) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titleTextStyle: TextStyle(
                            fontSize: 14.0, 
                            color: Colors.grey[800], 
                            fontFamily : 'JosefinSans',
                            fontWeight : FontWeight.w400,
                            ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          elevation: 2.0,
          title: new Text("Etes-vous sûr(e) de vouloir supprimer le groupe ? "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child:Text("Non", 
                style:TextStyle(
                fontSize: 14.0, 
                color: Colors.teal[300], 
                fontFamily : 'JosefinSans',
                fontWeight : FontWeight.w600,
                )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          new FlatButton(
            child:Text("Oui", 
                style:TextStyle(
                fontSize: 14.0, 
                color: Colors.teal[300], 
                fontFamily : 'JosefinSans',
                fontWeight : FontWeight.w600,
                )),
              onPressed: () {
                deleteCours(valeur.toString());
                //Navigator.of(context).pop();
              },)

          ],
        );
      },
    );
  }

    

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation.value), 0.0, 0.0),
              // Each course
              child:InkWell(
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
                                                cours[index].title,
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
                                                  right: 16, bottom: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${cours[index].memberCount} membre(s)',
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
                                                          '${cours[index].likes}',
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
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${cours[index].day}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                    ),
                                                  ),
                                                  Container(
                                                    child:IconButton(
                                                      onPressed: () {
                                                        _showDialog(index);
                                                        },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: DesignCourseAppTheme.grey,
                                                        size: 20.0,
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
                                    child: Image.asset(cours[index].imagePath)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  titre = cours[index].title;
                  jour = cours[index].day;
                  creneau = cours[index].time;
                  description = cours[index].description;
                  lieu = cours[index].place;
                  coeur = cours[index].likes;
                  membres = cours[index].memberCount;
                  imagePath = cours[index].imagePath;

                  moveTo(titre, jour, coeur, membres, imagePath, creneau,
                      description, lieu);
                },
              ),
               )
        );
      },
    );


    
  }

 
}
