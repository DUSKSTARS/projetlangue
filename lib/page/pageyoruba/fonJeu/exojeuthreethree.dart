import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class JeuTapMot extends StatefulWidget {
  final int level;
  JeuTapMot({required this.level});

  @override
  _JeuTapMotState createState() => _JeuTapMotState();
}

class _JeuTapMotState extends State<JeuTapMot> {
  int score = 0;
  bool isFinished = false;
  int currentQuestion = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "sentence": "Je ___ à l'école",
      "missing": "vais",
      "options": ["vais", "mange", "viens"]
    },
    {
      "sentence": "Il ___ du pain",
      "missing": "mange",
      "options": ["mange", "bois", "court"]
    },
    {
      "sentence": "Elle ___ à la maison",
      "missing": "va",
      "options": ["va", "fais", "dit"]
    },
  ];

  Future<void> _saveScore() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE IF NOT EXISTS scores (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          score INTEGER,
          level INTEGER,
          date TEXT
        )
      ''');
    });

    await db.insert('scores', {
      'score': score,
      'level': widget.level,
      'date': DateTime.now().toIso8601String(),
    });
  }

  void nextQuestion(bool correct) {
    if (correct) score++;
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      setState(() {
        isFinished = true;
      });
      _saveScore();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Niveau ${widget.level} terminé"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                score == questions.length
                    ? "assets/images/success.gif"
                    : "assets/images/fail.gif",
                height: 120,
              ),
              SizedBox(height: 12),
              Text("Score : $score/${questions.length}"),
            ],
          ),
          actions: [
            if (score == questions.length)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(widget.level + 1);
                },
                child: Text("👉 Retour au menu (niveau suivant)"),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  score = 0;
                  isFinished = false;
                  currentQuestion = 0;
                });
              },
              child: Text("🔄 Recommencer"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentQuestion + (isFinished ? 1 : 0)) / questions.length;

    final q = questions[currentQuestion];
    List<String> shuffledOptions = List.from(q["options"]);
    shuffledOptions.shuffle();

    return Scaffold(
      appBar: AppBar(
        title: Text("Niveau ${widget.level} - Tap le mot correct"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress, minHeight: 12),
            SizedBox(height: 16),
            Text(
              q["sentence"].replaceAll("___", "_____"),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: shuffledOptions.map((option) {
                return ElevatedButton(
                  onPressed: isFinished
                      ? null
                      : () => nextQuestion(option == q["missing"]),
                  child: Text(option, style: TextStyle(fontSize: 18)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
