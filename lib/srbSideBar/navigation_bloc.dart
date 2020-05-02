import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'srbAnimator.dart';
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
  final _animationDuration = const Duration(milliseconds: 600);

  SrbRoute({@required List<Widget> children}) {
    children.forEach((child){
      _routemap[child.runtimeType.toString()] = child;
    });
    print("srb map " + _routemap.toString());
  }

  @override
  _SrbRouteState createState() => _SrbRouteState();
}

class _SrbRouteState extends State<SrbRoute> with SingleTickerProviderStateMixin<SrbRoute> {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: widget._animationDuration);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SrbAnimator>(
      create: (context) => SrbAnimator(
        animationController: _animationController,
        animationDuration: widget._animationDuration,
      ),
      child: Consumer<SrbAnimator>(
        builder: (context, srbAnimator, child) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (DragUpdateDetails details) {
            if (details.delta.dx > 6) srbAnimator.drag(true);
            else if(details.delta.dx < -6) srbAnimator.drag(false);
          },
          child: Container(
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
          ),
        ),
      ),
    );
  }
}
