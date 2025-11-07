import 'package:flutter/material.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/salutation.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/nombre.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/phraseun.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/corps.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/couleur.dart';
import 'package:projetlangue/page/pageyoruba/fonjeu/jeuone.dart';
import 'package:projetlangue/page/pageyoruba/fonjeu/jeutwo.dart';
import 'package:projetlangue/page/pageyoruba/fonjeu/jeuthree.dart';
import 'package:projetlangue/page/pageyoruba/yorubaConvers/presenter.dart';
import 'package:projetlangue/page/pageyoruba/yorubaConvers/marche.dart';
import 'package:projetlangue/page/pageyoruba/yorubaConvers/aide.dart';
import 'package:projetlangue/page/pageyoruba/yorubaConvers/ecole.dart';
import 'package:projetlangue/page/pageyoruba/yorubaConvers/maison.dart';
import 'package:projetlangue/page/pageyoruba/yorubaNourriture/fruits.dart';
import 'package:projetlangue/page/pageyoruba/yorubaNourriture/legume.dart';
import 'package:projetlangue/page/pageyoruba/yorubaNourriture/epice.dart';
import 'package:projetlangue/page/pageyoruba/yorubaNourriture/mesfruits.dart';
import 'package:projetlangue/page/pageyoruba/yorubaNourriture/viande.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';



// -------------------- PAGE PRINCIPALE --------------------
class YorubaPage extends StatefulWidget {
  @override
  _YorubaPageState createState() => _YorubaPageState();
}

