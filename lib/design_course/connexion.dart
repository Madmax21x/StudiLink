import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';
import 'package:best_flutter_ui_templates/design_course/inscription.dart';
import 'package:best_flutter_ui_templates/design_course/home_design_course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Connexion extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _ConnexionState();
  }
}

class _ConnexionState extends State<Connexion>{

  var _formKey = GlobalKey<FormState>();
  String response = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController motdepasseController = TextEditingController();

   var etudiant = new List<Etudiant>();
   var user = new List<Etudiant>();

  @override
  void initState() {
    getEtudiant();
    emailController.clear();
    motdepasseController.clear();
    super.initState();
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


  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: (){
        moveToLastScreen();
      },
      child:Scaffold(body: Container(
        decoration:BoxDecoration(
           gradient: LinearGradient(
           begin: Alignment.topCenter,
           end:Alignment.bottomCenter, 
           stops: [0.4, 0.6, 1],
           colors: [Colors.grey[50], Colors.grey[100], Colors.grey[200]] )
           ), 

        child:ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

          // INSCRIPTION - TITRE

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
                              'Connexion',
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
          
            // 2nd element of the Listview
            Form(
              key: _formKey,
              child:Padding(
              padding: EdgeInsets.only(top: 40.0, left: 30.0, right:30.0),
              child: Column(
                children: <Widget>[

                  //1st element of the column
                  
                  Padding(
                    padding: EdgeInsets.only(top:0),
                    child: SizedBox(
                      height: 70.0,
                      child: TextFormField(
                        controller: emailController,
                    
                        onChanged: (value){
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          if(value.contains("etu.u-bordeaux.fr") == false){
                            return 'Veuillez entrer votre mail étudiant';
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          helperText: " ",
                          labelText: "   Adresse mail étudiante",
                          labelStyle: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                          
                          filled: true,
                          fillColor: Colors.grey[100],
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[100]),
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[100]),
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          hintText: "prenom.nom@etu.u-bordeaux.fr",
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[600],
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w400,
                          ),

                        )

                      )
                      )

                  ),

                  //4th element of the column
                  
                  Padding(
                    padding: EdgeInsets.only(top:0),
                    child: SizedBox(
                      height: 70.0,
                      child: TextFormField(
                        controller: motdepasseController,
                    
                        onChanged: (value){
                        },

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          if(value.length < 8){
                            return 'Doit comporter au moins 8 caractères';
                          }
                          return null;
                        },
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          
                          helperText: " ",
                          labelText: "   Mot de passe",
                          labelStyle: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                          
                          filled: true,
                          fillColor: Colors.grey[100],
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[100]),
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[100]),
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16.0),
                          ),
                          hintText: "Entrez votre mot de passe",
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[600],
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w400,
                          ),

                        )

                      )
                      )

                  ),
                

                  Padding(
                            padding: EdgeInsets.only(top: 25.0, bottom: 15.0),
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
                                    'Se connecter',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                      color: DesignCourseAppTheme.nearlyWhite,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  if (_formKey.currentState.validate()){
                                    debugPrint("Se connecter button clicked");
                                    if (_isOK(emailController.text, motdepasseController.text)==true){
                                    Navigator.push(context, MaterialPageRoute(builder : (context){
                                      return DesignCourseHomeScreen(user);
                                    }));
                                  }else{
                                    _showDialog();
                                  }
                                }
                                });
                                    
                              },
                            )),
                          )
          
          ],
          )
          ),

        ),
        ]),

          
    ),
    ));
  }

  void moveToLastScreen(){
    Navigator.pop(context);
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
                new Text("L'addresse mail ou le mot de passe que vous avez rentrés ne sont pas bons."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: Text("S'inscrire",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.teal[300],
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder : (context){
                    return Inscription();
                  }));
                  });
                  
                },
              ),

              new FlatButton(
                child: Text("Réessayer",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: DesignCourseAppTheme.grey,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () {
                  Navigator.of(context).pop(); 
                    initState();
                  
                },
              )
            ],
          );
        },
      );
    }

  bool _isOK(String email, String motdepasse){
    
  for (var i = 0; i < etudiant.length; i++) {
    if (etudiant[i].email == email){
      if (etudiant[i].motdepasse == motdepasse){
        user.add(etudiant[i]);
        return true;
      }
      else{
        return false;
      }
    }
    else{
      continue;
    }
    }
    return false;
}
} 

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  String get allInCaps => this.toUpperCase();
}