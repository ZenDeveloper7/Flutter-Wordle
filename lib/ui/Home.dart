import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int row;
  late List<TextEditingController> _controllerList;
  late List<Color> boxColorList;
  late int gridCount;

  @override
  void initState() {
    super.initState();
    row = 0;
    gridCount = 30;
    boxColorList = List<Color>.generate(gridCount, (index) => Colors.white);
    _controllerList = List<TextEditingController>.generate(
        gridCount, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 5.0),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Colors.black),
                        color: boxColorList[index]),
                    child: Center(
                      child: TextField(
                          controller: _controllerList[index],
                          maxLength: 1,
                          style: const TextStyle(fontSize: 22.0),
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                              counterText: '',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                          onChanged: (value) => _changeFocus(value, index)),
                    ),
                  );
                },
                itemCount: gridCount,
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      onPressed: _validateText, child: const Text('Check')))
            ],
          ),
        ),
      ),
    );
  }

  _validateText() {
    String inputString = "";
    String originalString = "SMILE";
    for (var i = 0; i < 5; i++) {
      inputString += _controllerList[i].text.toString();
    }
    for (var i = 0; i < 5; i++) {
      setState(() {
        if (originalString.characters.contains(inputString[i])) {
          if (originalString[i] == inputString[i]) {
            boxColorList[i] = Colors.green;
          } else {
            boxColorList[i] = Colors.yellow;
          }
        } else {
          boxColorList[i] = Colors.grey;
        }
      });
    }
  }

  _changeFocus(String value, int index) {
    if (value.isNotEmpty) {
      if (index != 4) {
        setState(() {
          boxColorList = List<Color>.filled(gridCount, Colors.white);
        });
        FocusScope.of(context).nextFocus();
      }
    } else {
      if (index != 0) {
        setState(() {
          boxColorList = List<Color>.filled(gridCount, Colors.white);
        });
        FocusScope.of(context).previousFocus();
      }
    }
  }
}
