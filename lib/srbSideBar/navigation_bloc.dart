import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'srbAnimator.dart';
import 'sidebar.dart';
import '../pages/errorpage.dart';

class NavigationBloc extends Bloc<String, Widget> {
  Map<String,Widget> navigationMap;
  Widget initialPage;
  NavigationBloc({@required this.navigationMap, @required this.initialPage});

  @override
  Widget get initialState => initialPage;

  @override
  Stream<Widget> mapEventToState(String event) async* {
    if(navigationMap.containsKey(event)) {
      yield navigationMap[event];
    } else {
      yield ErrorPage();
    }
  }
}

class SrbRoute extends StatefulWidget {
  final Map<String,Widget> _routemap = Map<String,Widget>();
  final Duration _animationDuration = const Duration(milliseconds: 600);
  final Widget initialPage;

  SrbRoute({@required List<Widget> children}): assert(children.length > 0),initialPage = children[0] {
    children.forEach((child){
      _routemap[child.runtimeType.toString()] = child;
    });
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
              create: (context) => NavigationBloc(navigationMap:widget._routemap,initialPage: widget.initialPage),
              child: Stack(
                children: <Widget>[
                  BlocBuilder<NavigationBloc, Widget>(
                    builder: (context, widget) {
                      return widget;
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
