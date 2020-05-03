import 'package:flutter/material.dart';

import 'menu_item.dart';
import '../pages/aboutme.dart';
import '../pages/homepage.dart';
import '../pages/srbcheema.dart';

import '../srbSideBar/srbSideBar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SrbSideBar(
        sidebarRoutes: <Widget>[
          HomePage(),
          AboutMe(),
          SrbCheema()
        ],
        sidebarListBuilder: (openRoute) => <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: CircleAvatar(
              child: Icon(Icons.perm_identity,color: Colors.white),
              radius: 40.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Text(
              "srb Cheema",
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ),
          Divider(
            height: 40,
            thickness: 0.5,
            color: Colors.white.withOpacity(0.3),
            indent: 32,
            endIndent: 32,
          ),
          MenuItem(
            icon: Icons.home,
            title: "Home",
            onTap: () => openRoute((HomePage).toString()),
          ),
          MenuItem(
            icon: Icons.person,
            title: "About Me",
            onTap: () => openRoute((AboutMe).toString()),
          ),
          MenuItem(
            icon: Icons.mood,
            title: "Creator",
            onTap: () => openRoute((SrbCheema).toString()),
          ),
          Divider(
            height: 40,
            thickness: 0.5,
            color: Colors.white.withOpacity(0.3),
            indent: 32,
            endIndent: 32,
          ),
          MenuItem(
            icon: Icons.settings,
            title: "Settings",
          ),
        ],
      ),
    );
  }
}
