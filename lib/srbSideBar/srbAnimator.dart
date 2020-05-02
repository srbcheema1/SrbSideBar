import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SrbAnimator extends ChangeNotifier{
  bool opened;
  AnimationController animationController;
  Duration animationDuration;
  SrbAnimator({@required this.animationController, @required this.animationDuration}) {
    opened = false;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void drag(bool open) {
    if(open) {
      if(!opened) toggle();
    } else {
      if(opened) toggle();
    }
  }

  void toggle() {
    if(opened) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    opened = !opened;
    notifyListeners();
  }
}