import 'package:flutter/material.dart';

const contactTextFieldDecoration = InputDecoration(
    labelText: "Enter a value",
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

const contactFormTextSize = TextStyle(fontSize: 18.0);