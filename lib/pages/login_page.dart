import 'package:estoque_facil/pages/home_page.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:estoque_facil/widgets/app_button.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      backgroundColor: Color(0xFF102d3d),
    );
  }

  _body(context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        SizedBox(height: 70),
        Image.asset(
          "assets/images/logo.png",
          height: 100,
        ),
        SizedBox(height: 20),
        AppText(
          "E-mail",
          "Digite seu e-mail",
          icon: Icon(
            Icons.email,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        AppText(
          "Senha",
          "Digite sua senha",
          password: true,
          icon: Icon(
            Icons.https,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Text(
                "Esqueceu sua senha?",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        AppButton("Entrar", onPressed: () {
          push(context, HomePage(), replace: true);
        }),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/gmail.png",
                  height: 50,
                )),
            SizedBox(width: 10),
            InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/facebook.png",
                  height: 50,
                )),
            SizedBox(width: 10),
            InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/images/twitter.png",
                height: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
