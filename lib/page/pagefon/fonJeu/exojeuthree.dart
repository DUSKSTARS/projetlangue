// Import du package Flutter pour utiliser les widgets
import 'package:flutter/material.dart';
// Import de sqflite pour gérer la base de données SQLite
import 'package:sqflite/sqflite.dart';
// Import de path pour construire des chemins de fichiers compatibles
import 'package:path/path.dart' as p;
// Import d'audioplayers pour jouer des fichiers audio
import 'package:audioplayers/audioplayers.dart';

// Déclaration du widget Stateful pour le jeu niveau 3
class ExoJeuThree extends StatefulWidget {
  final int level; // Niveau actuel passé lors de la création
  ExoJeuThree({required this.level}); // Constructeur obligatoire

  @override
  _ExoJeuThreeState createState() => _ExoJeuThreeState(); // Crée l'état associé
}

// Classe qui gère l'état de ExoJeuThree
class _ExoJeuThreeState extends State<ExoJeuThree> {
  int score = 0; // Score du joueur
  bool isFinished = false; // Booléen pour savoir si le niveau est terminé
  Map<int, List<String>> selectedWords = {}; // Mots choisis par question
  final player = AudioPlayer(); // Lecteur audio

  // Liste des questions avec options, réponse correcte et fichier audio
  final List<Map<String, dynamic>> questions = [
    {
      "options": ["Je", "vais", "à", "l'école"], // Options à arranger
      "answer": "Je vais à l'école", // Réponse correcte
      "audio": "vocal/nnn.mp3" // Fichier audio associé
    },
    {
      "options": ["Il", "mange", "du", "pain"],
      "answer": "Il mange du pain",
      "audio": "vocal/nnn.mp3"
    },
  ];

  // Fonction pour sauvegarder le score dans SQLite
  Future<void> _saveScore() async {
    final dbPath = await getDatabasesPath(); // Récupère le chemin de la DB
    final path = p.join(dbPath, 'scores.db'); // Chemin complet de la DB
    final db = await openDatabase(path, version: 1, onCreate: (db, version) {
      // Création de la table si elle n'existe pas
      return db.execute('''
        CREATE TABLE IF NOT EXISTS scores (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          score INTEGER,
          level INTEGER,
          date TEXT
        )
      ''');
    });

    // Insertion du score dans la table
    await db.insert('scores', {
      'score': score,
      'level': widget.level,
      'date': DateTime.now().toIso8601String(), // Date actuelle
    });
  }

  // Fonction pour vérifier les réponses et calculer le score
  void checkAnswers() {
    int newScore = 0;
    for (int i = 0; i < questions.length; i++) {
      // Compare la phrase formée par l'utilisateur avec la réponse correcte
      if ((selectedWords[i] ?? []).join(" ") == questions[i]["answer"]) {
        newScore++; // Si correct, incrémente le score
      }
    }
    setState(() {
      score = newScore; // Met à jour le score
      isFinished = true; // Marque le niveau comme terminé
    });
    _saveScore(); // Sauvegarde le score

    bool isSuccess = score == questions.length; // Vérifie si toutes les réponses sont correctes

    // Affiche une boîte de dialogue avec le résultat
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Niveau ${widget.level} terminé"), // Titre du dialog
        content: Column(
          mainAxisSize: MainAxisSize.min, // Colonne prend juste la place nécessaire
          children: [
            Image.asset(
              isSuccess
                  ? "assets/images/success.gif" // Image succès si réussi
                  : "assets/images/fail.gif", // Image échec si faux
              height: 120,
            ),
            SizedBox(height: 12), // Espace vertical
            Text("Score : $score/${questions.length}"), // Affiche le score
          ],
        ),
        actions: [
          if (isSuccess) // Si réussi, bouton pour revenir au menu
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
                Navigator.of(context).pop(widget.level + 1); // Retour menu et débloque suivant
              },
              child: Text("👉 Retour au menu"),
            ),
          // Bouton pour recommencer le niveau
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialog
              setState(() {
                score = 0; // Réinitialise le score
                isFinished = false; // Réinitialise l'état
                selectedWords.clear(); // Vide les mots choisis
              });
            },
            child: Text("🔄 Recommencer"),
          ),
        ],
      ),
    );
  }

  // Widget pour afficher une phrase à former par mots
  Widget buildPhrase(int index, Map<String, dynamic> q) {
    List<String> choisis = selectedWords[index] ?? []; // Mots déjà choisis
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8), // Marge verticale
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Padding interne
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Arrange les mots pour former la phrase",
                style: TextStyle(fontWeight: FontWeight.bold)), // Consigne
            Wrap(
              spacing: 8, // Espacement entre les mots
              children: q["options"].map<Widget>((mot) {
                return ChoiceChip(
                  label: Text(mot), // Affiche le mot
                  selected: choisis.contains(mot), // Si déjà choisi
                  onSelected: (selected) {
                    if (!isFinished) { // Si le niveau n'est pas terminé
                      setState(() {
                        if (selected) {
                          choisis.add(mot); // Ajouter mot choisi
                        } else {
                          choisis.remove(mot); // Retirer mot
                        }
                        selectedWords[index] = choisis; // Met à jour la sélection
                      });
                    }
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10), // Espace vertical
            // Bouton pour écouter la phrase
            ElevatedButton.icon(
              icon: Icon(Icons.volume_up),
              label: Text("Écouter"),
              onPressed: () async {
                await player.play(AssetSource(q["audio"])); // Joue le fichier audio
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
      appBar: AppBar(title: Text("Niveau ${widget.level} - Phrase")), // Barre d'app
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding autour du contenu
        child: Column(
          children: [
            Expanded(
              child: ListView.builder( // Liste des phrases
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return buildPhrase(index, questions[index]); // Affiche chaque phrase
                },
              ),
            ),
            if (!isFinished) // Bouton seulement si le niveau n'est pas terminé
              ElevatedButton(
                onPressed:
                    selectedWords.length == questions.length ? checkAnswers : null, // Active si toutes phrases complètes
                child: Text("Valider"), // Texte du bouton
              ),
          ],
        ),
      ),
    );
  }
}