class _YorubaPageState extends State<YorubaPage> {
  final List<Map<String, String>> _dictionnaire = [
    {'fr': "Bonjour", 'fon': "Dóo núwe", 'audio': "bjr.mp3"},
    {'fr': "Comment vas-tu ?", 'fon': "nɛ a dé gbɔn ?", 'audio': "bjr.mp3"},
    {'fr': "Je vais bien", 'fon': "un do ganji", 'audio': "bjr.mp3"},
    {'fr': "Je t'aime", 'fon': "Un nyì wan nù wé", 'audio': "bjr.mp3"},
    {'fr': "Non", 'fon': "Eho", 'audio': "bjr.mp3"},
    {'fr': "Mon Dieu", 'fon': "Mawu cɛ", 'audio': "bjr.mp3"},
    {'fr': "C'est faux", 'fon': "A din gbawe", 'audio': "bjr.mp3"},
    {'fr': "je ne parle pas le fon", 'fon': "Un se fongbe a", 'audio': "bjr.mp3"},
    {'fr': "Oui", 'fon': "Eeen", 'audio': "bjr.mp3"},
    {'fr': "C'est beaucoup", 'fon': "E sukpo din", 'audio': "bjr.mp3"},
    {'fr': "s'abaisser", 'fon': "yì dò", 'audio': "bjr.mp3"},
    {'fr': "Vient en bas", 'fon': "zĕ wă dò", 'audio': "bjr.mp3"},
    {'fr': "abandon", 'fon': "gbìgbέ ‑ jìjódó", 'audio': "bjr.mp3"},
    {'fr': "abattoir", 'fon': "lanhutὲn", 'audio': "bjr.mp3"},
    {'fr': "abcès", 'fon': "nùtítέ", 'audio': "bjr.mp3"},
    {'fr': "abeille", 'fon': "wĭìn", 'audio': "bjr.mp3"},
    {'fr': "abîmer", 'fon': "hὲn gblĕ", 'audio': "bjr.mp3"},
    {'fr': "aboyer", 'fon': "hŏ", 'audio': "bjr.mp3"},
    {'fr': "absolution", 'fon': "hwεsúsɔ́kὲ", 'audio': "bjr.mp3"},
    {'fr': "accélérer", 'fon': "yă wŭ blŏ", 'audio': "bjr.mp3"},
    {'fr': "acclamation", 'fon': "aploò", 'audio': "bjr.mp3"},
    {'fr': "acclamer", 'fon': "kpà álúwáásiò", 'audio': "bjr.mp3"},
    {'fr': "accompagnateur", 'fon': "megudonɔtɔ́", 'audio': "bjr.mp3"},
    {'fr': "accord", 'fon': "gbeɖókpɔ́ ‑ gbenɔkpɔ́", 'audio': "bjr.mp3"},
    {'fr': "accouchement", 'fon': "vìjíjí", 'audio': "bjr.mp3"},
    {'fr': "accoucher", 'fon': "jì vĭ", 'audio': "bjr.mp3"},
    {'fr': "accoucheuse", 'fon': "vìjítɔ́", 'audio': "bjr.mp3"},
    {'fr': "accrocher", 'fon': "kplá ‑ kplá kɔ̀ ‑ sɔ́ kplá kɔ̀", 'audio': "bjr.mp3"},
    {'fr': "accroissement", 'fon': "jijεjí", 'audio': "bjr.mp3"},
    {'fr': "accroître", 'fon': "jὲ... jĭ", 'audio': "bjr.mp3"},
    {'fr': "accueil", 'fon': "mεyiyí", 'audio': "bjr.mp3"},
    {'fr': "accueillir la parole", 'fon': "yĭsè", 'audio': "bjr.mp3"},
    {'fr': "accumuler", 'fon': "kplé", 'audio': "bjr.mp3"},
    {'fr': "accusateur en justice", 'fon': "hwεylɔ́mεtɔ́", 'audio': "bjr.mp3"},
    {'fr': "achat", 'fon': "nùxíxɔ́", 'audio': "bjr.mp3"},
    {'fr': "acheter", 'fon': "xɔ̀ nŭ", 'audio': "bjr.mp3"},
    {'fr': "acheteur", 'fon': "nùxɔ́tɔ́", 'audio': "bjr.mp3"},
    {'fr': "boisson", 'fon': "ahan", 'audio': "bjr.mp3"},
    {'fr': "arachides", 'fon': "aziín", 'audio': "bjr.mp3"},
    {'fr': "acquiescer", 'fon': "yĭ gbè ‑yĭ gbè nú me", 'audio': "bjr.mp3"},
    {'fr': "action", 'fon': "nùwíwá", 'audio': "bjr.mp3"},
    {'fr': "addition", 'fon': "kplékplé", 'audio': "bjr.mp3"},
    {'fr': "administration", 'fon': "axɔ́súxwé", 'audio': "bjr.mp3"},
    {'fr': "admission", 'fon': "yìyí", 'audio': "bjr.mp3"},
    {'fr': "adolescent", 'fon': "dɔ̀nkpέvú", 'audio': "bjr.mp3"},
    {'fr': "adopter", 'fon': "sɔ́ mε bo hὲn", 'audio': "bjr.mp3"},
    {'fr': "adorateur", 'fon': "măwùsέntɔ́", 'audio': "bjr.mp3"},
    {'fr': "adorer", 'fon': "sὲn", 'audio': "bjr.mp3"},
    {'fr': "adoucir", 'fon': "dŏ fífá", 'audio': "bjr.mp3"},

    {'fr': "C'est beaucoup", 'fon': "E sukpo din", 'audio': "bjr.mp3"},
    {'fr': "s'abaisser", 'fon': "yì dò", 'audio': "bjr.mp3"},
    {'fr': "Vient en bas", 'fon': "zĕ wă dò", 'audio': "bjr.mp3"},
    {'fr': "abandon", 'fon': "gbìgbέ ‑ jìjódó", 'audio': "bjr.mp3"},
    {'fr': "abattoir", 'fon': "lanhutὲn", 'audio': "bjr.mp3"},
    {'fr': "abcès", 'fon': "nùtítέ", 'audio': "bjr.mp3"},
    {'fr': "abeille", 'fon': "wĭìn", 'audio': "bjr.mp3"},
    {'fr': "abîmer", 'fon': "hὲn gblĕ", 'audio': "bjr.mp3"},
    {'fr': "aboyer", 'fon': "hŏ", 'audio': "bjr.mp3"},
    {'fr': "absolution", 'fon': "hwεsúsɔ́kὲ", 'audio': "bjr.mp3"},
    {'fr': "accélérer", 'fon': "yă wŭ blŏ", 'audio': "bjr.mp3"},
    {'fr': "acclamation", 'fon': "aploò", 'audio': "bjr.mp3"},
    {'fr': "acclamer", 'fon': "kpà álúwáásiò", 'audio': "bjr.mp3"},
    {'fr': "acquiescer", 'fon': "yĭ gbè ‑yĭ gbè nú me", 'audio': "bjr.mp3"},
  ];

