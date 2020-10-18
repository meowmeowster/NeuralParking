// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'map.dart';

part 'sign_in_http.g.dart';

@JsonSerializable()
class FormData {
  String email;
  String password;

  FormData({
    this.email,
    this.password,
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class SignInHttpDemo extends StatefulWidget {
  final http.Client httpClient;

  SignInHttpDemo({
    this.httpClient,
  });

  @override
  _SignInHttpDemoState createState() => _SignInHttpDemoState();
}

class _SignInHttpDemoState extends State<SignInHttpDemo> {
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Form(
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...[
                      Image.asset('images/logo.png'),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'PARKING.MAP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Mukta',
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: 'Логин',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  decorationStyle: TextDecorationStyle.wavy,
                                ),
                              ),
                            ),
                          ]),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          counterStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Montserrat',
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.6),
                          ),
                        ),
                        onChanged: (value) {
                          formData.email = value;
                        },
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: 'Пароль',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  decorationStyle: TextDecorationStyle.wavy,
                                ),
                              ),
                            ),
                          ]),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.6),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          formData.password = value;
                        },
                      ),
                    ].expand(
                      (widget) => [
                        widget,
                        SizedBox(
                          height: 24,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                OutlineButton(
                  disabledTextColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.white)),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: 'Войти',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ),
                  borderSide: BorderSide(color: Colors.white, width: 1.5),
                  onPressed: () async {
                    // Use a JSON encoded string to send
                    // var result = await widget.httpClient.post(
                    // 'https://example.com/signin',
                    // body: json.encode(formData.toJson()),
                    // headers: {'content-type': 'application/json'});

                    if (200 == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                      _showDialog('Succesfully signed in.');
                    } // else if (result.statusCode == 401) {
                    //   _showDialog('Unable to sign in.');
                    // } else {
                    //   _showDialog('Something went wrong. Please try again.');
                    //}
                  },
                ),
              ]),
        ]),
        //tyt in
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(message),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
//        child: [Your content here],
      ),
    );
  }
}
