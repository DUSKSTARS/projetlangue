import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class ExerciceFon extends StatefulWidget {
  final int startLevel;
  ExerciceFon({required this.startLevel});

  @override
  _ExerciceFonState createState() => _ExerciceFonState();
}

class _ExerciceFonState extends State<ExerciceFon> {
  int score = 0;
  bool isFinished = false;
  late int currentLevel;
  Map<String, String?> selectedMatches = {};

  // Tous les exercices dispo
  final List<Map<String, String>> allExercices = [
    {'fr': "Bonjour", 'fon': "a fɔ̀n à"},
    {'fr': "Comment vas-tu ?", 'fon': "nɛ a de gbɔn ?"},
    {'fr': "Merci beaucoup", 'fon': "A kpe nu"},
    {'fr': "Au revoir", 'fon': "ma yi bo wa"},
    {'fr': "Dieu", 'fon': "Mawu"},
    {'fr': "Maison", 'fon': "Agɔ"},
    {'fr': "Eau", 'fon': "Tɔ"},
    {'fr': "Pain", 'fon': "Aklui"},
    {'fr': "Ami", 'fon': "Tɔ́nú"},
    {'fr': "Père", 'fon': "Tɔ̀"},
  ];

  @override
  void initState() {
    super.initState();
    currentLevel = widget.startLevel;
  }

  // Sélection des exercices selon le niveau
  List<Map<String, String>> get currentExercices {
    int nbWords = 4 + (currentLevel - 1) * 2; // Niveau 1: 4 mots, N2: 6 mots...
    return allExercices.take(nbWords).toList();
  }

  // Sauvegarde en base SQLite
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

  // Vérification des réponses
  void checkAnswers() {
    int newScore = 0;
    for (var ex in currentExercices) {
      if (selectedMatches[ex['fr']] == ex['fon']) {
        newScore++;
      }
    }
    setState(() {
      score = newScore;
      isFinished = true;
    });
    _saveScore();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Niveau $currentLevel terminé"),
        content: Text("Score : $score/${currentExercices.length}"),
        actions: [
          if (score == currentExercices.length)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(currentLevel + 1); // Débloque le suivant
              },
              child: Text("👉 Retour au menu (niveau suivant débloqué)"),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                score = 0;
                isFinished = false;
                selectedMatches.clear();
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
    List<String> fonWords = currentExercices.map((e) => e['fon']!).toList();
    fonWords.shuffle();

    double progress = selectedMatches.length / currentExercices.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Niveau $currentLevel - Français ↔ Fon"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress, minHeight: 12),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: currentExercices.length,
                itemBuilder: (context, index) {
                  final frWord = currentExercices[index]['fr']!;
                  final correctFon = currentExercices[index]['fon']!;
                  final selectedFon = selectedMatches[frWord];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(frWord,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          DropdownButton<String>(
                            hint: Text("Choisir une traduction"),
                            value: selectedFon,
                            items: fonWords.map((f) {
                              return DropdownMenuItem<String>(
                                value: f,
                                child: Text(f),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (!isFinished) {
                                setState(() {
                                  selectedMatches[frWord] = value;
                                });
                              }
                            },
                          ),
                          if (isFinished && selectedFon != null)
                            Text(
                              selectedFon == correctFon
                                  ? "✅ Correct"
                                  : "❌ Faux (rép : $correctFon)",
                              style: TextStyle(
                                color: selectedFon == correctFon
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!isFinished)
              ElevatedButton(
                onPressed: selectedMatches.length == currentExercices.length
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
