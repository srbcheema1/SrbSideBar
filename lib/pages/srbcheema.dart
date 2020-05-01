import 'package:flutter/material.dart';

import '../srbSideBar/navigation_bloc.dart';

class SrbCheema extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Srb Cheema",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
