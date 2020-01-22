// https://www.udemy.com/course/flutter-bootcamp-with-dart/learn/lecture/14483450
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:strings/strings.dart';

void main() => runApp(
      Quizzler(),
    );

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            child: QuizPage(),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Expanded _trueFalseButton(bool isTrue) {
    return Expanded(
      child: Padding(
        child: FlatButton(
          child: Text(
            capitalize(
              isTrue.toString(),
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          color: isTrue ? Colors.green : Colors.red,
          onPressed: () {
            print('The user picked $isTrue');
          },
          textColor: Colors.white,
        ),
        padding: EdgeInsets.all(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            child: Center(
              child: Text(
                'This is where the question text will go.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
          flex: 5,
        ),
        _trueFalseButton(true),
        _trueFalseButton(false),
        // TODO: Add a score keeper row
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
 */
