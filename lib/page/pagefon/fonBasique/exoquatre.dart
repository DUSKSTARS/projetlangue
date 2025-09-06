// Importation des packages nécessaires
import 'package:flutter/material.dart'; // Pour créer l'interface utilisateur
import 'package:sqflite/sqflite.dart'; // Pour gérer la base de données SQLite
import 'package:path/path.dart' as p; // Pour la gestion des chemins de fichiers
import 'dart:async'; // Pour les délais ou opérations asynchrones
import 'package:audioplayers/audioplayers.dart'; // Pour lire les fichiers audio

// Déclaration du widget principal
class ExerciceFonquatre extends StatefulWidget {
  @override
  _ExerciceFonquatreState createState() => _ExerciceFonquatreState(); // Création de l'état
}

// État du widget ExerciceFonquatre
class _ExerciceFonquatreState extends State<ExerciceFonquatre> {
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
        feedbackMessage = "Incorrect. ${exercices[currentIndex]['explanation']}"; // Explication affichée
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
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE IF NOT EXISTS scores (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER,
            date TEXT
          )
        ''');
      },
    );

    await db.insert('scores', {
      'score': score,
      'date': DateTime.now().toIso8601String(),
    }); // Enregistrement du score et date

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
    final dbPath = await getDatabasesPath(); // Chemin de la base
    final path = p.join(dbPath, 'scores.db'); // Nom de la base
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE IF NOT EXISTS scores (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER,
            date TEXT
          )
        ''');
      },
    );

    final List<Map<String, dynamic>> scores = await db.query('scores'); // Récupère les lignes

    // Affichage d'une boîte de dialogue contenant la liste
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
                      subtitle: Text("Date : ${s['date']}"),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Ferme le dialogue
            child: Text("Fermer"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / exercices.length; // Calcule la progression

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice : Français - Fon"), // Titre
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart), // Icône pour consulter les scores
            tooltip: "Voir les scores",
            onPressed: showOldScores, // Appelle la fonction des anciens scores
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: progress), // Barre de progression
            SizedBox(height: 20),

            Text(
              exercices[currentIndex]['fr'], // Affiche la phrase en français
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),

            // Liste des options en bouton
            ...exercices[currentIndex]['options'].map<Widget>((option) {
              Color buttonColor = Colors.white; // Couleur par défaut

              if (selectedOption != null) {
                if (option == exercices[currentIndex]['correct']) {
                  buttonColor = selectedOption == option ? Colors.green : Colors.white;
                } else if (option == selectedOption) {
                  buttonColor = Colors.red;
                }
              }

              return ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: buttonColor), // Applique la couleur
                onPressed: selectedOption == null ? () => checkAnswer(option) : null, // Empêche de recliquer
                child: Text(option, style: TextStyle(fontSize: 18)),
              );
            }).toList(),

            SizedBox(height: 20),

            // Affiche feedback si une réponse a été donnée
            if (selectedOption != null)
              Text(
                feedbackMessage,
                style: TextStyle(
                  fontSize: 18,
                  color: isAnswerCorrect ? Colors.green : Colors.red,
                ),
              ),

            SizedBox(height: 50),

            // Icône pour écouter l'audio
            IconButton(
              icon: Icon(Icons.volume_up, color: Colors.blue, size: 30),
              onPressed: () => playAudio(exercices[currentIndex]['audio']),
            ),
          ],
        ),
      ),

      // Bouton retour
      floatingActionButton: FloatingActionButton(
        heroTag: "returnButton",
        onPressed: () {
          Navigator.pop(context); // Retour à l'écran précédent
        },
        child: Text("Retour", style: TextStyle(fontSize: 10)),
        backgroundColor: Colors.red,
      ),
    );
  }
}