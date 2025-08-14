import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PhrPage extends StatefulWidget {
  @override
  _PhrPageState createState() => _PhrPageState();
}

class _PhrPageState extends State<PhrPage> {
  int textIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, String>> phrases = [
    {'fr': "Bonjour", 'fon': "A fon gbé", 'audio': "bjr.mp3"},
    {'fr': "Comment vas-tu ?", 'fon': "Dɔ gbe na ?", 'audio': "cmtvt.mp3"},
    {'fr': "Merci beaucoup", 'fon': "A kpe nu", 'audio': "merci.mp3"},
    {'fr': "Je t'aime", 'fon': "Mè do wè", 'audio': "jetaime.mp3"},
    {'fr': "Au revoir", 'fon': "Dada gbé", 'audio': "nnn.mp3"},
  ];

  void playAudio(String fileName) async {
    await _audioPlayer.play(AssetSource('vocal/$fileName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phrases en français et en fon")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: phrases.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            phrases[index]['fr']!,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            phrases[index]['fon']!,
                            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.blue),
                      onPressed: () => playAudio(phrases[index]['audio']!),
                    ),
                  ],
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "returnButton",
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Retour", style: TextStyle(fontSize: 10)),
        backgroundColor: Colors.red,
      ),
    );
  }
}









































































































// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class PhrPage extends StatefulWidget {
//   @override
//   _PhrPageState createState() => _PhrPageState();
// }

// class _PhrPageState extends State<PhrPage> {
//   int textIndex = 0; // Variable d'état pour gérer l'index des phrases affichées (non utilisée ici mais pourrait servir pour des fonctionnalités futures).

//   final AudioPlayer _audioPlayer = AudioPlayer(); // Instance de AudioPlayer pour jouer l'audio.

//   // Liste des phrases avec leur traduction en fon, fichier audio et images associées.
//   final List<Map<String, String>> phrases = [
//     {'fr': "Bonjour", 'fon': "A fon gbé", 'audio': "bonjour.mp3", 'image': 'assets/images/bonjour.png'},
//     {'fr': "Comment vas-tu ?", 'fon': "Dɔ gbe na ?", 'audio': "comment_va.mp3", 'image': 'assets/images/comment_va.png'},
//     {'fr': "Merci beaucoup", 'fon': "A kpe nu", 'audio': "merci.mp3", 'image': 'assets/images/merci.png'},
//     {'fr': "Je t'aime", 'fon': "Mè do wè", 'audio': "jetaime.mp3", 'image': 'assets/images/jetaime.png'},
//     {'fr': "Au revoir", 'fon': "Dada gbé", 'audio': "au_revoir.mp3", 'image': 'assets/images/au_revoir.png'},
//   ];

//   // Fonction pour jouer l'audio d'une phrase à partir du fichier.
//   void playAudio(String fileName) async {
//     await _audioPlayer.play(AssetSource('assets/vocal/$fileName')); // Joue l'audio du fichier dans assets/vocal.
//   }

//   // Liste des questions à choix multiples pour ajouter une interaction.
//   final List<Map<String, dynamic>> questions = [
//     {
//       'question': 'Comment vas-tu ?',
//       'options': ['Bien', 'Mal', 'Très bien'],
//       'answer': 'Bien',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Phrases en français et en fon")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0), // Ajout de padding autour du contenu.
//         child: ListView.builder(
//           itemCount: phrases.length, // Le nombre d'éléments dans la liste phrases.
//           itemBuilder: (context, index) { // Construction des widgets pour chaque phrase.
//             return Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre les éléments dans la ligne.
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche du texte.
//                         children: [
//                           // Affichage de la phrase en français.
//                           Text(
//                             phrases[index]['fr']!,
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           // Affichage de la traduction en fon.
//                           Text(
//                             phrases[index]['fon']!,
//                             style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey),
//                           ),
//                           // Affichage de l'image associée à la phrase.
//                           Image.asset(phrases[index]['image']!),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.volume_up, color: Colors.blue), // Icone pour jouer l'audio.
//                       onPressed: () => playAudio(phrases[index]['audio']!), // Lecture de l'audio au clic.
//                     ),
//                   ],
//                 ),
//                 Divider(), // Séparateur entre les phrases.
//                 // Ajouter des questions avec des réponses à choix multiples sous chaque phrase.
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       questions[index]['question']!, // Affichage de la question.
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     // Boucle à travers les options pour afficher les boutons de choix.
//                     ...questions[index]['options'].map<Widget>((option) {
//                       return ElevatedButton(
//                         onPressed: () {
//                           if (option == questions[index]['answer']) {
//                             // Si la réponse est correcte.
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bonne réponse!')));
//                           } else {
//                             // Si la réponse est incorrecte.
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mauvaise réponse!')));
//                           }
//                         },
//                         child: Text(option), // Affiche le texte de chaque option.
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         heroTag: "returnButton", // Tag unique pour éviter les conflits d'animation.
//         onPressed: () {
//           Navigator.pop(context); // Retour à la page précédente lorsqu'on clique sur le bouton.
//         },
//         child: Text("Retour", style: TextStyle(fontSize: 10)),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }
