// Import du package Flutter de base pour pouvoir utiliser tous les widgets
import 'package:flutter/material.dart';

// Import de la page du niveau 1
import 'package:projetlangue/page/pagefon/fonjeu/exojeuone.dart';
// Import de la page du niveau 2
import 'package:projetlangue/page/pagefon/fonjeu/exojeutwo.dart';
// Import de la page du niveau 3
import 'package:projetlangue/page/pagefon/fonjeu/exojeuthree.dart';

// Déclaration d'un widget Stateful pour la page principale du jeu
class JeuPage extends StatefulWidget {
  @override
  _JeuPageState createState() => _JeuPageState(); // Création de l'état associé à ce widget
}

// Classe qui gère l'état de la page JeuPage
class _JeuPageState extends State<JeuPage> {
  int unlockedLevel = 1; // Niveau maximum débloqué (par défaut le 1er niveau)

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold fournit la structure de base d'une page (AppBar, body, etc.)
      appBar: AppBar(title: Text("Parcours d'apprentissage")), // Barre de titre en haut de la page
      body: Padding( // Ajouter un padding autour du contenu principal
        padding: const EdgeInsets.all(16.0), // Padding de 16 pixels sur tous les côtés
        child: GridView.builder( // Crée une grille dynamique pour afficher les niveaux
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colonnes dans la grille
            crossAxisSpacing: 16, // Espacement horizontal entre les éléments
            mainAxisSpacing: 16, // Espacement vertical entre les éléments
          ),
          itemCount: 3, // Nombre total d'éléments dans la grille (3 niveaux)
          itemBuilder: (context, index) { // Fonction qui construit chaque élément de la grille
            int level = index + 1; // Le niveau correspond à l'index +1 (index commence à 0)
            bool isUnlocked = level <= unlockedLevel; // Vérifie si ce niveau est débloqué

            return GestureDetector( // Widget pour détecter le clic sur le niveau
              onTap: isUnlocked // Si le niveau est débloqué
                  ? () {
                      Widget page; // Variable pour stocker la page à ouvrir

                      // Sélection de la page à ouvrir selon le niveau
                      if (level == 1) {
                        page = ExerciceFon(startLevel: level); // Niveau 1
                      } else if (level == 2) {
                        page = ExoJeuTwo(level: level); // Niveau 2
                      } else {
                        page = ExoJeuThree(level: level); // Niveau 3
                      }

                      // Navigation vers la page correspondante
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page),
                      ).then((newUnlockedLevel) { // Fonction exécutée quand on revient de la page
                        if (newUnlockedLevel != null &&
                            newUnlockedLevel > unlockedLevel) { // Si un nouveau niveau est débloqué
                          setState(() {
                            unlockedLevel = newUnlockedLevel; // Met à jour le niveau débloqué
                          });
                        }
                      });
                    }
                  : null, // Si le niveau est verrouillé, on ne fait rien au clic
              child: Container( // Conteneur pour styliser le niveau
                decoration: BoxDecoration(
                  color: isUnlocked ? Colors.blue : Colors.grey, // Couleur bleue si débloqué, grise sinon
                  borderRadius: BorderRadius.circular(16), // Coins arrondis
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)], // Ombre portée
                ),
                child: Center( // Centre le texte à l'intérieur du conteneur
                  child: Text(
                    isUnlocked ? "Niveau $level" : "🔒 Niveau $level", // Affiche verrouillé ou non
                    style: TextStyle(
                        fontSize: 20, // Taille du texte
                        fontWeight: FontWeight.bold, // Gras
                        color: Colors.white), // Couleur du texte blanc
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
