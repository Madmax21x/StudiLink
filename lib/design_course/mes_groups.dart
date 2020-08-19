import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:best_flutter_ui_templates/design_course/membre.dart';
import 'package:best_flutter_ui_templates/design_course/mesgroups_view.dart';
import 'package:http/http.dart' as http;

class MesGroups extends StatefulWidget {
  List user;

  MesGroups(this.user);

  @override
  State<StatefulWidget> createState() {
    return _MesGroupsState();
  }
}

class _MesGroupsState extends State<MesGroups> {
  var group = new List<Group>();
  var membre = new List<Membre>();
  List _user;
  var mesGroup = new List<Group>();

  @override
  void initState() {
     _user = widget.user;
    getCours();
    getMembre();
    super.initState();
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

  List _mesGroup(List membre){
    for (var i = 0; i < membre.length; i++) {
      if (membre[i].etudiant_id == _user[0].id){
        for(var j = 0; j < group.length; j++) {
          if(group[j].id == membre[i].group_id){
            mesGroup.add(group[j]);
          }
        }
      }else{
        continue;
      }
    }
    return mesGroup;
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
                              'Mes Studi-Group',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                            Text(
                              'A Venir',
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
                affichage(),
              ]),
        ),
      ),
    );
  }

  Widget affichage(){
    mesGroup.clear();
    mesGroup = _mesGroup(membre);
    if(mesGroup == []){
      return Container(
        margin: EdgeInsets.only(top:50, left:30, right:30),
        child:Text("Tu n'es pas encore membre d'un Studi-Group.",
         textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            letterSpacing: 0.2,
            color: DesignCourseAppTheme.grey,
          )));
    }else{
      return Flexible(child:MesGroupsView(mesGroup, _user)) ;
    }

  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