  Set<String> _favoris = {};

  late Database _db;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  // --- INITIALISATION DE LA BASE DE DONNÉES ---
  Future<void> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'scores.db');

    _db = await openDatabase(
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
        await db.execute('''
          CREATE TABLE favoris(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            mot TEXT UNIQUE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE scores ADD COLUMN categorie TEXT');
          await db.execute('''
            CREATE TABLE IF NOT EXISTS favoris(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              mot TEXT UNIQUE
            )
          ''');
        }
      },
    );

    _loadFavoris();
  }

  // --- CHARGER LES FAVORIS ---
  Future<void> _loadFavoris() async {
    final result = await _db.query('favoris');
    setState(() {
      _favoris = result.map((row) => row['mot'] as String).toSet();
    });
  }

  // --- AJOUTER OU SUPPRIMER UN FAVORI ---
  Future<void> _toggleFavori(String mot) async {
    if (_favoris.contains(mot)) {
      await _db.delete('favoris', where: 'mot = ?', whereArgs: [mot]);
      _favoris.remove(mot);
    } else {
      await _db.insert('favoris', {'mot': mot},
          conflictAlgorithm: ConflictAlgorithm.ignore);
      _favoris.add(mot);
    }
    setState(() {});
  }

  // --- PROGRESSION ---
  Future<double> getProgress(String categorie, int totalQuestions) async {
    final result = await _db.query(
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
                    border: Border.all(color: Colors.green, width: 4.0),
                    shape: BoxShape.circle,
                  ),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Vocabulaire\nde base",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
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
                              backgroundColor: Colors.white,
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
                              backgroundColor: Colors.white,
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
                          builder: (context) => EcolePage()
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
                          builder: (context) => MaisonPage()
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
                          builder: (context) => JeuDPage(),
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
                            "Jeu 2",
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
                          builder: (context) => JeuTPage()
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
                            "Jeu 3",
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
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     onTap: () {
                        
                  //       Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         // il s'agit du chemin vers la page couleur
                  //         builder: (context) => PhrPage()
                  //       ),);
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 123, 219, 155),
                  //       borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black26,
                  //           blurRadius: 6,
                  //           offset: Offset(2, 2), // ombre décalée
                  //         ),
                  //       ],
                  //     ),
                  //       width: 90.0,
                  //       height: 90.0,
                  //       child: Center(
                  //         child: Text(
                  //           "Couleurs",
                  //           style: TextStyle(
                  //             fontSize: 15.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         // il s'agit du chemin vers la page des parties du corps
                  //         builder: (context) => CorpsPage()
                  //       ),);
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 123, 219, 155),
                  //       borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black26,
                  //           blurRadius: 6,
                  //           offset: Offset(2, 2), // ombre décalée
                  //         ),
                  //       ],
                  //     ),
                  //       width: 90.0,
                  //       height: 90.0,
                  //       child: Center(
                  //         child: Text(
                  //           "Parties\ndu corps",
                  //           style: TextStyle(
                  //             fontSize: 15.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         // chemin vers la page des objets courants
                  //         builder: (context) => SltPage()
                  //       ),);
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 123, 219, 155),
                  //       borderRadius: BorderRadius.circular(16), // ✅ coins arrondis
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black26,
                  //           blurRadius: 6,
                  //           offset: Offset(2, 2), // ombre décalée
                  //         ),
                  //       ],
                  //     ),
                  //       width: 90.0,
                  //       height: 90.0,
                  //       child: Center(
                  //         child: Text(
                  //           "Object\ncourants",
                  //           style: TextStyle(
                  //             fontSize: 15.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 25,
              ),

              // quatrieme partie
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Produits\nAlimentaires",
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
                          builder: (context) => FruitPage()
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
                            "Céréales &\nféculents",
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
                          builder: (context) => LegumePage(),
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
                            "Légumes",
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
                          builder: (context) => EpicePage(),
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
                            "Épices &\ncondiments",
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
                          builder: (context) => MesfruitsPage()
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
                            "Fruits",
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
                          builder: (context) => ViandePage()
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
                            "Viandes &\npoissons",
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


// --- BOUTON CATÉGORIE ---
  Widget _buildCategorieButton(
      String titre, Color color, int totalQuestions, Widget page) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => page)),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: color,
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
                  titre,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        FutureBuilder<double>(
          future: getProgress(titre.toLowerCase(), totalQuestions),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return SizedBox(height: 5);
            return Container(
              width: 90,
              child: LinearProgressIndicator(
                value: snapshot.data,
                minHeight: 10,
                backgroundColor: Colors.white,
                color: Colors.green,
              ),
            );
          },
        ),
      ],
    );
  }
}
// -------------------- RECHERCHE --------------------
class DictionnaireRecherche extends SearchDelegate<String> {
  final List<Map<String,String>> dictionnaire;
  final Set<String> favoris;
  final Future<void> Function(String) onFavoriChange;
  final AudioPlayer _audioPlayer = AudioPlayer();

  DictionnaireRecherche({
    required this.dictionnaire,
    required this.favoris,
    required this.onFavoriChange,
  });

  Future<void> _playAudio(String fichier) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource("vocal/$fichier"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Center(child: Text('Tape pour rechercher un mot'));

    final suggestions = dictionnaire.where((entry) =>
        entry['fr']!.toLowerCase().contains(query.toLowerCase())).toList();

    if (suggestions.isEmpty) return Center(child: Text('Mot non trouvé'));

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final mot = suggestions[index]['fr']!;
        final definition = suggestions[index]['fon']!;
        final audio = suggestions[index]['audio']!;
        final estFavori = favoris.contains(mot);

        return ListTile(
          title: Text(mot),
          subtitle: Text(definition),
          trailing: Wrap(
            spacing: 8,
            children: [
              IconButton(
                icon: Icon(Icons.volume_up, color: Colors.blue),
                onPressed: () => _playAudio(audio),
              ),
              IconButton(
                onPressed: () {
                  onFavoriChange(mot);
                  showSuggestions(context);
                },
                icon: Icon(
                  estFavori ? Icons.star : Icons.star_border,
                  color: estFavori ? Colors.amber : null,
                ),
              ),
            ],
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
    final entry = dictionnaire.firstWhere(
      (e) => e['fr'] == query,
      orElse: () => {},
    );
    if (entry.isEmpty) return Center(child: Text('Mot non trouvé'));

    final estFavori = favoris.contains(query);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mot : ${entry['fr']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Définition : ${entry['fon']}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 24),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.volume_up, color: Colors.blue, size: 30),
                onPressed: () => _playAudio(entry['audio']!),
              ),
              IconButton(
                onPressed: () {
                  onFavoriChange(query);
                  showResults(context);
                },
                icon: Icon(
                  estFavori ? Icons.star : Icons.star_border,
                  color: estFavori ? Colors.amber : null,
                  size: 30,
                ),
              ),
            ],
          ),
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
  final List<Map<String, String>> dictionnaire;
  final AudioPlayer _audioPlayer = AudioPlayer();

  FavorisPage({required this.favoris, required this.dictionnaire});

  Future<void> _playAudio(String fichier) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource("vocal/$fichier"));
  }

  @override
  Widget build(BuildContext context) {
    final motsFavoris = dictionnaire.where((e) => favoris.contains(e['fr'])).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Mots favoris')),
      body: motsFavoris.isEmpty
          ? Center(child: Text("Aucun mot favori pour l'instant"))
          : ListView.builder(
              itemCount: motsFavoris.length,
              itemBuilder: (context, index) {
                final mot = motsFavoris[index]['fr']!;
                final definition = motsFavoris[index]['fon']!;
                final audio = motsFavoris[index]['audio']!;

                return ListTile(
                  leading: Icon(Icons.star, color: Colors.amber),
                  title: Text(mot),
                  subtitle: Text(definition),
                  trailing: IconButton(
                    icon: Icon(Icons.volume_up, color: Colors.blue),
                    onPressed: () => _playAudio(audio),
                  ),
                );
              },
            ),
    );
  }
}
