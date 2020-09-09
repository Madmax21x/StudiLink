import 'package:best_flutter_ui_templates/design_course/home_design_course.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/models/http.dart';
import 'package:best_flutter_ui_templates/design_course/membre.dart';
import 'package:best_flutter_ui_templates/design_course/membres.dart';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';

class CourseInfoScreen extends StatefulWidget {
  List user;
  dynamic group;
  CourseInfoScreen(this.user, this.group);
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}


class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
      dynamic _group;
      List _user;
      String response = "";
      var etudiant = new List<Etudiant>();
      var category = new List<Category>();
      var membre = new List<Membre>();
      String _buttonText = "";

  String _hostnameCategory() {
    return 'http://studilink.online/studibase.category';
  }

  Future getCategory() async {
    http.Response response = await http.get(_hostnameCategory());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      category = list.map((model) => Category.fromJson(model)).toList();
    });
  }

  String categoryImage(int valeur, List category){
  for (var i = 0; i < category.length; i++) {
    if (category[i].id == valeur){
      return category[i].image;
    }
    else{
      continue;
    }
    }
  return "assets/design_course/white.png";
}

  createMember() async {
    debugPrint("ici ok");
    var result = await http_post('studibase.membre',{
        'group_id': _group.id,
        'etudiant_id': _user[0].id,
    });
    debugPrint('ici pas ok');
    if(result.ok)
    {
      setState(() {
        debugPrint("on est ici 2 ===========");
        debugPrint(response);
        response = result.data['status'];
      });
      return true;
    }
  }

  String _hostnameMembre() {
    return 'http://studilink.online/studibase.membre';
  }

  Future getMembre() async {
    http.Response response = await http.get(_hostnameMembre());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      membre = list.map((model) => Membre.fromJson(model)).toList();
    });
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


  List _nbrMembre(int valeur, List membre, List etudiant){
    List nbrMem = [];
    print("LIst étudiant");
    print(etudiant);
    for (var i = 0; i < membre.length; i++) {
      if (membre[i].group_id == valeur){
        for(var j = 0; j< etudiant.length; j++){
          if (membre[i].etudiant_id == etudiant[j].id){
            nbrMem.add(etudiant[j]);
        }
      }
      }else{
        continue;
      }
    }
    return nbrMem;
  }

  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    super.initState();
    getCategory();
    getMembre();
    getEtudiant();
    _group = widget.group;
    _user = widget.user;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context ) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset(categoryImage(_group.category_id, category)),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: ListView(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text(
                              _group.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(_group.date.substring(0, _group.date.indexOf("T")),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.nearlyBlue,
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child:Expanded(child:SingleChildScrollView(
                                // shrinkWrap: true,
                                physics: ScrollPhysics(),     
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                children: <Widget>[
                                  getTimeBoxUI(_group.place, 'Lieu'),
                                  getTimeBoxUI(_group.date.substring(11,16), 'Heure'),
                                  //à modifier plus tard
                                  InkWell(
                                    child:getTimeBoxUI(_nbrMembre(_group.id, membre, etudiant).length.toString(), 'Membres'),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder : (context){
                                      return Membres(_user, _nbrMembre(_group.id, membre, etudiant));
                                    }));
                                    },
                                  )
                                  ,
                                ],
                              ))),
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: Text(
                                  _group.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ),
                                  maxLines: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              
                                  child:InkWell(child:Expanded(
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: DesignCourseAppTheme.nearlyBlue,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: DesignCourseAppTheme
                                                  .nearlyBlue
                                                  .withOpacity(0.5),
                                              offset: const Offset(1.1, 1.1),
                                              blurRadius: 10.0),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          _estMembre(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            letterSpacing: 0.0,
                                            color: DesignCourseAppTheme
                                                .nearlyWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async{
                                    if (_estMembre()== "Rejoindre le group"){
                                      var result =  await createMember();
                                         if (result) {
                                          _showDialog();
                                        }
                                    }
                                    else{
                                      var result =  await deleteMembre(_idMembre().toString());
                                        
                                        if (result) {
                                          if(_nbrMembre(_group.id, membre, etudiant).length == 1){
                                            deleteCours(_group.id.toString());
                                          }
                                          _showDialogDel();
                                    }
                                  }},)
                              
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _estMembre(){
    print("membre:");
    print(membre);
    print(_user[0].id);
    for (var i = 0; i < membre.length; i++) {
      if (membre[i].group_id == _group.id){
        if(membre[i].etudiant_id == _user[0].id){
          _buttonText = "Quitter le groupe";
          return _buttonText;
        }
      }
      else{
        continue;
      }
    }
    _buttonText = "Rejoindre le groupe";
    return _buttonText;

  }

  int _idMembre(){

    for (var i = 0; i < membre.length; i++) {
      if (membre[i].group_id == _group.id){
        if(membre[i].etudiant_id == _user[0].id){
          return membre[i].id;
        }
      }
      else{
        continue;
      }
    }

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
                new Text("Vous avez rejoint le groupe."),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder : (context){
                    return DesignCourseHomeScreen(_user);
                  }));
                },
              )
            ],
          );
        },
      );
    }


    void _showDialogDel() {
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
                new Text("Vous avez quitté le groupe."),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder : (context){
                    return DesignCourseHomeScreen(_user);
                  }));
                },
              )
            ],
          );
        },
      );
    }

  Widget getTimeBoxUI(dynamic text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
