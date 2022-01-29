import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wordle/constants/constants.dart';
import 'package:flutter_wordle/services/api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int row;
  late int count;
  late List<TextEditingController> _controllerList;
  late List<Color> _boxColorList;
  late int gridCount;
  late List<bool> _enableList;
  late bool gameOver;
  late String result = '';
  late String gameMessage;
  late List<dynamic> randomWords;

  @override
  void initState() {
    super.initState();
    row = 0;
    count = 5;
    gridCount = 25;
    gameMessage = '';
    gameOver = false;
    _boxColorList = List<Color>.generate(gridCount, (index) => Colors.white);
    _enableList = List<bool>.generate(gridCount, (index) => false);
    for (var i = 0; i < 5; i++) {
      _enableList[i] = true;
    }
    _controllerList = List<TextEditingController>.generate(
        gridCount, (index) => TextEditingController());
    setWord();
  }

  setWord() async {
    final wordList = await API().getRandomWords();
    setState(() {
      randomWords = wordList;
      result = randomWords[Random().nextInt(5)].toString().toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.deepOrange,
          ),
          title: appBarContents,
          backgroundColor: Colors.white,
          centerTitle: true,
          shape: appBarShape,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: (result.isEmpty)
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Visibility(
                          visible: gameOver,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              gameMessage,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        _gridView(),
                        Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(0.0, 50.0)),
                                onLongPress: _showAnswer,
                                onPressed:
                                    gameOver ? _resetGame : _validateText,
                                child: gameOver
                                    ? const Text('Reset')
                                    : const Text('Check'))),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  _showAnswer() {
    if (kDebugMode) {
      print(result);
    }
  }

  Widget _gridView() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          childAspectRatio: 1.0,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: Colors.black),
              color: _boxColorList[index]),
          child: Center(
            child: TextField(
                controller: _controllerList[index],
                enabled: _enableList[index],
                maxLength: 1,
                style: const TextStyle(fontSize: 26.0),
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    counterText: '',
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
                onChanged: (value) => _changeFocus(value, index)),
          ),
        );
      },
      itemCount: gridCount,
    );
  }

  _resetGame() {
    setState(() {
      row = 0;
      result = randomWords[Random().nextInt(5)].toString().toUpperCase();
      gameOver = false;
      gameMessage = '';
      _enableList = List<bool>.filled(gridCount, true);
      _boxColorList = List<Color>.filled(gridCount, Colors.white);
      for (var i in _controllerList) {
        i.clear();
      }
    });
  }

  _validateText() {
    String inputString = "";
    var last = row + count;
    for (var i = row; i < last; i++) {
      inputString += _controllerList[i].text.toString();
    }
    if (inputString.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Input')));
    } else if (inputString.isNotEmpty) {
      if (result == inputString) {
        setState(() {
          gameOver = true;
          gameMessage = 'Yay! you guessed it right. The word is $result';
          for (var i = row; i < last; i++) {
            _boxColorList[i] = Colors.green;
          }
          _enableList = List<bool>.filled(gridCount, false);
        });
      } else {
        if (row == (gridCount - count)) {
          setState(() {
            gameOver = true;
            gameMessage =
                'Uh! Oh. You\'ve used all your chances. The correct word is $result';
          });
        }
        for (var i = row; i < last; i++) {
          setState(() {
            if (result.characters.contains(inputString[(count - (last - i))])) {
              if (result[(count - (last - i))] ==
                  inputString[(count - (last - i))]) {
                _boxColorList[i] = Colors.green;
              } else {
                _boxColorList[i] = Colors.yellow;
              }
            } else {
              _boxColorList[i] = Colors.grey;
            }
            _enableList[i] = false;
            row = last;
            if (row < gridCount) {
              var last = row + count;
              for (var i = row; i < last; i++) {
                _enableList[i] = true;
              }
            }
          });
        }
      }
    }
  }

  _changeFocus(String value, int index) {
    setState(() {
      if (_boxColorList[index] != Colors.white) {
        _boxColorList[index] = Colors.white;
      }
    });
    if (value.isNotEmpty) {
      if (index != (row + count) - 1) {
        FocusScope.of(context).nextFocus();
      }
    } else {
      if (index != 0) {
        FocusScope.of(context).previousFocus();
      }
    }
  }
}
