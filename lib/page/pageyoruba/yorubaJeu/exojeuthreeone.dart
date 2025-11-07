import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class JeuMotManquant extends StatefulWidget {
  final int startLevel;
  JeuMotManquant({required this.startLevel});

  @override
  _JeuMotManquantState createState() => _JeuMotManquantState();
}

class _JeuMotManquantState extends State<JeuMotManquant> {
  int score = 0;
  bool isFinished = false;
  late int currentLevel;
  Map<int, String?> userAnswers = {};

  final List<Map<String, dynamic>> allSentences = [
    {
      "sentence": "Je ___ à l’école chaque matin.",
      "options": ["vais", "va", "aller"],
      "answer": "vais"
    },
    {
      "sentence": "Il ___ du pain au marché.",
      "options": ["achète", "achètent", "acheté"],
      "answer": "achète"
    },
    {
      "sentence": "Nous ___ très heureux.",
      "options": ["sommes", "êtes", "es"],
      "answer": "sommes"
    },
    {
      "sentence": "Tu ___ ton livre hier.",
      "options": ["as lu", "lit", "lire"],
      "answer": "as lu"
    },
    {
      "sentence": "Elles ___ au cinéma ce soir.",
      "options": ["vont", "va", "allez"],
      "answer": "vont"
    },
    {
      "sentence": "Je ___ du sport le dimanche.",
      "options": ["fais", "fait", "faire"],
      "answer": "fais"
    },
  ];

  @override
  void initState() {
    super.initState();
    currentLevel = widget.startLevel;
  }

  List<Map<String, dynamic>> get currentQuestions {
    int nbQuestions = 3 + (currentLevel - 1) * 2; // Niveau 1 = 3 questions, Niveau 2 = 5...
    return allSentences.take(nbQuestions).toList();
  }

  Future<void> _saveScore() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE IF NOT EXISTS scores (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER,
            level INTEGER,
            date TEXT
          )
        ''');
      },
    );

    await db.insert('scores', {
      'score': score,
      'level': currentLevel,
      'date': DateTime.now().toIso8601String(),
    });
  }

  void checkAnswers() {
    int totalScore = 0;
    for (int i = 0; i < currentQuestions.length; i++) {
      if (userAnswers[i] == currentQuestions[i]["answer"]) {
        totalScore++;
      }
    }

    setState(() {
      score = totalScore;
      isFinished = true;
    });
    _saveScore();

    bool isSuccess = score == currentQuestions.length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Niveau $currentLevel terminé"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSuccess ? "assets/images/success.gif" : "assets/images/fail.gif",
              height: 120,
            ),
            SizedBox(height: 10),
            Text("Score : $score / ${currentQuestions.length}",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          if (isSuccess)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(currentLevel + 1);
              },
              child: Text("👉 Retour au menu (niveau suivant débloqué)"),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isFinished = false;
                score = 0;
                userAnswers.clear();
              });
            },
            child: Text("🔄 Recommencer"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = userAnswers.length / currentQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Niveau $currentLevel - Mot manquant"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress, minHeight: 12),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestions.length,
                itemBuilder: (context, index) {
                  final question = currentQuestions[index];
                  final selected = userAnswers[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question["sentence"],
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            children: question["options"].map<Widget>((opt) {
                              final isSelected = selected == opt;
                              return ChoiceChip(
                                label: Text(opt),
                                selected: isSelected,
                                selectedColor: Colors.green.shade300,
                                onSelected: (val) {
                                  if (!isFinished) {
                                    setState(() {
                                      userAnswers[index] = opt;
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          if (isFinished && selected != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                selected == question["answer"]
                                    ? "✅ Correct"
                                    : "❌ Faux (rép : ${question["answer"]})",
                                style: TextStyle(
                                    color: selected == question["answer"]
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!isFinished)
              ElevatedButton(
                onPressed: userAnswers.length == currentQuestions.length
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
