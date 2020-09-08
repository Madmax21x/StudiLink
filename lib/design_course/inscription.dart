
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';
import 'package:best_flutter_ui_templates/design_course/models/http.dart';
import 'package:best_flutter_ui_templates/design_course/connexion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Inscription extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _InscriptionState();
  }
}

class _InscriptionState extends State<Inscription>{

  var etudiant = new List<Etudiant>();
  var _formKey = GlobalKey<FormState>();
  String response = "";

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController motdepasseController = TextEditingController();

  createUser() async {
    debugPrint("ici ok");
    var result = await http_post('studibase.etudiant',{
        'email': emailController.text,
        'motdepasse': motdepasseController.text,
        'nom': nomController.text.inCaps,
        'prenom': prenomController.text.inCaps,
        'bio': null,
        'userimage_id': '1',
        'avis_id': null,
    });
    debugPrint('ici pas ok');
    if(result.ok)
    {
      setState(() {
        debugPrint("on est ici 2 ===========");
        debugPrint(response);
        response = result.data['status'];
      });
    }
  }

  @override
  void initState() {
    getEtudiant();
    emailController.clear();
    nomController.clear();
    prenomController.clear();
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
                              'Inscription',
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
                    padding: EdgeInsets.only(top:15.0),
                    child: SizedBox(
                      height: 70.0,
                      child: TextFormField(
                        controller: nomController,
                    
                        onChanged: (value){
                          debugPrint("some thematique has been added");
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          return null;
                        },
                        maxLines: 1,
                        maxLength: 30,
                        decoration: InputDecoration(
                          helperText: " ",
                          labelText: "   Nom",
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
                          hintText: "Entrez votre Nom",
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

                  //2nd element of the column
                  
                  Padding(
                    padding: EdgeInsets.only(top:0),
                    child: SizedBox(
                      height: 70.0,
                      child: TextFormField(
                        controller: prenomController,
                    
                        onChanged: (value){
                          debugPrint("some thematique has been added");
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          return null;
                        },
                        maxLines: 1,
                        maxLength: 20,
                        decoration: InputDecoration(
                          helperText: " ",
                          labelText: "   Prénom",
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
                          hintText: "Entrez votre prénom",
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

                  //3rd element of the column
                  
                  Padding(
                    padding: EdgeInsets.only(top:0),
                    child: SizedBox(
                      height: 70.0,
                      child: TextFormField(
                        controller: emailController,
                    
                        onChanged: (value){
                          debugPrint("some thematique has been added");
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
                          debugPrint("some thematique has been added");
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
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                                    "S'inscrire",
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
                                    if(_isOK(emailController.text) == true){
                                    
                                    createUser();
                                    Navigator.push(context, MaterialPageRoute(builder : (context){
                                      return Connexion();
                                    }));
                                    }
                                    else{
                                      _showDialog();
                                    }
                                }
                                });
                                    
                              },
                            )),
                          ),

                         
                          
          
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
                new Text("Un compte existe déjà avec l'addresse mail que vous avez rentrée."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: Text("Se connecter",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.teal[300],
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder : (context){
                    return Connexion();
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

  bool _isOK(String email){
  for (var i = 0; i < etudiant.length; i++) {
    if (etudiant[i].email == email){
      debugPrint("-----1-----");
     return false;
    }
    else{
      continue;
    }
    }
    return true;
}

} 

