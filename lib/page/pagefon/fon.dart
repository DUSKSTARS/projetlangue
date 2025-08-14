import 'package:flutter/material.dart';
import 'package:projetlangue/page/pagefon/fonBasique/salutation.dart';
import 'package:projetlangue/page/pagefon/fonBasique/nombre.dart';
import 'package:projetlangue/page/pagefon/fonBasique/phraseun.dart';
import 'package:projetlangue/page/pagefon/fonBasique/exoun.dart';
import 'package:projetlangue/page/pagefon/fonBasique/corps.dart';

class FonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // Pour centrer le contenu
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [


              Center(
                // premiere partie, le premier cercle
                child: Container(
                  decoration: BoxDecoration(
                    // couleur du cercle transparent
                      color: Colors.transparent,
                      // les bord en vert
                      border: Border.all(
                        color: Colors.green, // couleur des bords
                        width: 4.0, // épaisseur du bord
                      ),
                      shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Vocabulaire\nde base",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Salutation",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Les nombres",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Phrases\nBasiques",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // il s'agit du chemin vers la page couleur
                          builder: (context) => PhrPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Couleurs",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // il s'agit du chemin vers la page des parties du corps
                          builder: (context) => CorpsPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Parties\ndu corps",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // chemin vers la page des objets courants
                          builder: (context) => SltPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Object\ncourants",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  imageButton('assets/images/exounn.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceFon(),
                        ));
                  }),
                ],
              ),
              SizedBox(height: 25),



              // deuxieme partie
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Expressions\nCourantes",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Se présenter",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Demander\nde l'aide",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Phrases\nau marché",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // il s'agit du chemin vers la page couleur
                          builder: (context) => PhrPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "A l'école",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // il s'agit du chemin vers la page des parties du corps
                          builder: (context) => CorpsPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "A la maison",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),


              // troisieme partie
              Center(
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Jeux\n&\nQuiz",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Salutation",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Les nombres",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Phrases\nBasiques",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // il s'agit du chemin vers la page couleur
                          builder: (context) => PhrPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Couleurs",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // il s'agit du chemin vers la page des parties du corps
                          builder: (context) => CorpsPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Parties\ndu corps",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          // chemin vers la page des objets courants
                          builder: (context) => SltPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          shape: BoxShape.rectangle,
                        ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Object\ncourants",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Se faire\ndes amis",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  imageButton('assets/images/slt.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage(),
                        ));
                  }),
                  imageButton('assets/images/nbr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                  }),
                  imageButton('assets/images/phr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage(),
                        ));
                  }),
                  imageButton('assets/images/exounn.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceFon(),
                        ));
                  }),
                  imageButton('assets/images/hisun.png', () {}),
                  imageButton('assets/images/exoun.png', () {}),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Rendez-vous\namoureux",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  imageButton('assets/images/slt.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage(),
                        ));
                  }),
                  imageButton('assets/images/nbr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                  }),
                  imageButton('assets/images/phr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage(),
                        ));
                  }),
                  imageButton('assets/images/exounn.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceFon(),
                        ));
                  }),
                  imageButton('assets/images/hisun.png', () {}),
                  imageButton('assets/images/exoun.png', () {}),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Education",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  imageButton('assets/images/slt.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage(),
                        ));
                  }),
                  imageButton('assets/images/nbr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                  }),
                  imageButton('assets/images/phr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage(),
                        ));
                  }),
                  imageButton('assets/images/exounn.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceFon(),
                        ));
                  }),
                  imageButton('assets/images/hisun.png', () {}),
                  imageButton('assets/images/exoun.png', () {}),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Voyage",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  imageButton('assets/images/slt.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage(),
                        ));
                  }),
                  imageButton('assets/images/nbr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                  }),
                  imageButton('assets/images/phr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage(),
                        ));
                  }),
                  imageButton('assets/images/exounn.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceFon(),
                        ));
                  }),
                  imageButton('assets/images/hisun.png', () {}),
                  imageButton('assets/images/exoun.png', () {}),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Travail",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  imageButton('assets/images/slt.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage(),
                        ));
                  }),
                  imageButton('assets/images/nbr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                  }),
                  imageButton('assets/images/phr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage(),
                        ));
                  }),
                  imageButton('assets/images/exounn.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceFon(),
                        ));
                  }),
                  imageButton('assets/images/hisun.png', () {}),
                  imageButton('assets/images/exoun.png', () {}),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Nourriture",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                alignment:
                    WrapAlignment.center, // Centre les éléments horizontalement
                spacing: 30, // Espace entre les images horizontalement
                runSpacing: 30, // Espace entre les lignes
                children: [
                  imageButton('assets/images/slt.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SltPage(),
                        ));
                  }),
                  imageButton('assets/images/nbr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NbrPage(),
                        ));
                  }),
                  imageButton('assets/images/phr.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrPage(),
                        ));
                  }),
                  imageButton('assets/images/exounn.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceFon(),
                        ));
                  }),
                  imageButton('assets/images/hisun.png', () {}),
                  imageButton('assets/images/exoun.png', () {}),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Retour"),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget imageButton(String path, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(path, width: 100),
    );
  }
}
