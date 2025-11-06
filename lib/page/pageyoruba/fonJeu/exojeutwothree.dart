import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:audioplayers/audioplayers.dart';

class ExoJeuFour extends StatefulWidget {
  final int level;
  ExoJeuFour({required this.level});

  @override
  _ExoJeuFourState createState() => _ExoJeuFourState();
}

class _ExoJeuFourState extends State<ExoJeuFour> {
  int score = 0;
  bool isFinished = false;
  Map<int, List<String>> arrangedWords = {};
  final player = AudioPlayer();

  final List<Map<String, dynamic>> questions = [
    {
      "options": ["vais", "Je", "à", "l'école"],
      "answer": "Je vais à l'école",
      "audio": "vocal/nnn.mp3"
    },
    {
      "options": ["Il", "mange", "du", "pain"],
      "answer": "Il mange du pain",
      "audio": "vocal/nnn.mp3"
    },
  ];

  // --- Sauvegarde du score dans SQLite ---
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

  // --- Vérifie les réponses ---
  void checkAnswers() {
    int newScore = 0;
    for (int i = 0; i < questions.length; i++) {
      final formedSentence = (arrangedWords[i] ?? []).join(" ");
      if (formedSentence == questions[i]["answer"]) newScore++;
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
                arrangedWords.clear();
              });
            },
            child: Text("🔄 Recommencer"),
          ),
        ],
      ),
    );
  }

  // --- Interface pour chaque phrase ---
  Widget buildDragAndDropQuestion(int index, Map<String, dynamic> q) {
    List<String> words = List.from(q["options"]);
    arrangedWords[index] ??= [];

    // Supprime les mots déjà placés de la liste des options
    for (var placed in arrangedWords[index]!) {
      words.remove(placed);
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Glisse les mots dans le bon ordre à l'intérieur du rectangle :",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // --- Zone où l'utilisateur dépose les mots ---
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 6,
                children: [
                  for (int i = 0; i < arrangedWords[index]!.length; i++)
                    Draggable<String>(
                      data: arrangedWords[index]![i],
                      feedback: Material(
                        color: Colors.transparent,
                        child: Chip(
                          label: Text(arrangedWords[index]![i],
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.blueAccent,
                        ),
                      ),
                      childWhenDragging: Chip(
                        label: Text(arrangedWords[index]![i]),
                        backgroundColor: Colors.grey.shade300,
                      ),
                      child: DragTarget<String>(
                        onWillAccept: (data) => true,
                        onAcceptWithDetails: (details) {
                          setState(() {
                            final currentWords = arrangedWords[index]!;

                            // Retire le mot de son ancienne position
                            currentWords.remove(details.data);

                            // Insère le mot à la nouvelle position
                            currentWords.insert(i, details.data);
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          final isActive = candidateData.isNotEmpty;
                          return Chip(
                            label: Text(arrangedWords[index]![i]),
                            backgroundColor: isActive
                                ? Colors.green.shade200
                                : Colors.blue.shade100,
                          );
                        },
                      ),
                    ),

                  // --- Zone vide à la fin pour déposer un mot ---
                  DragTarget<String>(
                    onWillAccept: (data) => true,
                    onAcceptWithDetails: (details) {
                      setState(() {
                        arrangedWords[index]!.remove(details.data);
                        arrangedWords[index]!.add(details.data);
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      final isActive = candidateData.isNotEmpty;
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive ? Colors.green.shade200 : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: isActive
                            ? Text(candidateData.first.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold))
                            : SizedBox(width: 30),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            // --- Liste des mots à glisser ---
            Wrap(
              spacing: 8,
              children: words.map((mot) {
                return Draggable<String>(
                  data: mot,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Chip(
                      label: Text(mot,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                  childWhenDragging: Chip(
                    label: Text(mot),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  child: Chip(
                    label: Text(mot),
                    backgroundColor: Colors.blue.shade100,
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 10),
            // --- Bouton audio ---
            ElevatedButton.icon(
              icon: Icon(Icons.volume_up),
              label: Text("Écouter"),
              onPressed: () async {
                await player.play(AssetSource(q["audio"]));
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Interface principale ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Niveau ${widget.level} - Glisse les mots")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) =>
                    buildDragAndDropQuestion(index, questions[index]),
              ),
            ),
            if (!isFinished)
              ElevatedButton(
                onPressed: arrangedWords.length == questions.length
                    ? checkAnswers
                    : null,
                child: Text("Valider"),
              ),
          ],
        ),
      ),
    );
  }
}
