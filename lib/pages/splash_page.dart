import 'package:estoque_facil/pages/login_page.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    //Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds: 3));

    Future.wait([futureB]).then((List values) {
      push(context, LoginPage(), replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF23acbc),
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    );
  }
}
