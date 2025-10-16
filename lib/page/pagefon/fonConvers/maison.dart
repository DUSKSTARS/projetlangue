import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MaisonPage extends StatefulWidget {
  @override
  _MaisonPageState createState() => _MaisonPageState();
}

class _MaisonPageState extends State<MaisonPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // volume par défaut (100%)

  final List<Map<String, String>> phrases = [
    {'fr': "j'ai mangé hier", 'fon': "hùn ɖù nŭ sɔ̀", 'audio': "bjr.mp3"},
    {'fr': "je mangerai demain", 'fon': "na ɖù nŭ sɔ̀", 'audio': "cmtvt.mp3"},
    {'fr': "tu mange bien", 'fon': "a nɔ́n lὲ jὲ", 'audio': "merci.mp3"},
    {'fr': "prend la pâte", 'fon': "cán wɔ̆", 'audio': "jetaime.mp3"},
    {'fr': "sel", 'fon': "jὲ", 'audio': "nnn.mp3"},
    {'fr': "ne mange pas", 'fon': "maɖùnŭ o", 'audio': "nnn.mp3"},
    {'fr': "récipient pour se laver les mains", 'fon': "alɔklɔ́gbán", 'audio': "nnn.mp3"},
    // {'fr': "crayon", 'fon': "nùwlánnú", 'audio': "nnn.mp3"},
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
