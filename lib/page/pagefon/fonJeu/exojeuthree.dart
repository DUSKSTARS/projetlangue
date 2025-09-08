import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:audioplayers/audioplayers.dart';

class ExoJeuThree extends StatefulWidget {
  final int level;
  ExoJeuThree({required this.level});

  @override
  _ExoJeuThreeState createState() => _ExoJeuThreeState();
}

class _ExoJeuThreeState extends State<ExoJeuThree> {
  int score = 0;
  bool isFinished = false;
  Map<int, List<String>> selectedWords = {};
  final player = AudioPlayer();

  final List<Map<String, dynamic>> questions = [
    {
      "options": ["Je", "vais", "à", "l'école"],
      "answer": "Je vais à l'école",
      "audio": "vocal/nnn.mp3"
    },
    {
      "options": ["Il", "mange", "du", "pain"],
      "answer": "Il mange du pain",
      "audio": "vocal/nnn.mp3"
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
      if ((selectedWords[i] ?? []).join(" ") == questions[i]["answer"]) {
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
                selectedWords.clear();
              });
            },
            child: Text("🔄 Recommencer"),
          ),
        ],
      ),
    );
  }

  Widget buildPhrase(int index, Map<String, dynamic> q) {
    List<String> choisis = selectedWords[index] ?? [];
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Arrange les mots pour former la phrase",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: q["options"].map<Widget>((mot) {
                return ChoiceChip(
                  label: Text(mot),
                  selected: choisis.contains(mot),
                  onSelected: (selected) {
                    if (!isFinished) {
                      setState(() {
                        if (selected) {
                          choisis.add(mot);
                        } else {
                          choisis.remove(mot);
                        }
                        selectedWords[index] = choisis;
                      });
                    }
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.volume_up),
              label: Text("Écouter"),
              onPressed: () async {
                await player.play(AssetSource(q["audio"]));
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Niveau ${widget.level} - Phrase")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return buildPhrase(index, questions[index]);
                },
              ),
            ),
            if (!isFinished)
              ElevatedButton(
                onPressed:
                    selectedWords.length == questions.length ? checkAnswers : null,
                child: Text("Valider"),
              ),
          ],
        ),
      ),
    );
  }
}
