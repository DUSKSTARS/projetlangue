import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class QuizFon extends StatefulWidget {
  final int startLevel;
  const QuizFon({required this.startLevel, Key? key}) : super(key: key);

  @override
  State<QuizFon> createState() => _QuizFonState();
}

class _QuizFonState extends State<QuizFon> {
  late int currentLevel;
  int currentIndex = 0;
  int score = 0;
  bool showResult = false;

  final List<Map<String, String>> allQuestions = [
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

  List<Map<String, String>> get currentQuestions {
    int nbWords = 4 + (currentLevel - 1) * 2;
    return allQuestions.take(nbWords).toList();
  }

  Future<void> saveScore() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
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

  void checkAnswer(String selected) {
    final correctAnswer = currentQuestions[currentIndex]['fon'];
    bool isCorrect = selected == correctAnswer;

    if (isCorrect) score++;

    if (currentIndex < currentQuestions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      setState(() {
        showResult = true;
      });
      saveScore();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? '✅ Correct !' : '❌ Mauvaise réponse',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showResult) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Résultat - Niveau $currentLevel"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                score == currentQuestions.length
                    ? "assets/images/success.gif"
                    : "assets/images/fail.gif",
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                "Ton score : $score / ${currentQuestions.length}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text("Retour au menu"),
                onPressed: () {
                  Navigator.pop(context, currentLevel + 1);
                },
              ),
            ],
          ),
        ),
      );
    }

    final question = currentQuestions[currentIndex];
    List<String> options =
        currentQuestions.map((e) => e['fon']!).toList()..shuffle();

    double progress = (currentIndex + 1) / currentQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Niveau $currentLevel - Exercice Fon"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              "Traduire en Fon :",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              question['fr']!,
              style: const TextStyle(fontSize: 28, color: Colors.deepPurple),
            ),
            const SizedBox(height: 30),
            ...options.map(
              (opt) => Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(opt),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(opt, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "Question ${currentIndex + 1}/${currentQuestions.length}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
