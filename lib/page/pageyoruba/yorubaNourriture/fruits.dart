import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FruitPage extends StatefulWidget {
  @override
  _FruitPageState createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // volume par défaut (100%)

  final List<Map<String, String>> phrases = [
    {'fr': "Riz", 'fon': "mɔ̆likú", 'audio': "bjr.mp3"},
    {'fr': "Maïs", 'fon': "gbadé", 'audio': "cmtvt.mp3"},
    {'fr': "Sorgho", 'fon': "abɔ̀", 'audio': "merci.mp3"},
    {'fr': "Manioc", 'fon': "fεnnyέn", 'audio': "jetaime.mp3"},
    {'fr': "Igname", 'fon': "teví", 'audio': "nnn.mp3"},
    {'fr': "Haricots secs", 'fon': "ayikún", 'audio': "nnn.mp3"},
    {'fr': "haricots cuits", 'fon': "abɔbɔ̀", 'audio': "nnn.mp3"},
    {'fr': "pois", 'fon': "ayikún", 'audio': "nnn.mp3"},
    {'fr': "pois chiche", 'fon': "aziígòkwín", 'audio': "nnn.mp3"},
    {'fr': "Taro", 'fon': "glὲn", 'audio': "nnn.mp3"},

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
