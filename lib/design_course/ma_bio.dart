import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MaBio extends StatefulWidget {
  List user;

  MaBio(this.user);

  @override
  State<StatefulWidget> createState() {
    return _MaBioState();
  }
}

class _MaBioState extends State<MaBio> {
  List _user;
  var _formKey = GlobalKey<FormState>();
  TextEditingController bioController = TextEditingController();
  
 
  @override
  void initState() {
    _user = widget.user;
    super.initState();
    
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Ma Bio',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ), ),

                             
                            ],
                          ),
                        ),
                    ])),
              
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:EdgeInsets.only(top : 25.0, bottom: 5.0, left: 40.0, right: 40.0),
                      child: Container(
                        height: 180.0,
                        
                        decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xFFF2FDF6)),
                        child: TextFormField(
                          controller: bioController,
                      
                          onChanged: (value){
                          },
                          maxLines: 6,
                          maxLength: 200,

                          decoration: InputDecoration(
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: _hinttext(),
                            hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: 0.27,
                                  color: Colors.grey[600],
                                ),

                          )

                      )
                      )

                

            ),

                              ])),

                
              ]),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

  String _hinttext(){
    if(_user[0].bio == null){
      return "Ajoute une bio. Mets ce que tu trouves important sur toi à dire: ton parcours, tes facilités...";
    }
    else{
      return _user[0].bio;
    }
  }

  
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  String get allInCaps => this.toUpperCase();
}