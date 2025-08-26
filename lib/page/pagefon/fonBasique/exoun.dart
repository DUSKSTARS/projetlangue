// // Importation des packages nécessaires
// import 'package:flutter/material.dart'; // Pour créer l'interface utilisateur
// import 'package:sqflite/sqflite.dart'; // Pour gérer la base de données SQLite
// import 'package:path/path.dart' as p; // Pour la gestion des chemins de fichiers
// import 'dart:async'; // Pour les délais ou opérations asynchrones
// import 'package:audioplayers/audioplayers.dart'; // Pour lire les fichiers audio

// // Déclaration du widget principal
// class ExerciceFon extends StatefulWidget {
//   @override
//   _ExerciceFonState createState() => _ExerciceFonState(); // Création de l'état
// }

// // État du widget ExerciceFon
// class _ExerciceFonState extends State<ExerciceFon> {
//   final AudioPlayer _audioPlayer = AudioPlayer(); // Initialisation du lecteur audio
//   int currentIndex = 0; // Index de la question actuelle
//   int score = 0; // Score actuel de l'utilisateur
//   String? selectedOption; // Option actuellement sélectionnée
//   String feedbackMessage = ""; // Message de feedback affiché après sélection
//   bool isAnswerCorrect = false; // Booléen pour dire si la réponse est correcte

//   // Liste des questions avec leurs réponses, options, audio, etc.
//   final List<Map<String, dynamic>> exercices = [
//     {
//       'fr': "Bonjour",
//       'options': ["a f̀ɔn à", "Dada gbé", "Mè do wè"],
//       'correct': "a f̀ɔn à",
//       'audio': "bjr.mp3",
//       'explanation': "Correct : 'a f̀ɔn à' signifie 'Bonjour' en Fon."
//     },
//     {
//       'fr': "Comment vas-tu ?",
//       'options': ["nɛ a de gbɔn ?", "A kpe nu", "Dada gbé"],
//       'correct': "nɛ a de gbɔn ?",
//       'audio': "cmtvt.mp3",
//       'explanation': "Correct : 'nɛ a de gbɔn ?' signifie 'Comment vas-tu ?' en Fon."
//     },
//     {
//       'fr': "Merci beaucoup",
//       'options': ["Mè do wè", "A kpe nu", "Tɔn gbé"],
//       'correct': "A kpe nu",
//       'audio': "merci.mp3",
//       'explanation': "Correct : 'A kpe nu' signifie 'Merci beaucoup' en Fon."
//     },
//     {
//       'fr': "Au revoir",
//       'options': ["ma yi bo wa", "A fon gbé", "Dɔ gbe na ?"],
//       'correct': "ma yi bo wa",
//       'audio': "av.mp3",
//       'explanation': "Correct : 'ma yi bo wa' signifie 'Au revoir' en Fon."
//     },
//   ];

//   // Fonction pour jouer un fichier audio
//   void playAudio(String fileName) async {
//     await _audioPlayer.play(AssetSource('vocal/$fileName')); // Lecture de l'audio depuis assets/vocal
//   }

//   // Fonction appelée quand l'utilisateur choisit une réponse
//   void checkAnswer(String selected) {
//     setState(() {
//       selectedOption = selected; // On garde l'option sélectionnée
//       if (selected == exercices[currentIndex]['correct']) {
//         score++; // Incrémente le score si la réponse est correcte
//         isAnswerCorrect = true;
//         feedbackMessage = "Correct!";
//       } else {
//         isAnswerCorrect = false;
//         feedbackMessage = "Incorrect. ${exercices[currentIndex]['explanation']}"; // Explication affichée
//       }
//     });

