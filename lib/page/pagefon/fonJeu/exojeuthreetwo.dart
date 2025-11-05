// Import du package Flutter pour construire les widgets
import 'package:flutter/material.dart';
// Import de sqflite pour la gestion de la base SQLite
import 'package:sqflite/sqflite.dart';
// Import de path pour les chemins de fichiers
import 'package:path/path.dart' as p;

// Déclaration du widget pour le jeu "Vrai ou Faux"
class JeuVraiFaux extends StatefulWidget {
  final int level; // Niveau actuel
  JeuVraiFaux({required this.level});

  @override
  _JeuVraiFauxState createState() => _JeuVraiFauxState();
}

// Classe qui gère l'état du jeu
class _JeuVraiFauxState extends State<JeuVraiFaux> {
  int score = 0; // Score du joueur
  bool isFinished = false; // Si le niveau est terminé
  Map<int, bool?> selectedAnswers = {}; // Réponses du joueur

  // Liste d'affirmations (avec réponse vraie ou fausse)
  final List<Map<String, dynamic>> questions = [
    {
      "statement": "Le mot 'Mawu' veut dire 'Dieu' en fon.",
      "answer": true
    },
    {
      "statement": "Le mot 'Agɔ' signifie 'Maison'.",
      "answer": true
    },
    {
      "statement": "En fon, 'Tɔ' veut dire 'Pain'.",
      "answer": false
    },
    {
      "statement": "Le mot 'Aklui' signifie 'Pain' en fon.",
      "answer": true
    },
    {
      "statement": "‘A fɔ̀n à’ veut dire 'Au revoir'.",
      "answer": false
    },
  ];

  // Sauvegarde du score dans la base SQLite
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

  // Vérifie les réponses et calcule le score
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

    // Affiche une boîte de dialogue de résultat
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
            Text("Score : $score/${questions.length}",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          if (isSuccess)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(widget.level + 1);
              },
              child: Text("👉 Retour au menu (niveau suivant débloqué)"),
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
    double progress = selectedAnswers.length / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Niveau ${widget.level} - Vrai ou Faux"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress, minHeight: 12),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  final selected = selectedAnswers[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(q["statement"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.check),
                                  label: Text("Vrai"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selected == true
                                        ? Colors.green
                                        : Colors.grey[300],
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (!isFinished) {
                                      setState(() {
                                        selectedAnswers[index] = true;
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.close),
                                  label: Text("Faux"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selected == false
                                        ? Colors.red
                                        : Colors.grey[300],
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (!isFinished) {
                                      setState(() {
                                        selectedAnswers[index] = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          if (isFinished && selected != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                selected == q["answer"]
                                    ? "✅ Correct"
                                    : "❌ Faux",
                                style: TextStyle(
                                  color: selected == q["answer"]
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
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
