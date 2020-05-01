import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
        ),
    );
  }
}