//     // Délai de 2 secondes avant d'afficher la prochaine question ou le score
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         if (currentIndex < exercices.length - 1) {
//           currentIndex++; // Passe à la question suivante
//           selectedOption = null;
//           feedbackMessage = "";
//         } else {
//           // Si c'était la dernière question, on enregistre et on affiche le score
//           _showFinalScore();
//         }
//       });
//     });
//   }

//   // Fonction pour afficher la boîte de dialogue finale et enregistrer dans la base
//   Future<void> _showFinalScore() async {
//     final dbPath = await getDatabasesPath(); // Récupère le chemin de stockage
//     final path = p.join(dbPath, 'scores.db'); // Nom du fichier base
//     final db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute('''
//           CREATE TABLE IF NOT EXISTS scores (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             score INTEGER,
//             date TEXT
//           )
//         ''');
//       },
//     );

//     await db.insert('scores', {
//       'score': score,
//       'date': DateTime.now().toIso8601String(),
//     }); // Enregistrement du score et date

//     // Affiche une boîte de dialogue
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Exercice terminé"),
//         content: Text("Score : $score/${exercices.length}"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Ferme le dialogue
//               setState(() {
//                 // Réinitialisation
//                 currentIndex = 0;
//                 score = 0;
//                 selectedOption = null;
//                 feedbackMessage = "";
//               });
//             },
//             child: Text("Recommencer"),
//           )
//         ],
//       ),
//     );
//   }

//   // Fonction pour afficher les anciens scores enregistrés
//   Future<void> showOldScores() async {
//     final dbPath = await getDatabasesPath(); // Chemin de la base
//     final path = p.join(dbPath, 'scores.db'); // Nom de la base
//     final db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute('''
//           CREATE TABLE IF NOT EXISTS scores (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             score INTEGER,
//             date TEXT
//           )
//         ''');
//       },
//     );

//     final List<Map<String, dynamic>> scores = await db.query('scores'); // Récupère les lignes

//     // Affichage d'une boîte de dialogue contenant la liste
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Mes anciens scores"),
//         content: Container(
//           width: double.maxFinite,
//           height: 300,
//           child: scores.isEmpty
//               ? Center(child: Text("Aucun score enregistré."))
//               : ListView.builder(
//                   itemCount: scores.length,
//                   itemBuilder: (context, index) {
//                     final s = scores[index];
//                     return ListTile(
//                       title: Text("Score : ${s['score']}"),
//                       subtitle: Text("Date : ${s['date']}"),
//                     );
//                   },
//                 ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), // Ferme le dialogue
//             child: Text("Fermer"),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double progress = (currentIndex + 1) / exercices.length; // Calcule la progression

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Exercice : Français - Fon"), // Titre
//         actions: [
//           IconButton(
//             icon: Icon(Icons.bar_chart), // Icône pour consulter les scores
//             tooltip: "Voir les scores",
//             onPressed: showOldScores, // Appelle la fonction des anciens scores
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             LinearProgressIndicator(value: progress), // Barre de progression
//             SizedBox(height: 20),

//             Text(
//               exercices[currentIndex]['fr'], // Affiche la phrase en français
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 50),

//             // Liste des options en bouton
//             ...exercices[currentIndex]['options'].map<Widget>((option) {
//               Color buttonColor = Colors.white; // Couleur par défaut

//               if (selectedOption != null) {
//                 if (option == exercices[currentIndex]['correct']) {
//                   buttonColor = selectedOption == option ? Colors.green : Colors.white;
//                 } else if (option == selectedOption) {
//                   buttonColor = Colors.red;
//                 }
//               }

//               return ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: buttonColor), // Applique la couleur
//                 onPressed: selectedOption == null ? () => checkAnswer(option) : null, // Empêche de recliquer
//                 child: Text(option, style: TextStyle(fontSize: 18)),
//               );
//             }).toList(),

//             SizedBox(height: 20),

//             // Affiche feedback si une réponse a été donnée
//             if (selectedOption != null)
//               Text(
//                 feedbackMessage,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: isAnswerCorrect ? Colors.green : Colors.red,
//                 ),
//               ),

//             SizedBox(height: 50),

//             // Icône pour écouter l'audio
//             IconButton(
//               icon: Icon(Icons.volume_up, color: Colors.blue, size: 30),
//               onPressed: () => playAudio(exercices[currentIndex]['audio']),
//             ),
//           ],
//         ),
//       ),

//       // Bouton retour
//       floatingActionButton: FloatingActionButton(
//         heroTag: "returnButton",
//         onPressed: () {
//           Navigator.pop(context); // Retour à l'écran précédent
//         },
//         child: Text("Retour", style: TextStyle(fontSize: 10)),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }



// Importation des packages nécessaires
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class ExerciceFon extends StatefulWidget {
  @override
  _ExerciceFonState createState() => _ExerciceFonState();
}

