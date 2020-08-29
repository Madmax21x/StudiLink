import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/userimage.dart';
import 'package:best_flutter_ui_templates/design_course/profil.dart';
import 'package:best_flutter_ui_templates/design_course/etudiant.dart';
import 'models/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModifImage extends StatefulWidget {
  List user;
  
  ModifImage(this.user);
  @override
  _ModifImageState createState() => _ModifImageState();
}

class _ModifImageState extends State<ModifImage>{
  
  List _user;
  String response = "";
  var images = List<UserImage>();
  var etudiant = new List<Etudiant>();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    getAvatar();
    getEtudiant();
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

  String _hostnameAvatar() {
    return 'http://studilink.online/studibase.userimage';
  }

  Future getAvatar() async {
    http.Response response = await http.get(_hostnameAvatar());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      images = list.map((model) => UserImage.fromJson(model)).toList();
      print(images);
    });
  }

  updateImage(int idImage) async {
    debugPrint("ici ok");
    var result = await http_update('studibase.etudiant', _user[0].id.toString(), {
      'bio': _user[0].bio,
      'userimage_id' : idImage.toString()});
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
          child: Column(
              //physics: const BouncingScrollPhysics(),
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.only(top: 50.0, left: 20.0, bottom:20),
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
                              'Choisis ton',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                letterSpacing: 0.2,
                                color: DesignCourseAppTheme.grey,
                              ),
                            ),
                            Text(
                              'Avatar',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),

                  SizedBox(
                    height:500,
                    child:
                      GridView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        child:Image.asset(images[index].chemin, height:20, width:20),
                        onTap: () async{
                          var result =  await updateImage(images[index].id);
                            if (result) {
                            _showDialog();
                          }
                        },);
                    },
                ))]),
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
                new Text("Tu viens de modifier ton avatar."),
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

void moveToLastScreen() {
    Navigator.pop(context);
  }

}
