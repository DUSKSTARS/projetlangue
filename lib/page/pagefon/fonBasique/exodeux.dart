// Importation des packages nécessaires
import 'package:flutter/material.dart'; // Pour créer l'interface utilisateur
import 'package:sqflite/sqflite.dart'; // Pour gérer la base de données SQLite
import 'package:path/path.dart' as p; // Pour la gestion des chemins de fichiers
import 'dart:async'; // Pour les délais ou opérations asynchrones
import 'package:audioplayers/audioplayers.dart'; // Pour lire les fichiers audio

// Déclaration du widget principal
class ExerciceFondeux extends StatefulWidget {
  @override
  _ExerciceFondeuxState createState() => _ExerciceFondeuxState(); // Création de l'état
}

// État du widget ExerciceFondeux
class _ExerciceFondeuxState extends State<ExerciceFondeux> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Initialisation du lecteur audio
  int currentIndex = 0; // Index de la question actuelle
  int score = 0; // Score actuel de l'utilisateur
  String? selectedOption; // Option actuellement sélectionnée
  String feedbackMessage = ""; // Message de feedback affiché après sélection
  bool isAnswerCorrect = false; // Booléen pour dire si la réponse est correcte

  // Liste des questions avec leurs réponses, options, audio, etc.
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

  // Fonction pour jouer un fichier audio
  void playAudio(String fileName) async {
    await _audioPlayer.play(AssetSource('vocal/$fileName')); // Lecture de l'audio depuis assets/vocal
  }

  // Fonction appelée quand l'utilisateur choisit une réponse
  void checkAnswer(String selected) {
    setState(() {
      selectedOption = selected; // On garde l'option sélectionnée
      if (selected == exercices[currentIndex]['correct']) {
        score++; // Incrémente le score si la réponse est correcte
        isAnswerCorrect = true;
        feedbackMessage = "Correct!";
      } else {
        isAnswerCorrect = false;
        feedbackMessage =
            "Incorrect. ${exercices[currentIndex]['explanation']}"; // Explication affichée
      }
    });

    // Délai de 2 secondes avant d'afficher la prochaine question ou le score
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        if (currentIndex < exercices.length - 1) {
          currentIndex++; // Passe à la question suivante
          selectedOption = null;
          feedbackMessage = "";
        } else {
          // Si c'était la dernière question, on enregistre et on affiche le score
          _showFinalScore();
        }
      });
    });
  }

  // Fonction pour afficher la boîte de dialogue finale et enregistrer dans la base
  Future<void> _showFinalScore() async {
    final dbPath = await getDatabasesPath(); // Récupère le chemin de stockage
    final path = p.join(dbPath, 'scores.db'); // Nom du fichier base

    // ⚠️ Supprime l’ancienne base (une seule fois pour éviter le bug de colonne manquante)
    await deleteDatabase(path);

    final db = await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scores (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER,
            date TEXT,
            categorie TEXT
          )
        ''');
      },
    );

    await db.insert('scores', {
      'score': score,
      'date': DateTime.now().toIso8601String(),
      'categorie': 'nombres',
    });

    // Affiche une boîte de dialogue
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exercice terminé"),
        content: Text("Score : $score/${exercices.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialogue
              setState(() {
                // Réinitialisation
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

  // Fonction pour afficher les anciens scores enregistrés
  Future<void> showOldScores() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');

    final db = await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scores (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER,
            date TEXT,
            categorie TEXT
          )
        ''');
      },
    );

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
                      title: Text("Score : ${s['score']}"),
                      subtitle: Text("Date : ${s['date']} — Catégorie : ${s['categorie']}"),
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
                onPressed:
                    selectedOption == null ? () => checkAnswer(option) : null,
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
