import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int row;
  late int count;
  late int resultIndex;
  late List<TextEditingController> _controllerList;
  late List<Color> _boxColorList;
  late int gridCount;
  late List<bool> _enableList;
  late bool gameOver;
  late List<String> resultList;
  late String gameMessage;

  @override
  void initState() {
    super.initState();
    row = 0;
    count = 5;
    resultList = ["SMILE", "HONEY", "COUCH", "SMELL", "COLOR"];
    resultIndex = Random().nextInt(resultList.length);
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
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
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
                          onPressed: gameOver ? _resetGame : _validateText,
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
      gameOver = false;
      gameMessage = '';
      resultIndex = Random().nextInt(resultList.length);
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
    if (inputString.isNotEmpty) {
      if (resultList[resultIndex] == inputString) {
        setState(() {
          gameOver = true;
          gameMessage =
              'Yay! you guessed it right. The word is ${resultList[resultIndex]}';
          for (var i = row; i < last; i++) {
            _boxColorList[i] = Colors.green;
          }
          _enableList = List<bool>.filled(gridCount, false);
        });
      } else {
        if (row == (gridCount - count)) {
          setState(() {
            gameOver = true;
            gameMessage = 'Uh! Oh. You\'ve used all your chances.';
          });
        }
        for (var i = row; i < last; i++) {
          setState(() {
            if (resultList[resultIndex].characters
                .contains(inputString[(count - (last - i))])) {
              if (resultList[resultIndex][(count - (last - i))] ==
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
