// Import du package Flutter pour pouvoir utiliser les widgets
import 'package:flutter/material.dart';
// Import de sqflite pour la gestion de la base de données SQLite
import 'package:sqflite/sqflite.dart';
// Import de path pour construire des chemins de fichiers compatibles
import 'package:path/path.dart' as p;

// Déclaration d'un widget Stateful pour gérer l'exercice
class ExerciceFon extends StatefulWidget {
  final int startLevel; // Niveau de départ passé lors de la création
  ExerciceFon({required this.startLevel}); // Constructeur obligatoire

  @override
  _ExerciceFonState createState() => _ExerciceFonState(); // Crée l'état associé
}

// Classe qui gère l'état de ExerciceFon
class _ExerciceFonState extends State<ExerciceFon> {
  int score = 0; // Score de l'utilisateur
  bool isFinished = false; // Booléen pour savoir si le niveau est terminé
  late int currentLevel; // Niveau courant
  Map<String, String?> selectedMatches = {}; // Pour stocker les correspondances choisies

  // Liste de tous les exercices disponibles (français -> fon)
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
    currentLevel = widget.startLevel; // Initialise le niveau courant avec celui passé au widget
  }

  // Sélection des exercices à afficher selon le niveau
  List<Map<String, String>> get currentExercices {
    int nbWords = 4 + (currentLevel - 1) * 2; // Niveau 1: 4 mots, Niveau 2: 6 mots...
    return allExercices.take(nbWords).toList(); // On prend les premiers nbWords de la liste
  }

  // Fonction pour sauvegarder le score dans SQLite
  Future<void> _saveScore() async {
    final dbPath = await getDatabasesPath(); // Récupère le chemin de la base de données
    final path = p.join(dbPath, 'scores.db'); // Chemin complet de la base de données
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) { // Si la base n'existe pas, on crée la table
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

    // Insertion du score dans la table
    await db.insert('scores', {
      'score': score,
      'level': currentLevel,
      'date': DateTime.now().toIso8601String(), // Date actuelle en ISO
    });
  }

  // Fonction pour vérifier les réponses et calculer le score
  void checkAnswers() {
    int newScore = 0;
    for (var ex in currentExercices) {
      if (selectedMatches[ex['fr']] == ex['fon']) { // Si la réponse choisie est correcte
        newScore++; // On augmente le score
      }
    }
    setState(() {
      score = newScore; // Met à jour le score
      isFinished = true; // Marque le niveau comme terminé
    });
    _saveScore(); // Sauvegarde le score dans la base SQLite

    bool isSuccess = score == currentExercices.length; // Si toutes les réponses sont correctes

    // Affiche une boîte de dialogue avec le résultat
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Niveau $currentLevel terminé"),
        content: Column(
          mainAxisSize: MainAxisSize.min, // La colonne prend juste la place nécessaire
          children: [
            Image.asset(
              isSuccess ? "assets/images/success.gif" : "assets/images/fail.gif", // Affiche success ou fail
              height: 120,
            ),
            SizedBox(height: 12), // Espace
            Text("Score : $score/${currentExercices.length}"), // Affiche le score
          ],
        ),
        actions: [
          if (isSuccess) // Si réussi, bouton pour revenir au menu et débloquer le niveau suivant
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
                Navigator.of(context).pop(currentLevel + 1); // Retour au menu et débloque le niveau suivant
              },
              child: Text("👉 Retour au menu (niveau suivant débloqué)"),
            ),
          // Bouton pour recommencer le niveau
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialog
              setState(() {
                score = 0; // Réinitialise le score
                isFinished = false; // Réinitialise l'état
                selectedMatches.clear(); // Vide les réponses choisies
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
    List<String> fonWords = currentExercices.map((e) => e['fon']!).toList(); // Liste de toutes les réponses possibles
    fonWords.shuffle(); // On mélange les options pour le dropdown

    double progress = selectedMatches.length / currentExercices.length; // Pourcentage de progression

    return Scaffold(
      appBar: AppBar(
        title: Text("Niveau $currentLevel - Français ↔ Fon"), // Titre de la page
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding autour du contenu
        child: Column(
          children: [
            LinearProgressIndicator(value: progress, minHeight: 12), // Barre de progression
            SizedBox(height: 8), // Espace
            Expanded( // Prend tout l'espace restant
              child: ListView.builder( // Liste dynamique pour chaque mot
                itemCount: currentExercices.length, // Nombre d'items
                itemBuilder: (context, index) {
                  final frWord = currentExercices[index]['fr']!; // Mot en français
                  final correctFon = currentExercices[index]['fon']!; // Bonne traduction
                  final selectedFon = selectedMatches[frWord]; // Réponse choisie par l'utilisateur

                  return Card( // Conteneur avec ombre
                    margin: EdgeInsets.symmetric(vertical: 8), // Marge verticale
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // Padding interne
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(frWord,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)), // Affiche le mot français
                          DropdownButton<String>( // Dropdown pour choisir la traduction
                            hint: Text("Choisir une traduction"), // Texte avant sélection
                            value: selectedFon, // Valeur sélectionnée
                            items: fonWords.map((f) { // Liste des options
                              return DropdownMenuItem<String>(
                                value: f,
                                child: Text(f),
                              );
                            }).toList(),
                            onChanged: (value) { // Quand l'utilisateur sélectionne une option
                              if (!isFinished) { // Si le niveau n'est pas terminé
                                setState(() {
                                  selectedMatches[frWord] = value; // Met à jour la réponse choisie
                                });
                              }
                            },
                          ),
                          if (isFinished && selectedFon != null) // Affiche le résultat si terminé
                            Text(
                              selectedFon == correctFon
                                  ? "✅ Correct"
                                  : "❌ Faux (rép : $correctFon)", // Correct ou Faux
                              style: TextStyle(
                                color: selectedFon == correctFon
                                    ? Colors.green
                                    : Colors.red, // Couleur selon correct/faux
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!isFinished) // Bouton seulement si le niveau n'est pas terminé
              ElevatedButton(
                onPressed: selectedMatches.length == currentExercices.length
                    ? checkAnswers // Active le bouton seulement si toutes les réponses sont choisies
                    : null,
                child: Text("Valider mes réponses"), // Texte du bouton
              ),
          ],
        ),
      ),
    );
  }
}
