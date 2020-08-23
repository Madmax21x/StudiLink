import 'package:best_flutter_ui_templates/design_course/profil_autre.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
import 'design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';
import 'package:best_flutter_ui_templates/design_course/models/http.dart';

// Pour laisser un avis 

class LaisserAvis extends StatefulWidget {
  List user;
  Etudiant profil;


  LaisserAvis(this.user, this.profil);

 @override
 State<StatefulWidget> createState() {
    return _LaisserAvisState();
  }
}

class _LaisserAvisState extends State<LaisserAvis>{
  List _user;
  Etudiant _profil;
  String response = "";
  var rating = 0.0;

  var _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _profil = widget.profil;
  }

  createAvis() async {
    var result = await http_post('studibase.avis',{
        'description': descriptionController.text,
        'id_from': _user[0].id.toString(),
        'etudiant_id': _profil.id,
        'nbr_etoile': rating.toString(),
    });
    if(result.ok)
    {
      setState(() {
        debugPrint(response);
        response = result.data['status'];
      });
      return true;
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: (){
        moveToLastScreen();
      },
      child: Scaffold(body: Container(
          decoration:BoxDecoration(
           gradient: LinearGradient(
           begin: Alignment.topCenter,
           end:Alignment.bottomCenter, 
           stops: [0.4, 0.6, 1],
           colors: [Colors.grey[50], Colors.grey[100], Colors.grey[200]] )
           ), 

           child: Column(children: <Widget>[

             Padding(padding: EdgeInsets.only(top:50.0, left:20.0),
              child:Row(children: <Widget>[

                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: DesignCourseAppTheme.darkerText,
                  onPressed: (){
                    moveToLastScreen();
                  },
                ),


                Text("Laisser un avis",
                textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),)
              
              ],)),
              

            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
              
            Padding(
              padding:EdgeInsets.only(top : 40.0, bottom: 5.0, left: 50.0, right: 50.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,),
               
                child: Center(
                  child:Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right:10.0),
                child: _rating(),
                ),
                )

                )),
            
            Padding(padding: EdgeInsets.only(top:20.0),
              child:Text("Notez votre rencontre !",
                style: TextStyle(fontSize: 15.0, color: Colors.grey[800], 
                fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,)
                ),

            Padding(
              padding:EdgeInsets.only(top : 50.0, bottom: 5.0, left: 50.0, right: 50.0),
             child: Container(
                      height: 150.0,
                      
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white),
                      child: TextFormField(
                        controller: descriptionController,
                    
                        onChanged: (value){
                          debugPrint("some thematique has been added");
                        },
                        maxLines: 5,

                        decoration: InputDecoration(
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Laissez un commentaire",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.3,
                            color: Colors.grey[700],
                          ),

                        )

                      )
                      )

                

            ),

             Padding(
                            padding: EdgeInsets.only(left: 50, right: 50, top: 25.0, bottom: 15.0),
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
                                    'Publier',
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
                              onTap: (){
                                 if (_formKey.currentState.validate()) {
                                      setState(() async{
                                        _showDialog();
                                        
                                      });
                                    }
                              },
                            )),
                          )


                ],),
              
                  )
           ],)
    )
    ));

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
                new Text("Etes-vous sûr(e) de vouloir publier? "),
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
                  var result = await createAvis();
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


  void moveToLastScreen(){
    Navigator.pop(context);
  }

  // Class RATING

Widget _rating(){
  return SmoothStarRating(
  
    allowHalfRating: false,
    rating: rating,
    size: 30,
    starCount: 5,
    filledIconData: Icons.star,
    halfFilledIconData: Icons.star_border,
    color: Colors.yellow[200],
    borderColor: Colors.yellow[200],
    onRated: (value) {
      setState(() {
        rating = value;
      });
    });
}
}

 