class _ExerciceFonState extends State<ExerciceFon> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  int score = 0;
  String? selectedOption;
  String feedbackMessage = "";
  bool isAnswerCorrect = false;

  final List<Map<String, dynamic>> exercices = [
    {
      'fr': "Bonjour",
      'options': ["a f̀ɔn à", "Dada gbé", "Mè do wè"],
      'correct': "a f̀ɔn à",
      'audio': "bjr.mp3",
      'explanation': "Correct : 'a f̀ɔn à' signifie 'Bonjour' en Fon."
    },
    {
      'fr': "Comment vas-tu ?",
      'options': ["nɛ a de gbɔn ?", "A kpe nu", "Dada gbé"],
      'correct': "nɛ a de gbɔn ?",
      'audio': "cmtvt.mp3",
      'explanation': "Correct : 'nɛ a de gbɔn ?' signifie 'Comment vas-tu ?' en Fon."
    },
    {
      'fr': "Merci beaucoup",
      'options': ["Mè do wè", "A kpe nu", "Tɔn gbé"],
      'correct': "A kpe nu",
      'audio': "merci.mp3",
      'explanation': "Correct : 'A kpe nu' signifie 'Merci beaucoup' en Fon."
    },
    {
      'fr': "Au revoir",
      'options': ["ma yi bo wa", "A fon gbé", "Dɔ gbe na ?"],
      'correct': "ma yi bo wa",
      'audio': "av.mp3",
      'explanation': "Correct : 'ma yi bo wa' signifie 'Au revoir' en Fon."
    },
  ];

  // Jouer l'audio
  void playAudio(String fileName) async {
    await _audioPlayer.play(AssetSource('vocal/$fileName'));
  }

  void checkAnswer(String selected) {
    setState(() {
      selectedOption = selected;
      if (selected == exercices[currentIndex]['correct']) {
        score++;
        isAnswerCorrect = true;
        feedbackMessage = "Correct!";
      } else {
        isAnswerCorrect = false;
        feedbackMessage = "Incorrect. ${exercices[currentIndex]['explanation']}";
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        if (currentIndex < exercices.length - 1) {
          currentIndex++;
          selectedOption = null;
          feedbackMessage = "";
        } else {
          _showFinalScore();
        }
      });
    });
  }

  Future<void> _showFinalScore() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS scores (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER,
            totalQuestions INTEGER,
            date TEXT
          )
        ''');
      },
    );

    await db.insert('scores', {
      'score': score,
      'totalQuestions': exercices.length,
      'date': DateTime.now().toIso8601String(),
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exercice terminé"),
        content: Text("Score : $score/${exercices.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                currentIndex = 0;
                score = 0;
                selectedOption = null;
                feedbackMessage = "";
              });
            },
            child: Text("Recommencer"),
          )
        ],
      ),
    );
  }

  Future<void> showOldScores() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');
    final db = await openDatabase(path, version: 1);
    final List<Map<String, dynamic>> scores = await db.query('scores');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Mes anciens scores"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: scores.isEmpty
              ? Center(child: Text("Aucun score enregistré."))
              : ListView.builder(
                  itemCount: scores.length,
                  itemBuilder: (context, index) {
                    final s = scores[index];
                    return ListTile(
                      title: Text("Score : ${s['score']}/${s['totalQuestions']}"),
                      subtitle: Text("Date : ${s['date']}"),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fermer"),
          )
        ],
      ),
    );
  }

  // ✅ Fonction pour récupérer la moyenne globale
  Future<int> getAverageScore() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');
    final db = await openDatabase(path, version: 1);
    final List<Map<String, dynamic>> scores = await db.query('scores');
    if (scores.isEmpty) return 0;

    int totalScore = 0;
    int totalQuestions = 0;
    for (var s in scores) {
      totalScore += s['score'] as int;
      totalQuestions += s['totalQuestions'] as int;
    }
    return ((totalScore / totalQuestions) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / exercices.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice : Français - Fon"),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            tooltip: "Voir les scores",
            onPressed: showOldScores,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: progress),
            SizedBox(height: 20),
            Text(
              exercices[currentIndex]['fr'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            ...exercices[currentIndex]['options'].map<Widget>((option) {
              Color buttonColor = Colors.white;
              if (selectedOption != null) {
                if (option == exercices[currentIndex]['correct']) {
                  buttonColor =
                      selectedOption == option ? Colors.green : Colors.white;
                } else if (option == selectedOption) {
                  buttonColor = Colors.red;
                }
              }
              return ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                onPressed: selectedOption == null ? () => checkAnswer(option) : null,
                child: Text(option, style: TextStyle(fontSize: 18)),
              );
            }).toList(),
            SizedBox(height: 20),
            if (selectedOption != null)
              Text(
                feedbackMessage,
                style: TextStyle(
                  fontSize: 18,
                  color: isAnswerCorrect ? Colors.green : Colors.red,
                ),
              ),
            SizedBox(height: 50),
            IconButton(
              icon: Icon(Icons.volume_up, color: Colors.blue, size: 30),
              onPressed: () => playAudio(exercices[currentIndex]['audio']),
            ),
            SizedBox(height: 20),
            // ✅ Affichage de la moyenne globale
            FutureBuilder<int>(
              future: getAverageScore(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return SizedBox();
                return Text(
                  "Moyenne globale : ${snapshot.data}%",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "returnButton",
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Retour", style: TextStyle(fontSize: 10)),
        backgroundColor: Colors.red,
      ),
    );
  }
}
