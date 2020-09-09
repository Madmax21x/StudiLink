import 'package:best_flutter_ui_templates/design_course/category_list_view.dart';
import 'package:best_flutter_ui_templates/design_course/popular_course_list_view.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/design_course/side_menu.dart';
import 'package:best_flutter_ui_templates/design_course/recherche.dart';
import 'package:best_flutter_ui_templates/design_course/category.dart';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:best_flutter_ui_templates/design_course/loader.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'proposer.dart';
import 'dart:convert';

class DesignCourseHomeScreen extends StatefulWidget {
  List user;

  DesignCourseHomeScreen(this.user);

  @override
 
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen> {

  List _user;
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  var group = new List<Group>();
  var newData = new List<Group>();

  void initState() {
    super.initState();
    getCours();
    getCategoryData();
    newData = newCategoryData(1, group);
    _user = widget.user;
  }

  Future<Widget> refreshList() async{
    await Future.delayed(Duration(seconds: 1));
    getCours();
    getCategoryData();
    newData = newCategoryData(1, group);
    _selectedIndex = 0;
                 
  }

  Future < Widget > fetchStr() async {
    await new Future.delayed(const Duration(seconds: 2), () {});
    return RefreshIndicator(
      onRefresh: refreshList,
      color: Colors.grey[200],
      displacement: 0,
      child:
      Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getSearchBarUI(),
                      getCategoryUI(),
                      Flexible(
                        child: getPopularCourseUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
    }

  String _hostname() {
    return 'http://studilink.online/studibase.group';
  }

  Future getCours() async {
    http.Response response = await http.get(_hostname());
    debugPrint(response.body);
    setState(() {
      Iterable list = json.decode(response.body);
      group = list.map((model) => Group.fromJson(model)).toList();
      newData = newCategoryData(1, group);
    });
  }

  List newCategoryData(int index, List group){
    newData.clear();
    for (var i = 0; i < group.length; i++) {
      if (group[i].category_id == index){
        print(group[i].category_id );
        newData.add(group[i]);
      }
      else{
        continue;
      }
      }
    return newData;
}


  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        appBar: AppBar(title: Text(""), backgroundColor: Colors.white, elevation:0.0, iconTheme: new IconThemeData(color: DesignCourseAppTheme.darkerText)),
        drawer: Container(width: 270, child:NavDrawer(_user)),
        backgroundColor: Colors.transparent,
        body: Center(child:FutureBuilder < Widget> (
      future: fetchStr(),
      builder: (context, snapshot) {
       if (snapshot.hasData) {
        return snapshot.data;
       } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
       }
       // By default, show a loading spinner
       return 
       ColorLoader3();
      }),
    )));
  }

   
  var categoryData = new List<Category>();

  String _hostnameCategory() {
    return 'http://studilink.online/studibase.category';
  }

  Future getCategoryData() async {
    http.Response response = await http.get(_hostnameCategory());
    setState(() {
      Iterable list = json.decode(response.body);
      categoryData = list.map((model) => Category.fromJson(model)).toList();
    });
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Catégorie',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),     
            scrollDirection: Axis.horizontal,
            itemCount: categoryData.length,
            itemBuilder: (BuildContext context, int index) {
              return Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                          right: 16),
                decoration: BoxDecoration(
                    color: _selectedIndex != null && _selectedIndex == index
                      ? DesignCourseAppTheme.nearlyBlue
                      : DesignCourseAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white24,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    onTap: () {
                      _onSelected(index);
                      newData = newCategoryData(categoryData[index].id, group);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 18, right: 18),
                      child: Center(
                        child: Text(
                          categoryData[index].nom,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 0.27,
                            color: _selectedIndex != null && _selectedIndex == index
                              ? DesignCourseAppTheme.nearlyWhite
                              : DesignCourseAppTheme.nearlyBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
    );
            }
          ),
        ),
      
        newdataVide()
        
      ],
    );
  }

  Widget newdataVide(){
    if(newData.length == 0){
      return Container(
        padding: EdgeInsets.only(left:30, right: 30, top:5),
        height: 50,
        child:Text("Pas encore de cours dans cette catégorie.",
        style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.27,
        color: Colors.grey[600],
      ), 
      textAlign: TextAlign.left));
    }
    else{
      return CategoryListView(newData, _user);
    }
  }
  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cours Populaires',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: PopularCourseListView(_user),
          )
        ],
      ),
    );
  }


  Widget getSearchBarUI() {
    return 
    InkWell(child: 
    Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, bottom : 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        
                          child: SizedBox(
                            child: Text('Recherche un Studi-Group', 
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: Color(0xFFB9BABC)
                                )
                          )
                          )
                        ,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        icon:Icon(Icons.search),
                        color: HexColor('#B9BABC'),
                        onPressed: () {
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder : (context){
                              return Recherche(_user);
                            }));
                            //renvoyer vers la page rechercher avec le input
                          });
                        },),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    ),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder : (context){
        return Recherche(_user);
      }));
    },);
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only( left: 18, right: 18),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Row(
          children: <Widget>[
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
                    'Studi-Group',
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
            Container(
              width: 45,
              height: 45,
              child: Center(
                child:Ink(
                  decoration: BoxDecoration(
                    color: DesignCourseAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    border: Border.all(
                        color: DesignCourseAppTheme.nearlyBlue
                        ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 28.0),
                    color: DesignCourseAppTheme.nearlyBlue,
                    tooltip: 'Propose un Studi-Group',
                    onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder : (context){
                          return Proposer(_user);
                        }));
                      });
                    },
                  ),
                  
                ))
            )
          ],
        ),
      ],)
    );
  }
}

