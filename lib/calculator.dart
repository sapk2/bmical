// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:restart_app/restart_app.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class calculator extends StatefulWidget {
  @override
  State<calculator> createState() => _calculatorstate();
}

class _calculatorstate extends State<calculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  late double _result = 0;

  String _message = 'Please enter your height an weight';
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 38, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: favorite',
      style: optionStyle,
    ),
    Text(
      'Index 2: setting',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI_calculator'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        key: UniqueKey(),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'height in inch',
                icon: Icon(Icons.trending_up),
              ),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'weight in kg', icon: Icon(Icons.line_weight)),
            ),
            ElevatedButton(
              onPressed: () {
                calculateBim();
              },
              child: Text(
                'calculate',
                style: TextStyle(),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Restart.restartApp();
            //   },
            //   child: Text(
            //     'reset',
            //     style: TextStyle(),
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            Text(
              // ignore: unnecessary_null_comparison
              _result == null ? "Enter value" : _result.toStringAsFixed(2),
            ),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 224, 7, 29),
        backgroundColor: Color.fromARGB(255, 0, 154, 231),
        onTap: _onItemTapped,
      ),
    );
  }

  /* void resetButtonClicked() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    if (height == null || weight == null) {
      print("Reset is not working!");
    } else {
      _result = 0;
    }
  }*/

  void calculateBim() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Your height and weigh must be positive numbers";
      });
      return;
    }

    setState(() {
      _result = weight / (height * height);
      if (_result! < 18.5) {
        _message = "You are underweight 😥😥";
      } else if (_result! < 25) {
        _message = 'You body is fine❤️😇';
      } else if (_result! < 30) {
        _message = 'You are overweight🤨😮😲';
      } else {
        _message = 'You are obese😰😰';
      }
    });
  }
}
