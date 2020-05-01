import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_bloc.dart';
import 'menu_item.dart';

class SideBar extends StatefulWidget {
  final _animationDuration = const Duration(milliseconds: 600);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  bool opened;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    opened = false;
    _animationController = AnimationController(vsync: this, duration: widget._animationDuration);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onIconPressed() {
    // final animationStatus = _animationController.status;
    // final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if(opened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {opened = !opened;});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      duration: widget._animationDuration,
      top: 0,
      bottom: 0,
      left: opened ? 0 : -(screenWidth - 55),
      right: opened ? 10 : screenWidth - 45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10,0, 10, 0),
              alignment: Alignment.topLeft,
              color: const Color(0xFF262AAA),
              child: ListView(
                children: <Widget>[
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
                    onTap: () {
                      onIconPressed();
                      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                    },
                  ),
                  MenuItem(
                    icon: Icons.person,
                    title: "About Me",
                    onTap: () {
                      onIconPressed();
                      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                    },
                  ),
                  MenuItem(
                    icon: Icons.mood,
                    title: "Creator",
                    onTap: () {
                      onIconPressed();
                      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                    },
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
            ),
          ),
          Align(
            alignment: Alignment(0, -0.85),
            child: GestureDetector(
              onTap: () {
                onIconPressed();
              },
              child: ClipPath(
                clipper: CustomMenuClipper(),
                child: Container(
                  width: 35,
                  height: 110,
                  color: Color(0xFF262AAA),
                  alignment: Alignment.centerLeft,
                  child: AnimatedIcon(
                    progress: _animationController.view,
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
