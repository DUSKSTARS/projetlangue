import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AidePage extends StatefulWidget {
  @override
  _AidePageState createState() => _AidePageState();
}

class _AidePageState extends State<AidePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // volume par défaut (100%)

  final List<Map<String, String>> phrases = [
    {'fr': "Aide", 'fon': "alɔdómε", 'audio': "bjr.mp3"},
    {'fr': "Aider", 'fon': "dŏ alɔ̀ mε", 'audio': "cmtvt.mp3"},
    {'fr': "Aider à charger sur la tête", 'fon': "ɖìɖă ɖŏ ta", 'audio': "merci.mp3"},
    {'fr': "J'ai besoin d'aide", 'fon': "wa gɔ̀ alɔ̀ nú mi", 'audio': "jetaime.mp3"},
    {'fr': "donne moi de l'eau", 'fon': "nă mi sí", 'audio': "nnn.mp3"},
    {'fr': "Prête moi deux miles", 'fon': "Hwé Caki wé nú mi", 'audio': "nnn.mp3"},
    {'fr': "Donne moi deux milles", 'fon': "Nă mi Caki wé", 'audio': "nnn.mp3"},
    {'fr': "Je suis perdu", 'fon': "Un flú", 'audio': "nnn.mp3"},
    {'fr': "Aidez moi svp!", 'fon': "kεnklέn! Mi gɔ̀ alɔ̀ nú mi", 'audio': "nnn.mp3"},
    {'fr': "Merci beaucoup", 'fon': "A houanu kaka", 'audio': "nnn.mp3"},
    {'fr': "Svp ! Expliquez moi ça", 'fon': "kεnklέn! tín mὲ nú mi", 'audio': "nnn.mp3"},

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
