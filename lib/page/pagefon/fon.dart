import 'package:flutter/material.dart';
import 'package:projetlangue/page/pagefon/fonBasique/salutation.dart';
import 'package:projetlangue/page/pagefon/fonBasique/nombre.dart';
import 'package:projetlangue/page/pagefon/fonBasique/phraseun.dart';
import 'package:projetlangue/page/pagefon/fonBasique/corps.dart';
import 'package:projetlangue/page/pagefon/fonBasique/couleur.dart';
import 'package:projetlangue/page/pagefon/fonjeu/jeuone.dart';
import 'package:projetlangue/page/pagefon/fonConvers/presenter.dart';
import 'package:projetlangue/page/pagefon/fonConvers/marche.dart';
import 'package:projetlangue/page/pagefon/fonConvers/aide.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

// -------------------- PAGE PRINCIPALE --------------------
class FonPage extends StatefulWidget {
  @override
  _FonPageState createState() => _FonPageState();
}

class _FonPageState extends State<FonPage> {
  // clé pour shared_preferences
  static const String _prefsFavorisKey = 'favoris_mots';

  // dictionnaire simple lié aux catégories
  final Map<String, String> _dictionnaire = {
    "Salutation": "Dire bonjour, bonsoir, etc.",
    "Nombre": "Les chiffres et leur prononciation",
    "Phrase": "Exemples de phrases utiles",
    "Corps": "Les parties du corps humain",
    "Couleur": "Les couleurs de base",
  };

  // favoris (persistés)
  Set<String> _favoris = {};

  @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  // charge les favoris depuis shared_preferences
  Future<void> _loadFavoris() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_prefsFavorisKey) ?? [];
      setState(() {
        _favoris = list.toSet();
      });
    } catch (e) {
      // si erreur, garde favoris vide (tu peux logger si besoin)
    }
  }

  // sauvegarde les favoris
  Future<void> _saveFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsFavorisKey, _favoris.toList());
  }

  // fonction qui récupère la progression
  Future<double> getProgress(String categorie, int totalQuestions) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');

    final db = await openDatabase(
      path,
      version: 2,
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
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE scores ADD COLUMN categorie TEXT');
        }
      },
    );

    final result = await db.query(
      'scores',
      where: 'categorie = ?',
      whereArgs: [categorie],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      int lastScore = result.first['score'] as int;
      return lastScore / totalQuestions;
    }
    return 0.0;
  }

  // méthode pour ajouter ou retirer un favori (et sauvegarder)
  void _toggleFavori(String mot) {
    setState(() {
      if (_favoris.contains(mot)) {
        _favoris.remove(mot);
      } else {
        _favoris.add(mot);
      }
    });
    _saveFavoris();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vocabulaire de base"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: DictionnaireRecherche(
                  dictionnaire: _dictionnaire,
                  favoris: _favoris,
                  onFavoriChange: _toggleFavori,
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavorisPage(
                    favoris: _favoris,
                    dictionnaire: _dictionnaire,
                  ),
                ),
              );
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.green,
                      width: 4.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Vocabulaire\nde base",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                runSpacing: 30,
                children: [
                  // Bouton Salutation avec progression
                  Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SltPage()),
                            );
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 123, 219, 155),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Salutation",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      FutureBuilder<double>(
                        future: getProgress("salutation", 4),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return SizedBox(height: 5);
                          return Container(
                            width: 90,
                            child: LinearProgressIndicator(
                              value: snapshot.data,
                              minHeight: 10,
                              backgroundColor: Colors.blue,
                              color: Colors.green,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NbrPage()),
                            );
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 123, 219, 155),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Les nombres",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      FutureBuilder<double>(
                        future: getProgress("nombres", 4),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return SizedBox(height: 5);
                          return Container(
                            width: 90,
                            child: LinearProgressIndicator(
                              value: snapshot.data,
                              minHeight: 10,
                              backgroundColor: Colors.blue,
                              color: Colors.green,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  // Bouton Les nombres (sans progress)
                  
                  

                  // Bouton Phrases Basiques
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhrPage()),
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Phrases\nBasiques",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bouton Couleurs
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CltPage()),
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Couleurs",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bouton Parties du corps
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CorpsPage()),
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Parties\ndu corps",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                          builder: (context) => PrePage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 219, 155),
                          borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2), // ombre décalée
                            ),
                          ],
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
                          builder: (context) => AidePage(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 123, 219, 155),
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                          builder: (context) => MarchPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 123, 219, 155),
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                          builder: (context) => JeuPage()
                        ),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 123, 219, 155),
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
                      ),
                        width: 90.0,
                        height: 90.0,
                        child: Center(
                          child: Text(
                            "Jeu_1",
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
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
                        borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2), // ombre décalée
                          ),
                        ],
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
// -------------------- RECHERCHE --------------------
class DictionnaireRecherche extends SearchDelegate<String> {
  final Map<String, String> dictionnaire;
  final Set<String> favoris;
  final Function(String) onFavoriChange;

  DictionnaireRecherche({
    required this.dictionnaire,
    required this.favoris,
    required this.onFavoriChange,
  });

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      // Optionnel : montrer des suggestions populaires ou rien
      return Center(child: Text('Tape pour rechercher un mot'));
    }

    final suggestions = dictionnaire.entries
        .where((entry) => entry.key.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestions.isEmpty) {
      return Center(child: Text('Mot non trouvé'));
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final mot = suggestions[index].key;
        final definition = suggestions[index].value;
        final estFavori = favoris.contains(mot);

        return ListTile(
          title: Text(mot),
          subtitle: Text(definition),
          trailing: IconButton(
            onPressed: () {
              onFavoriChange(mot);
              // forcer la reconstruction des suggestions pour refléter le changement
              showSuggestions(context);
            },
            icon: Icon(
              estFavori ? Icons.star : Icons.star_border,
              color: estFavori ? Colors.amber : null,
            ),
          ),
          onTap: () {
            query = mot;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final definition = dictionnaire[query];

    if (definition == null) {
      return Center(child: Text('Mot non trouvé'));
    }

    final estFavori = favoris.contains(query);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mot : $query',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Définition : $definition', style: TextStyle(fontSize: 18)),
          SizedBox(height: 24),
          IconButton(
            onPressed: () {
              onFavoriChange(query);
              // re-afficher les résultats pour mettre à jour l'icône
              showResults(context);
            },
            icon: Icon(
              estFavori ? Icons.star : Icons.star_border,
              color: estFavori ? Colors.amber : null,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: Icon(Icons.arrow_back),
    );
  }
}

// -------------------- FAVORIS --------------------
class FavorisPage extends StatelessWidget {
  final Set<String> favoris;
  final Map<String, String> dictionnaire;

  FavorisPage({required this.favoris, required this.dictionnaire});

  @override
  Widget build(BuildContext context) {
    final motsFavoris = favoris.toList();

    return Scaffold(
      appBar: AppBar(title: Text('Mots favoris')),
      body: motsFavoris.isEmpty
          ? Center(child: Text("Aucun mot favori pour l'instant"))
          : ListView.builder(
              itemCount: motsFavoris.length,
              itemBuilder: (context, index) {
                final mot = motsFavoris[index];
                final definition = dictionnaire[mot] ?? '';

                return ListTile(
                  leading: Icon(Icons.star, color: Colors.amber),
                  title: Text(mot),
                  subtitle: Text(definition),
                );
              },
            ),
    );
  }
}