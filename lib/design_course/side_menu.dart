import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/mes_groups.dart';


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
          height : 40,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
            alignment: Alignment.topLeft,
            height: 120,
            width: 120,
            
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(80.0)),
              child: Image.asset('assets/design_course/userImage.png'),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 15),
            child: Text(
              'Chris Hemsworth',
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.27,
                color:AppTheme.dark_grey,
              ),
              
            ),
          ),
          SizedBox(
          height : 30,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          ListTile(
            leading: Icon(Icons.input, color:AppTheme.dark_grey),
            title: Text('Accueil', 
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.3,
                color:AppTheme.dark_grey,
              ),),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.verified_user, color:AppTheme.dark_grey),
            title: Text('Mon Profil',
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.3,
                color:AppTheme.dark_grey,
              )),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.group, color:AppTheme.dark_grey),
            title: Text('Mes Studi-Groups', 
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.3,
                color:AppTheme.dark_grey,
              )),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder : (context){
                          return MesGroups();
                        }))},
          ),
          ListTile(
            leading: Icon(Icons.settings, color:AppTheme.dark_grey),
            title: Text('Paramètres',
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.3,
                color:AppTheme.dark_grey,
              )),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color, color:AppTheme.dark_grey),
            title: Text('Laisser Un Avis', 
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.3,
                color:AppTheme.dark_grey,
              )),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.info, color:AppTheme.dark_grey),
            title: Text('A Propos de Nous', 
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.3,
                color:AppTheme.dark_grey,
              )),
            onTap: () => {},
          ),
          SizedBox(
            height: 10 ,),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color:Colors.red[400]),
            title: Text('Se Déconnecter', 
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.3,
                color:AppTheme.dark_grey,
              )),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}