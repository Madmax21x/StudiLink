import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/profil_autre.dart';

class Membres extends StatefulWidget {
  List user;
  List membres;
  Membres(this.user, this.membres);
  @override
  _MembresState createState() => _MembresState();
}

class _MembresState extends State<Membres>{
  
  List _user;
  List _membres;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _membres = widget.membres;
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
                              'Membres',
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


            new ListView.builder
              ( padding: const EdgeInsets.only(
                    top: 20, bottom: 5, right: 20, left: 20),
                shrinkWrap: true,
                itemCount: _membres.length ==null ? 0 : _membres.length,
                itemBuilder: (BuildContext ctxt, int index) {
                return 
                InkWell(
                  child:Container(
                    padding: EdgeInsets.only(top:10, bottom:10),
                    decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300])), 
                   color: Colors.white,
                    ),
                    child: 
                    Row(children: <Widget>[
                      Container(
                        width: 40, 
                        height: 40, 
                       child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                        child: Image.asset('assets/design_course/userImage.png'),
                      )),
                      
                      SizedBox(width: 10,),
                      Text(
                        _membres[index].nom,
                        style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      letterSpacing: 0.27,
                        ),),
                      SizedBox(width: 5,),
                      Text(
                        _membres[index].prenom,
                        style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      letterSpacing: 0.27,
                        ),),
                      ],)
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder : (context){
                    return ProfilAutre(_user, _membres[index]);
                  }));
                },
                
                
                
                );})
                
                
              
          ]),
        ),
      ),
    );

  }
  
void moveToLastScreen() {
    Navigator.pop(context);
  }

}
