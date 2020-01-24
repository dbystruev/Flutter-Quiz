//  https://github.com/londonappbrewery/quizzler-flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quizzler/quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:strings/strings.dart';

final quiz = Quiz();

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
  List<Icon> scoreKeeper = [];
  var rightAnswers = 0, wrongAnswers = 0;

  void showAlert() {
    Alert(
      buttons: [
        DialogButton(
          child: Text(
            'Restart',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              scoreKeeper.clear();
              rightAnswers = wrongAnswers = 0;
              quiz.restart();
            });
          },
          width: 120,
        ),
      ],
      context: context,
      desc: "You've got $rightAnswers answers right and $wrongAnswers wrong",
      title: 'The quiz is finished.',
      type: AlertType.success,
    ).show();
  }

  Expanded trueFalseButton(bool userAnswer) {
    return Expanded(
      child: Padding(
        child: FlatButton(
          child: Text(
            capitalize(
              userAnswer.toString(),
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          color: userAnswer ? Colors.green : Colors.red,
          onPressed: () {
            if (!quiz.isFinished) {
              final correctAnswer = quiz.currentAnswer;
              Icon icon;
              if (userAnswer == correctAnswer) {
                rightAnswers++;
                icon = Icon(
                  Icons.check,
                  color: Colors.green,
                );
              } else {
                wrongAnswers++;
                icon = Icon(
                  Icons.close,
                  color: Colors.red,
                );
              }
              scoreKeeper.add(icon);
              quiz.nextQuestion();
              setState(() {});
            }
            if (quiz.isFinished) {
              showAlert();
            }
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
                quiz.currentQuestion,
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
        trueFalseButton(true),
        trueFalseButton(false),
        Row(
          children: scoreKeeper,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
