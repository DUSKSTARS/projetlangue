import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class EcolePage extends StatefulWidget {
  @override
  _EcolePageState createState() => _EcolePageState();
}

class _EcolePageState extends State<EcolePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // volume par défaut (100%)

  final List<Map<String, String>> phrases = [
    {'fr': "c'est le livre du maître", 'fon': "mε̆sì sín wèmá wè", 'audio': "bjr.mp3"},
    {'fr': "élève", 'fon': "àxɔ́mɛ́ví", 'audio': "cmtvt.mp3"},
    {'fr': "apprenant", 'fon': "nùkplɔ́ntɔ́", 'audio': "merci.mp3"},
    {'fr': "stylo", 'fon': "nùwlánnú", 'audio': "jetaime.mp3"},
    {'fr': "ouvrir un livre", 'fon': "hùn wĕmà", 'audio': "nnn.mp3"},
    {'fr': "table", 'fon': "távò", 'audio': "nnn.mp3"},
    {'fr': "tableau noir", 'fon': "wèmàwlánxwlɛ̀", 'audio': "nnn.mp3"},
    {'fr': "crayon", 'fon': "nùwlánnú", 'audio': "nnn.mp3"},
    {'fr': "prend ton cahier", 'fon': "zé wèmá to wé", 'audio': "nnn.mp3"},
    {'fr': "va au tableau", 'fon': "yi wèmàwlánxwlɛ̀ kɔ́n", 'audio': "nnn.mp3"},
    {'fr': "Svp ! Expliquez moi ça", 'fon': "kεnklέn! tín mὲ nú mi", 'audio': "nnn.mp3"},
    {'fr': "exercice d'école", 'fon': "ázɔ azɔ̀mὲtɔ́n", 'audio': "nnn.mp3"},
    {'fr': "directeur d'école", 'fon': "wèmàxɔ́mɛ́gán", 'audio': "nnn.mp3"},

  ];

  void playAudio(String fileName) async {
    await _audioPlayer.setVolume(volume); // applique le volume actuel
    await _audioPlayer.play(AssetSource('vocal/$fileName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phrases en français et en fon")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Slider de volume
            Text(
              "Volume",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: volume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: "${(volume * 100).round()}%",
              onChanged: (value) {
                setState(() {
                  volume = value;
                });
                _audioPlayer.setVolume(volume);
              },
            ),
            SizedBox(height: 10),
            // Liste des phrases
            Expanded(
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
                                SizedBox(height: 5),
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
          ],
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
