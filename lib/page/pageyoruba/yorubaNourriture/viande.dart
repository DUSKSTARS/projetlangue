import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ViandePage extends StatefulWidget {
  @override
  _ViandePageState createState() => _ViandePageState();
}

class _ViandePageState extends State<ViandePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // volume par défaut (100%)

  final List<Map<String, String>> phrases = [
    {'fr': "Viande de Bœuf", 'fon': "nyibúlàn", 'audio': "bjr.mp3"},
    {'fr': "Viande de Mouton", 'fon': "lὲngbɔ́làn", 'audio': "cmtvt.mp3"},
    {'fr': "Viande de Porc", 'fon': "aglúzalàn", 'audio': "merci.mp3"},
    {'fr': "Viande de Chèvre", 'fon': "gbɔ̀làn", 'audio': "nnn.mp3"},
    {'fr': "Viande de Poulet", 'fon': "koklólàn", 'audio': "jetaime.mp3"},
    {'fr': "Viandde de Dinde", 'fon': "tlŏtlŏlàn", 'audio': "nnn.mp3"},
    {'fr': "Viande de Lapin", 'fon': "azwìlàn", 'audio': "nnn.mp3"},
    {'fr': "Poisson", 'fon': "hweví", 'audio': "nnn.mp3"},
    
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
