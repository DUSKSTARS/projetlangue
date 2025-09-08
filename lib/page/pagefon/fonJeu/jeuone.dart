import 'package:flutter/material.dart';
import 'package:projetlangue/page/pagefon/fonjeu/exojeuone.dart';
import 'package:projetlangue/page/pagefon/fonjeu/exojeutwo.dart';
import 'package:projetlangue/page/pagefon/fonjeu/exojeuthree.dart';



class JeuPage extends StatefulWidget {
  @override
  _JeuPageState createState() => _JeuPageState();
}

class _JeuPageState extends State<JeuPage> {
  int unlockedLevel = 1;

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
          itemCount: 3, // 3 niveaux
          itemBuilder: (context, index) {
            int level = index + 1;
            bool isUnlocked = level <= unlockedLevel;

            return GestureDetector(
              onTap: isUnlocked
                  ? () {
                      Widget page;
                      if (level == 1) {
                        page = ExerciceFon(startLevel: level); // ton niveau 1
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