import 'package:flutter/material.dart';
import 'package:flutter_wordle/ui/Home.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: GestureDetector(
          onTap: _moveNext(context),
          child: Hero(
            tag: 'Logo',
            child: FlutterLogo(
              size: 200.0,
            ),
          ),
        ),
      ),
    );
  }

  _moveNext(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MyRoute(builder: (_) => Home()));
    });
  }
}

class MyRoute extends MaterialPageRoute {
  MyRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(milliseconds: 1500);
}
