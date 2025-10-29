// Import du package Flutter de base pour pouvoir utiliser tous les widgets
import 'package:flutter/material.dart';

// Import de la page du niveau 1
import 'package:projetlangue/page/pagefon/fonjeu/exojeuone.dart';
// Import de la page du niveau 2
import 'package:projetlangue/page/pagefon/fonjeu/exojeutwo.dart';
// Import de la page du niveau 3
import 'package:projetlangue/page/pagefon/fonjeu/exojeuthree.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Déclaration d'un widget Stateful pour la page principale du jeu
class JeuPage extends StatefulWidget {
  @override
  _JeuPageState createState() => _JeuPageState(); // Création de l'état associé à ce widget
}

class _JeuPageState extends State<JeuPage> {
  int unlockedLevel = 1;

  @override
  void initState() {
    super.initState();
    _loadUnlockedLevel(); // Charger le niveau sauvegardé
  }

  Future<void> _loadUnlockedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      unlockedLevel = prefs.getInt('unlockedLevel') ?? 1;
    });
  }

  Future<void> _saveUnlockedLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('unlockedLevel', level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parcours d'apprentissage")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            int level = index + 1;
            bool isUnlocked = level <= unlockedLevel;

            return GestureDetector(
              onTap: isUnlocked
                  ? () {
                      Widget page;
                      if (level == 1) {
                        page = ExerciceFon(startLevel: level);
                      } else if (level == 2) {
                        page = ExoJeuTwo(level: level);
                      } else {
                        page = ExoJeuThree(level: level);
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page),
                      ).then((newUnlockedLevel) {
                        if (newUnlockedLevel != null &&
                            newUnlockedLevel > unlockedLevel) {
                          setState(() {
                            unlockedLevel = newUnlockedLevel;
                          });
                          _saveUnlockedLevel(newUnlockedLevel); // 🔥 Sauvegarde ici
                        }
                      });
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: isUnlocked ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                ),
                child: Center(
                  child: Text(
                    isUnlocked ? "Niveau $level" : "🔒 Niveau $level",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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