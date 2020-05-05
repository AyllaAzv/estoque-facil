import 'package:flutter/material.dart';

alert(BuildContext context, String msg, {Function callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Image.asset("assets/images/logo_estoque.png", height: 50),
          content: Text(
            msg,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);

                if (callback != null) {
                  callback();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
