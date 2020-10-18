import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'sign_in_http.dart';

class Support extends StatefulWidget {
  @override
  SupportState createState() => SupportState();
}

class SupportState extends State<SignInHttpDemo> {
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   title: Text('Sign in Form'),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...[
                          Image.asset('images/logo.png'),
                        ]
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
