import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late var _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 5.0),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: TextField(
                      controller: _controller,
                      maxLength: 1,
                      style: const TextStyle(fontSize: 22.0),
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                          counterText: '',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      onChanged: (value) => _changeFocus(value)),
                ),
              );
            },
            itemCount: 30,
          ),
        ),
      ),
    );
  }

  _changeFocus(String value) {
    if (value.isNotEmpty) {
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).previousFocus();
    }
  }
}
