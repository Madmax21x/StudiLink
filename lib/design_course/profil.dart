import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:best_flutter_ui_templates/design_course/ma_bio.dart';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';
import 'package:best_flutter_ui_templates/design_course/avis.dart';
import 'package:best_flutter_ui_templates/design_course/home_design_course.dart';
import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:http/http.dart' as http;

class Profil extends StatefulWidget {
  List user;

  Profil(this.user);

  @override
  State<StatefulWidget> createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {
  var group = new List<Group>();
  var avis = List<Avis>();
  var etudiant = List<Etudiant>();
  var avisProfil = List<Avis>();
 
  List _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
     getAvis();
    avisProfil = getAvisAvecId();
    getEtudiant();
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
      if(avis[i].etudiant_id == _user[0].id){
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
                      _user[0].prenom + ' '+  _user[0].nom,
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
              
              
              InkWell(child:
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
                    color: Color(0xFFF2FDF6),
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                     )),),
                     onTap: (){
                       Navigator.pushReplacement(context, MaterialPageRoute(builder : (context){
                    return MaBio(_user);
                  }));
                     },),
              
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
                child : Expanded(child:Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20, left: 10),
                  child: pasAvis()
                  
                )
                    
                  
              )))

              ]),
        ),
      ),
    );
  }
  
  Widget pasAvis(){
     if (avisProfil.length == 0){
       return Text("Tu n'as pas d'avis pour l'instant. Pense à joindre un Study-Group.",
        style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        letterSpacing: 0.27,
        color: Colors.grey[600],
      ), 
      textAlign: TextAlign.left);
    }else{
      return ListView.builder(
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
                  'assets/design_course/userImage.png',
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

      ],)
                  
     ;});
    }
  }

  String _biotext(){
    if(_user[0].bio == null){
      return "Ajoute une bio. Mets ce que tu trouves important sur toi à dire: ton parcours, tes facilités...";
    }
    else{
      return _user[0].bio;
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}

