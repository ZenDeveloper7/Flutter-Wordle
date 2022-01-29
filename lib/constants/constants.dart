import 'package:flutter/material.dart';

const baseUrl =
    'https://random-words5.p.rapidapi.com/getMultipleRandom?count=5&wordLength=5';
const host = 'random-words5.p.rapidapi.com';
const apiKey = '9f0891d519msh20c86bc5798ca36p1a5aadjsn5f54babe3562';

const appBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)));

Widget appBarContents = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: const [
    Hero(
        tag: 'Logo',
        child: FlutterLogo(
          size: 25.0,
        )),
    Text(
      'Flutter Wordle',
      style: TextStyle(color: Colors.black, fontSize: 20.0),
    ),
  ],
);
