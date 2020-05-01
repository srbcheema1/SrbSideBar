import 'package:flutter/material.dart';

import '../pages/aboutme.dart';
import '../pages/homepage.dart';
import '../pages/srbcheema.dart';

import '../srbSideBar/navigation_bloc.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SrbRoute(
        children: <Widget>[
          HomePage(),
          AboutMe(),
          SrbCheema()
        ],
      ),
    );
  }
}
