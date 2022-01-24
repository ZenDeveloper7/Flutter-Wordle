import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wordle/ui/Home.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = const TextStyle(fontSize: 18.0);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.deepOrange,
        ),
        title: Row(
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
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: const Center(
                  child: Text(
                    'Instructions',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                ),
              ),
              Text('1. Guess the WORDLE in 5 tries.',
                  style: _textStyle),
              Text(
                'Each guess must be a valid 5 letter word. Hit the check button to submit.\n'
                'After each guess, the color of the tiles will change to show how close your guess was to the word.',
                style: _textStyle,
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0.0, 50.0)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
                      },
                      child: const Text('Start')))
            ],
          ),
        ),
      ),
    );
  }
}
