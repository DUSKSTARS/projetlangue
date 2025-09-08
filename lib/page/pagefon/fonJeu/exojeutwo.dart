import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class ExoJeuTwo extends StatefulWidget {
  final int level;
  ExoJeuTwo({required this.level});

  @override
  _ExoJeuTwoState createState() => _ExoJeuTwoState();
}

class _ExoJeuTwoState extends State<ExoJeuTwo> {
  int score = 0;
  bool isFinished = false;
  Map<int, String?> selectedAnswers = {};

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Comment dit-on 'Bonjour' en fon ?",
      "options": ["a fɔ̀n à", "ma yi bo wa", "Mawu"],
      "answer": "a fɔ̀n à"
    },
    {
      "question": "Que veut dire 'Agɔ' ?",
      "options": ["Maison", "Pain", "Eau"],
      "answer": "Maison"
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

  void checkAnswers() {
    int newScore = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]["answer"]) {
        newScore++;
      }
    }
    setState(() {
      score = newScore;
      isFinished = true;
    });
    _saveScore();

    bool isSuccess = score == questions.length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Niveau ${widget.level} terminé"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSuccess
                  ? "assets/images/success.gif"
                  : "assets/images/fail.gif",
              height: 120,
            ),
            SizedBox(height: 12),
            Text("Score : $score/${questions.length}"),
          ],
        ),
        actions: [
          if (isSuccess)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(widget.level + 1); // Débloque suivant
              },
              child: Text("👉 Retour au menu"),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                score = 0;
                isFinished = false;
                selectedAnswers.clear();
              });
            },
            child: Text("🔄 Recommencer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Niveau ${widget.level} - QCM")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(q["question"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          ...q["options"].map<Widget>((opt) {
                            return RadioListTile<String>(
                              title: Text(opt),
                              value: opt,
                              groupValue: selectedAnswers[index],
                              onChanged: (value) {
                                if (!isFinished) {
                                  setState(() {
                                    selectedAnswers[index] = value;
                                  });
                                }
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!isFinished)
              ElevatedButton(
                onPressed: selectedAnswers.length == questions.length
                    ? checkAnswers
                    : null,
                child: Text("Valider mes réponses"),
              ),
          ],
        ),
      ),
    );
  }
}
