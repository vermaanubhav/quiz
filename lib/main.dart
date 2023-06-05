import 'package:flutter/material.dart';
import 'package:quiz/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[200]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  final List<Question> _questions = [
  Question('who is the prime minister of india', ['Narendra modi', 'Rahul gandhi', 'Arvind kejriwal'], 0),
  Question('name of the first BITS', ['BPPC', 'BPGC', 'BPHC'], 0),
  Question('best finisher in cricket?', ['A.B.D', 'RAHUL DRAVID', 'yuvraj singh'], 0),
  Question('best book?', ['Harry Potter', '400 days', 'how to win friends and influence people'], 0),

  ];
  List<int> _selectedAnswers = [];

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers.add(answerIndex);
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              selectedAnswers: _selectedAnswers,
              questions: _questions,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blue[200]!,
        Colors.blue[400]!,
      ],
    ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width:double.infinity,
        height:double.infinity,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question ${_currentIndex + 1}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _questions[_currentIndex].question,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: _questions[_currentIndex]
                .answers
                .asMap()
                .entries
                .map(
                  (entry) => AnswerButton(
                answerIndex: entry.key,
                answerText: entry.value,
                isSelected: _selectedAnswers.contains(entry.key),
                onPressed: _selectAnswer,
              ),
            )
                .toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_currentIndex < _questions.length - 1) {
                setState(() {
                  _currentIndex++;
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      selectedAnswers: _selectedAnswers,
                      questions: _questions,
                    ),
                  ),
                );
              }
            },
            child: Text(
              _currentIndex < _questions.length - 1 ? 'Next' : 'Finish',
            ),
          ),
        ],
      ),
    ),
    ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final int answerIndex;
  final String answerText;
  final bool isSelected;
  final Function(int) onPressed;

  AnswerButton({
    required this.answerIndex,
    required this.answerText,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => onPressed(answerIndex),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isSelected ? Colors.blue[700] : Colors.blue[400],
          ),
        ),
        child: Text(
          answerText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final List<int> selectedAnswers;
  final List<Question> questions;

  ResultsPage({
    required this.selectedAnswers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;

    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }

    return Scaffold(
        appBar: AppBar(
        title: const Text('Results'),
    ),
    body: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    Colors.blue[200]!,
    Colors.blue[400]!,
    ],
    ),
    ),
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Text(
    'Quiz Complete!',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    const SizedBox(height: 16),
    Text(
    'Correct Answers: $correctAnswers/${questions.length}',
    style: const TextStyle(
    fontSize: 18,
    color:                   Colors.white,
    ),
    ),
      ElevatedButton(
        onPressed: () {
          // Reset the quiz and navigate back to the login page
          Navigator.pop(context);
        },
        child: const Text('Restart Quiz'),
      ),
    ],
    ),
    ),
    ),
    );
  }
}

class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  Question(this.question, this.answers, this.correctAnswerIndex);
}



