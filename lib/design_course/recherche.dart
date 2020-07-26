import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:best_flutter_ui_templates/design_course/mesgroups_view.dart';
import 'package:http/http.dart' as http;

class Recherche extends StatefulWidget {
  List user;

  Recherche(this.user);
  @override

  State<StatefulWidget> createState() {
    return _RechercheState();
  }
}

class _RechercheState extends State<Recherche> {
  var group = new List<Group>();
  var newData = new List<Group>();
  List _user;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCours();
    _user = widget.user;
    newData = newGroupData("1", group);
  }

  String _hostname() {
    return 'http://studilink.online/studibase.group';
  }

  Future getCours() async {
    http.Response response = await http.get(_hostname());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      group = list.map((model) => Group.fromJson(model)).toList();
      newData = newGroupData("1", group);
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        body: Container(
          color: DesignCourseAppTheme.nearlyWhite,
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // RECHERCHE - TITRE

                Padding(
                    padding: EdgeInsets.only(top: 50.0, left: 20.0),
                    child: Row(children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: DesignCourseAppTheme.darkerText,
                        onPressed: () {
                          moveToLastScreen();
                        },
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Recherche',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                            Text(
                              'Un Studi-Group',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: DesignCourseAppTheme.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),

                const SizedBox(
                  height: 25,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 24, bottom : 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 64,
                        child:Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF8FAFB),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(13.0),
                                bottomLeft: Radius.circular(13.0),
                                topLeft: Radius.circular(13.0),
                                topRight: Radius.circular(13.0),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 16, right: 16),
                                    child: TextFormField(
                                      controller : titleController,
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: DesignCourseAppTheme.dark_grey,
                                      ),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Recherche un Studi-Group',
                                        border: InputBorder.none,
                                        helperStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFFB9BABC),
                                        ),
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 0.2,
                                          color: Color(0xFFB9BABC) ,
                                        ),
                                      ),
                                      onEditingComplete: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: IconButton(
                                    icon:Icon(Icons.search),
                                    color: Color(0xFFB9BABC),
                                    onPressed: () {
                                      setState(() {
                                        newData = newGroupData(titleController.text, group);
                                      print(newData);
                                      });
                                      
                                    },),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                      const Expanded(
                        child: SizedBox(),
                      )
                    ],
                  ),
    ),

                Flexible(child: MesGroupsView(newData, _user))
              ]),
        ),
      ),
    );
  }

  List newGroupData(String titre, List group){
    newData.clear();
    for (var i = 0; i < group.length; i++) {
      if (group[i].title.toLowerCase().contains(titre.toLowerCase()) || titre.toLowerCase().contains(group[i].title.toLowerCase())){
        newData.add(group[i]);
      }
      else{
        continue;
      }
      }
    return newData;
}

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
