import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';

class Parametre extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _ParametreState();
  }
}

class _ParametreState extends State<Parametre>{
  @override
  Widget build(Object context) {
    return WillPopScope(

      onWillPop: (){
        moveToLastScreen();
      },
      child: Scaffold(
      body : 
      Container(
        child:Container(
         decoration:BoxDecoration(
           color: Colors.white,
           ), 
          child:ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // Parametres- TITRE

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

                Text(
                  'Paramètres',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),

              ],)
                ),

            Padding(
              padding: EdgeInsets.only(top:50.0),
              child: Column(children: <Widget>[

                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                   color: Color(0xFFF8FAFB),
                    ),
                  child: Padding(
                    padding: EdgeInsets.only(left : 20.0, top:10.0),
                    child: Text("Compte",
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.2,
                      color: Colors.grey[600] ,
                    ),
                      textAlign: TextAlign.left,),)),

                InkWell(
                  child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                   color: Colors.white,
                    ),
                  child: Padding(
                    padding: EdgeInsets.only(left : 20.0, top:10.0),
                    child: Text("Modifier son profil",
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0.2,
                      color: DesignCourseAppTheme.darkerText ,
                    ),
                      textAlign: TextAlign.left,),)),
                  
                   onTap: (){
                    setState(() {
                      debugPrint("Changer le mot de passe clicked");
                      });
                    }
                
                ),
                

                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                   color: Color(0xFFF8FAFB),
                    ),
                  child: Padding(
                    padding: EdgeInsets.only(left : 20.0, top:10.0),
                    child: Text("Autres",
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.2,
                      color: Colors.grey[600] ,
                    ),
                      textAlign: TextAlign.left,),)),
               
                

                InkWell(
                  child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300])), 
                   color: Colors.white,
                    ),
                  child: Padding(
                    padding: EdgeInsets.only(left : 20.0, top:10.0),
                    child: Text("Politique de confidentialité",
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0.2,
                      color: DesignCourseAppTheme.darkerText ,
                    ),
                      textAlign: TextAlign.left,),)),
                      
                    onTap: (){
                    setState(() {
                      debugPrint("Politiques de confidentialité clicked");
                      });
                    }
                      ),
                

                InkWell(
                  child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300])), 
                   color: Colors.white,
                    ),
                  child: Padding(
                    padding: EdgeInsets.only(left : 20.0, top:10.0),
                    child: Text("Conditions d'utilisation",
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0.2,
                      color: DesignCourseAppTheme.darkerText ,
                    ),
                      textAlign: TextAlign.left,),)) ,
                       onTap: (){
                        setState(() {
                          debugPrint("Conditions d'utilisation clicked");
                          });
                      }
                  ),
                

                InkWell(
                  child:Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300])), 
                   color: Colors.white,
                    ),
                  child: Padding(
                    padding: EdgeInsets.only(left : 20.0, top:10.0),
                    child: Text("Se déconnecter",
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0.2,
                      color: DesignCourseAppTheme.nearlyBlue ,
                    ),
                      textAlign: TextAlign.left,),)),
                  onTap: (){
                    setState(() {
                      debugPrint("Se déconnecter clicked");
                      _showDialog();
                      });
                  }
               ),
                
              ],)

            ),

            ],)
        )
      )
    ))
;
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.2,
            color: DesignCourseAppTheme.darkerText ,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          elevation: 2.0,
          title: new Text("Etes-vous sûr(e) de vouloir vous déconnecter ? "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child:Text("Non", 
                style:TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.2,
                  color: DesignCourseAppTheme.nearlyBlue ,
                )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          new FlatButton(
            child:Text("Oui", 
                style:TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.2,
                  color: DesignCourseAppTheme.nearlyBlue ,
                )),
              onPressed: () {
                Navigator.of(context).pop();
              },)

          ],
        );
      },
    );
  }

   void moveToLastScreen(){
    Navigator.pop(context);
  }

}