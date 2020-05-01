import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sidebar.dart';
import '../pages/aboutme.dart';
import '../pages/srbcheema.dart';
import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => AboutMe();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield AboutMe();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield SrbCheema();
        break;
    }
  }
}

class SrbRoute extends StatefulWidget {
  final Map<String,Widget> _routemap = Map<String,Widget>();

  SrbRoute({@required List<Widget> children}) {
    children.forEach((child){
      _routemap[child.runtimeType.toString()] = child;
    });
    print("srb map " + _routemap.toString());
  }

  @override
  _SrbRouteState createState() => _SrbRouteState();
}

class _SrbRouteState extends State<SrbRoute> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onVerticalDragDown: showNavigationBar(),
      child: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}
