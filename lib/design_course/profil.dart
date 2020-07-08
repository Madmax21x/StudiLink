import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:http/http.dart' as http;

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {
  var group = new List<Group>();

  @override
  void initState() {
    super.initState();
    getCours();
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

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        body: Container(
          color: DesignCourseAppTheme.nearlyWhite,
          child: ListView(
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
                      
                    ])),

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Center(
                    child:Container(
                      alignment: Alignment.topLeft,
                      height: 100,
                      width: 100,
                
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                        child: Image.asset('assets/design_course/userImage.png'),
                      ),
                    ))),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15),
                  child: Center(
                    child:Text(
                      'Chris Hemsworth',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.27,
                        color:AppTheme.dark_grey,
                      ),
                      
                  )),
                ),

              const SizedBox(
                height: 30,
              ),
              
              

              Padding(
                padding: EdgeInsets.only(left: 30, right:30, bottom:30),
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 120,
                  child: Text(
                    "Blablabla", style:
                    TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.2,
                      color: Colors.grey[600] ,
                    ),) ,
                  decoration: BoxDecoration(
                    color: Color(0xFFF2FDF6),
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                     )),),
              
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 35, bottom:10.0),
                child: Text(
                  'Avis',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              
              Padding(
                padding: EdgeInsets.only(left: 30, right:30, bottom:30),
                child: Container(

                decoration:BoxDecoration(
                    color: Color(0xFFFAF2FD),
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                     ),
                child : Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    // Premier avis 

                    children: <Widget>[
                      Row(children: <Widget>[
                        // image : 1st element of the row

                        Positioned(
                          top:MediaQuery.of(context).size.height / 10,
                          child: Container(
                            width: 50.0,
                            margin: EdgeInsets.only(left:20.0, top:10, right:20.0, bottom:20),
                            child:ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/design_course/userImage.png',
                              fit: BoxFit.cover,
                            ),
                          )
                          )),

                        // Commentaire : 2 nd element of the row 

                          Column(children: <Widget>[
                            //Rating(),
                            Container(
                              width: 200.0,
                              margin: EdgeInsets.only(top:5.0),
                              child: Text("Commentaire bla bla bla Commentaire bla bla bla",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: 0.27,
                                  color: Colors.grey[600],
                                ), 
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis, 
                                maxLines: 6,) )
                            ,
                          ],)
                      ], )
                      

                    ],)
                    )
              ))

              ]),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
