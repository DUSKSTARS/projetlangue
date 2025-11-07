import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class ExoJeuThree extends StatefulWidget {
  final int level;
  ExoJeuThree({required this.level});

  @override
  _ExoJeuThreeState createState() => _ExoJeuThreeState();
}

class _ExoJeuThreeState extends State<ExoJeuThree> {
  int score = 0;
  bool isFinished = false;
  Map<int, String?> selectedAnswers = {};

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Que signifie 'Tɔ' en fon ?",
      "options": ["Eau", "Pain", "Maison"],
      "answer": "Eau"
    },
    {
      "question": "Comment dit-on 'Merci beaucoup' en fon ?",
      "options": ["A kpe nu", "Mawu", "a fɔ̀n à"],
      "answer": "A kpe nu"
    },
    {
      "question": "Traduction de 'Au revoir' ?",
      "options": ["ma yi bo wa", "Tɔ́nú", "Agɔ"],
      "answer": "ma yi bo wa"
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
      if (selectedAnswers[i] == questions[i]["answer"]) newScore++;
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
                Navigator.of(context).pop(widget.level + 1);
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
      appBar:
          AppBar(title: Text("Niveau ${widget.level} - Quiz par cartes")),
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
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(q["question"],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          ...q["options"].map<Widget>((opt) {
                            final isSelected =
                                selectedAnswers[index] == opt;
                            final isCorrect = q["answer"] == opt;
                            Color color = Colors.grey.shade200;

                            if (isFinished) {
                              if (isCorrect)
                                color = Colors.green.shade300;
                              else if (isSelected)
                                color = Colors.red.shade300;
                            } else if (isSelected)
                              color = Colors.blue.shade200;

                            return GestureDetector(
                              onTap: () {
                                if (!isFinished) {
                                  setState(() {
                                    selectedAnswers[index] = opt;
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(opt,
                                    style: TextStyle(fontSize: 16)),
                              ),
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
