// Import du package Flutter pour créer les widgets
import 'package:flutter/material.dart';
// Import de sqflite pour gérer la base de données SQLite
import 'package:sqflite/sqflite.dart';
// Import de path pour construire des chemins compatibles avec le système
import 'package:path/path.dart' as p;

// Déclaration du widget Stateful pour le niveau 2 (QCM)
class ExoJeuTwo extends StatefulWidget {
  final int level; // Niveau passé lors de la création du widget
  ExoJeuTwo({required this.level}); // Constructeur obligatoire

  @override
  _ExoJeuTwoState createState() => _ExoJeuTwoState(); // Crée l'état associé
}

// Classe qui gère l'état de ExoJeuTwo
class _ExoJeuTwoState extends State<ExoJeuTwo> {
  int score = 0; // Score du joueur
  bool isFinished = false; // Booléen pour savoir si le niveau est terminé
  Map<int, String?> selectedAnswers = {}; // Réponses choisies par question

  // Liste des questions avec options et réponse correcte
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Comment dit-on 'Bonjour' en fon ?", // Question
      "options": ["a fɔ̀n à", "ma yi bo wa", "Mawu"], // Options disponibles
      "answer": "a fɔ̀n à" // Réponse correcte
    },
    {
      "question": "Que veut dire 'Agɔ' ?",
      "options": ["Maison", "Pain", "Eau"],
      "answer": "Maison"
    },
  ];

  // Fonction pour sauvegarder le score dans la base SQLite
  Future<void> _saveScore() async {
    final dbPath = await getDatabasesPath(); // Chemin de la base de données
    final path = p.join(dbPath, 'scores.db'); // Chemin complet vers scores.db
    final db = await openDatabase(path, version: 1, onCreate: (db, version) {
      // Création de la table scores si elle n'existe pas
      return db.execute('''
        CREATE TABLE IF NOT EXISTS scores (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          score INTEGER,
          level INTEGER,
          date TEXT
        )
      ''');
    });

    // Insertion du score actuel dans la table
    await db.insert('scores', {
      'score': score,
      'level': widget.level,
      'date': DateTime.now().toIso8601String(), // Date et heure actuelle
    });
  }

  // Fonction pour vérifier les réponses et calculer le score
  void checkAnswers() {
    int newScore = 0; // Score temporaire
    for (int i = 0; i < questions.length; i++) {
      // Compare la réponse choisie avec la réponse correcte
      if (selectedAnswers[i] == questions[i]["answer"]) {
        newScore++; // Incrémente si correct
      }
    }
    setState(() {
      score = newScore; // Met à jour le score
      isFinished = true; // Marque le niveau comme terminé
    });
    _saveScore(); // Sauvegarde le score dans SQLite

    bool isSuccess = score == questions.length; // Vérifie si toutes les réponses sont correctes

    // Affiche une boîte de dialogue pour le résultat
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Niveau ${widget.level} terminé"), // Titre du dialog
        content: Column(
          mainAxisSize: MainAxisSize.min, // Colonne prend juste la place nécessaire
          children: [
            Image.asset(
              isSuccess
                  ? "assets/images/success.gif" // Image succès si réussite
                  : "assets/images/fail.gif", // Image échec sinon
              height: 120,
            ),
            SizedBox(height: 12), // Espace vertical
            Text("Score : $score/${questions.length}"), // Affiche le score
          ],
        ),
        actions: [
          if (isSuccess) // Si réussite, bouton pour débloquer le niveau suivant
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
                Navigator.of(context).pop(widget.level + 1); // Retour au menu et débloque suivant
              },
              child: Text("👉 Retour au menu"),
            ),
          // Bouton pour recommencer le niveau
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialog
              setState(() {
                score = 0; // Réinitialise le score
                isFinished = false; // Réinitialise l'état du niveau
                selectedAnswers.clear(); // Vide les réponses sélectionnées
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
    return Scaffold(
      appBar: AppBar(title: Text("Niveau ${widget.level} - QCM")), // Barre d'app
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding autour du contenu
        child: Column(
          children: [
            Expanded(
              child: ListView.builder( // Liste des questions
                itemCount: questions.length, // Nombre de questions
                itemBuilder: (context, index) {
                  final q = questions[index]; // Question courante
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8), // Marge verticale
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // Padding interne
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(q["question"], // Affiche la question
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          ...q["options"].map<Widget>((opt) { // Boucle sur les options
                            return RadioListTile<String>(
                              title: Text(opt), // Texte de l'option
                              value: opt, // Valeur associée
                              groupValue: selectedAnswers[index], // Valeur sélectionnée
                              onChanged: (value) {
                                if (!isFinished) { // Si le niveau n'est pas terminé
                                  setState(() {
                                    selectedAnswers[index] = value; // Met à jour la sélection
                                  });
                                }
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!isFinished) // Bouton seulement si le niveau n'est pas terminé
              ElevatedButton(
                onPressed: selectedAnswers.length == questions.length
                    ? checkAnswers // Active si toutes les questions ont une réponse
                    : null,
                child: Text("Valider mes réponses"), // Texte du bouton
              ),
          ],
        ),
      ),
    );
  }
}
