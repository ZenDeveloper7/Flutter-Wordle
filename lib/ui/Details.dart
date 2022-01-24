import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wordle/ui/Home.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = const TextStyle(fontSize: 18.0, color: Colors.black);

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
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Guess the WORDLE in 5 tries.', style: _textStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Each guess must be a valid 5 letter word. Hit the check button to submit.',
                  style: _textStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'After each guess, the color of the tiles will change to show how close your guess was to the word.',
                  style: _textStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                  text: TextSpan(
                    style: _textStyle,
                    children: <TextSpan>[
                      TextSpan(text: 'Yellow', style: _textStyle.copyWith(color: Colors.amber)),
                      TextSpan(text: ' - Correct word in wrong position'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                  text: TextSpan(
                    style: _textStyle,
                    children: <TextSpan>[
                      TextSpan(text: 'Green', style: _textStyle.copyWith(color: Colors.green)),
                      TextSpan(text: ' - Correct word in correct position'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                  text: TextSpan(
                    style: _textStyle,
                    children: <TextSpan>[
                      TextSpan(text: 'Grey', style: _textStyle.copyWith(color: Colors.grey)),
                      TextSpan(text: ' - Incorrect word'),
                    ],
                  ),
                ),
              ),


              Container(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0.0, 50.0)),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
                      },
                      child: const Text('Start')))
            ],
          ),
        ),
      ),
    );
  }
}
