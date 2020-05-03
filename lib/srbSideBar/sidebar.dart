import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'srbAnimator.dart';

class SideBar extends StatelessWidget {
  final List<Widget> sidebarList;
  SideBar({@required this.sidebarList});

  Widget build(BuildContext context) {
    SrbAnimator srbAnimator = Provider.of<SrbAnimator>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      duration: srbAnimator.animationDuration,
      top: 0,
      bottom: 0,
      left: srbAnimator.opened ? 0 : -(screenWidth - 55),
      right: srbAnimator.opened ? 40 : screenWidth - 45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10,0, 10, 0),
              alignment: Alignment.topLeft,
              color: const Color(0xFF262AAA),
              child: ListView(
                children: sidebarList,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.85),
            child: GestureDetector(
              onTap: () {
                srbAnimator.toggle();
              },
              child: ClipPath(
                clipper: CustomMenuClipper(),
                child: Container(
                  width: 35,
                  height: 110,
                  color: Color(0xFF262AAA),
                  alignment: Alignment.centerLeft,
                  child: AnimatedIcon(
                    progress: srbAnimator.animationController.view,
                    icon: AnimatedIcons.menu_arrow,
                    color: Color(0xFF1BB5FD),
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(-1, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, -1, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
