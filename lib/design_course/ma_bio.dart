import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';
import 'design_course_app_theme.dart';
import 'models/http.dart';
import 'profil.dart';
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
  String response = "";
  List _user;
  var userupdated = new List<Etudiant>();
  List userup;
 
  var _formKey = GlobalKey<FormState>();
  var etudiant = new List<Etudiant>();
  TextEditingController bioController = TextEditingController();
  
 
  @override
  void initState() {
    super.initState();
    getEtudiant();
    _user = widget.user;
    
    
  }

   String _hostname() {
    return 'http://studilink.online/studibase.etudiant';
  }

  Future getEtudiant() async {
    http.Response response = await http.get(_hostname());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      etudiant = list.map((model) => Etudiant.fromJson(model)).toList();
    });
  }

  List _afterUpdate(){
    int id = _user[0].id;
    _user.clear();
    for (var i = 0; i < etudiant.length; i++) {
      if (etudiant[i].id == id){
        _user.add(etudiant[i]);
        return _user;
      }
      else{
        continue;
      }
    }
  }


  updateBio() async {
    debugPrint("ici ok");
    var result = await http_update('studibase.etudiant', _user[0].id.toString(), {'bio' : bioController.text});
    debugPrint('ici pas ok');
    if(result.ok)
    {
      setState(() {
        debugPrint("on est ici 2 ===========");
        debugPrint(response);
        response = result.data['status'];
      });
      getEtudiant();
      return true;
    }
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

            Padding(
                            padding: EdgeInsets.only(top: 25.0, bottom: 15.0, left: 40, right:40),
                            child: Expanded(
                                child: InkWell(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: DesignCourseAppTheme.nearlyBlue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: DesignCourseAppTheme.nearlyBlue
                                            .withOpacity(0.5),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Modifier',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      color: DesignCourseAppTheme.nearlyWhite,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                    setState(() async {
                                      
                                   
                                    if (_formKey.currentState.validate()) {
                                      
                                        var result =  await updateBio();
                                         if (result) {
                                          debugPrint("it is not true");
                                         
                                          _showDialog();
                                          
                                        }
                                        
                                    }
                                     });
                              },
                            )),
                          )

                              ])),

                
              ]),
        ),
      ),
    );
  }

  void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            titleTextStyle: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[800],
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.w400,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            elevation: 2.0,
            title:
                new Text("Ta bio a été modifiée."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              

              new FlatButton(
                child: Text("OK",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: DesignCourseAppTheme.grey,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () {
                  
                  Navigator.pop(context, () {
                    });
                  _afterUpdate();
                  print(_user[0].bio);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder : (context){
                    return Profil(_user);
                  }));
                },
              )
            ],
          );
        },
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