import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';
import 'package:best_flutter_ui_templates/design_course/avis.dart';
import 'package:best_flutter_ui_templates/design_course/laisser_avis.dart';
import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/models/http.dart';
import 'package:best_flutter_ui_templates/design_course/userimage.dart';

import 'package:http/http.dart' as http;

class ProfilAutre extends StatefulWidget {
  List user;
  Etudiant profil;
  

  ProfilAutre(this.user, this.profil);

  @override
  State<StatefulWidget> createState() {
    return _ProfilAutreState();
  }
}

class _ProfilAutreState extends State<ProfilAutre> {
  var avis = new List<Avis>();
  List _user;
  Etudiant _profil;
  var avisProfil = List<Avis>();
  var etudiant = List<Etudiant>();
  var images = new List<UserImage>();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _profil = widget.profil;
    getAvis();
    avisProfil = getAvisAvecId();
    getEtudiant();
    getAvatar();
  }

  String _hostnameAvatar() {
    return 'http://studilink.online/studibase.userimage';
  }

  Future getAvatar() async {
    http.Response response = await http.get(_hostnameAvatar());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      images = list.map((model) => UserImage.fromJson(model)).toList();
    });
  }

  String userImage(Etudiant etud){
  for (var i = 0; i < images.length; i++) {
    if (images[i].id == etud.userimage_id){
      return images[i].chemin;
    }
    else{
      continue;
    }
    }
  return "assets/design_course/userImage.png";
}

  String _hostnameAvis() {
    return 'http://studilink.online/studibase.avis';
  }

  Future getAvis() async {
    http.Response response = await http.get(_hostnameAvis());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      avis = list.map((model) => Avis.fromJson(model)).toList();
      avisProfil = getAvisAvecId();
    });
  }

  List getAvisAvecId(){
    avisProfil.clear();
    for(var i= 0; i< avis.length; i++){
      if(avis[i].etudiant_id == _profil.id){
        avisProfil.add(avis[i]);
      }    
    }
    return avisProfil;
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

  Etudiant _etudiantData(int id){
    for(var i= 0; i< etudiant.length; i++){
      if(etudiant[i].id == id){
       return etudiant[i];
      }    
    }
  }

  Widget _supprimer(id_user, id){
    if (_user[0].id == id_user){
      return InkWell(
        child:Text('Supprimer',
          style: TextStyle(
            fontWeight:
                FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0.27,
            color:DesignCourseAppTheme.nearlyBlue,
          ),),
        onTap: (){
          _showDialog(id);
        },);
    }
  }

  void _showDialog(id) {
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
                new Text("Etes-vous sûr(e) de vouloir supprimer votre publication? "),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: Text("Non",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.teal[300],
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop(); 
                    initState();
                    
                  });
                  
                },
              ),

              new FlatButton(
                child: Text("Oui",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: DesignCourseAppTheme.grey,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () async {
                  var result = await deleteAvis(id.toString());
                  if(result){
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder : (context){
                    return ProfilAutre(_user, _profil);
                  }));
                  }
                },
              )
            ],
          );
        },
      );
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
                        child: Image.asset(userImage(_profil)),
                      ),
                    ))),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15),
                  child: Center(
                    child:Text(
                      _profil.prenom + ' ' +  _profil.nom,
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
                    _biotext(), style:
                    TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.2,
                      color: Colors.grey[600] ,
                    ),) ,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5FAF8),
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
                    color: Color(0xFFF5FAF8),
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                     ),
                child : Expanded(child:Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left :10),
                  child: Column(children: <Widget>[
                    pasAvis(),
                    isUser(),
                    ])
                    )
              )))
          ]),
        ),
      ),
    );
  }

  Widget isUser(){
    if (_profil.id != _user[0].id){
      return Container(
        margin: EdgeInsets.only(top: 20,left: 240.0, bottom: 15.0, right:15),
        child: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder : (context){
              return LaisserAvis(_user, _profil);
            }));
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        foregroundColor: DesignCourseAppTheme.nearlyBlue,
        elevation:1.0,
        tooltip: "Laisser un avis",
      ),);
    }
    else{
      return Text(" ");
    }
  }

  Widget pasAvis(){
    if(_profil.id == _user[0].id && avisProfil.length==0){
      return Text("Pas d'avis pour l'instant.",
        style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        letterSpacing: 0.27,
        color: Colors.grey[600],
      ), 
      textAlign: TextAlign.left);
    }
    if(avisProfil.length==0){
      return Text("Pas d'avis pour l'instant. Sois le premier à laisser un avis !",
        style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        letterSpacing: 0.27,
        color: Colors.grey[600],
      ), 
      textAlign: TextAlign.left);
    }
    else return 
    ListView.builder(
      shrinkWrap: true,    
      itemCount: avisProfil.length == null ? 0 : avisProfil.length,
      itemBuilder: (BuildContext context, int index) {
      return

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // image : 1st element of the row
              Positioned(
                top:MediaQuery.of(context).size.height / 10,
                child: Container(
                  width: 50.0,
                  margin: EdgeInsets.only(left:20.0, top:10, right:20.0, bottom:20),
                  child:ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    userImage(_etudiantData(avisProfil[index].id_from)),
                    fit: BoxFit.cover,
                  ),
                )
                )),

              // Commentaire : 2 nd element of the row 

                Column(children: <Widget>[
                  
                  Container(
                    child: Text(
                      _etudiantData(avisProfil[index].id_from).prenom + ' ' + _etudiantData(avisProfil[index].id_from).nom,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.27,
                        color: Colors.grey[600],
                      ),
                    )
                  ),
                  //Rating(),
                  Container(
                    width: 200.0,
                    margin: EdgeInsets.only(top:5.0),
                    child: Text(avisProfil[index].description,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: 0.27,
                        color: Colors.grey[600],
                      ), 
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis, 
                      maxLines: 6,) ),
                  
              ],),
            ]),

              Container(
                margin: EdgeInsets.only(right:10, left:30),
                alignment: Alignment.bottomRight,
                child: Center(
                  child:Row(children: <Widget>[
                    Text(avisProfil[index].nbr_etoile.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                    )),

                    Icon(Icons.star,
                    color: Colors.yellow[300]),
                    
                    SizedBox(width:150),

                    _supprimer(avisProfil[index].id_from, avisProfil[index].id),
                  ],)
                    )),

              Container(
              padding: EdgeInsets.only(left:25, right:25, top:10, bottom:10),
              child:Divider(
              color: Colors.white,
              height: 10,
              thickness: 2,
            )
            ),

        ],);
      });
  }

  String _biotext(){
    if(_profil.bio == null){
      return "L'utilisateur n'a pas encore de bio.";
    }
    else{
      return _profil.bio;
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
