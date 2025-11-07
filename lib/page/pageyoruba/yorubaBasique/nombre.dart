import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/exodeux.dart';

class NbrPage extends StatefulWidget {
  @override
  _NbrPageState createState() => _NbrPageState();
}

class _NbrPageState extends State<NbrPage> {
  int textIndex = 0; // 0 = Un, 1 = Deux, etc.
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // Volume par défaut (100%)

  // Fonction pour jouer l'audio en fonction de textIndex
  void playAudio() async {
    String fileName = '';

    switch (textIndex) {
      case 0:
        fileName = 'u.mp3';
        break;
      case 1:
        fileName = 'd.mp3';
        break;
      case 2:
        fileName = 't.mp3';
        break;
      case 3:
        fileName = 'q.mp3';
        break;
      case 4:
        fileName = 'c.mp3';
        break;
      case 5:
        fileName = 's.mp3';
        break;
      case 6:
        fileName = 'se.mp3';
        break;
      case 7:
        fileName = 'h.mp3';
        break;
      case 8:
        fileName = 'n.mp3';
        break;
      case 9:
        fileName = 'k.mp3';
        break;
      default:
        return;
    }

    String filePath = 'vocal/$fileName';
    await _audioPlayer.setVolume(volume); // appliquer le volume
    await _audioPlayer.play(AssetSource(filePath));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Les nombres en fon")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Slider de volume
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                Text("Volume", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Slider(
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
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (textIndex == 0) ...[
                    Text("Un", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("ɖokpó\n[dokpo]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 1) ...[
                    Text("Deux", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Wè\n[We]", style: TextStyle(fontSize: 20)),
                  ]else if (textIndex == 2) ...[
                    Text("Trois", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Atɔ̀n\n[Aton]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 3) ...[
                    Text("Quatre", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Ɛnɛ̀\n[Ènin]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 4) ...[
                    Text("Cinq", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Atɔ́ɔ́n\n[Aton]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 5) ...[
                    Text("Six", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Ayizɛ́n\n[Ayizin]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 6) ...[
                    Text("Sept", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Tɛ́nwè\n[Tinwé]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 7) ...[
                    Text("Huit", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Tántɔ̀n\n[Tanton]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 8) ...[
                    Text("Neuf", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text("Tɛ́nnɛ̀\n[Tinnin]", style: TextStyle(fontSize: 20)),
                  ] else if (textIndex == 9) ...[
                    Text("Page spéciale", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => ExerciceFondeux(),
                        ),
                        );
                      },
                      child: Text("Aller à la page spéciale"),
                    ),
                  ] else ...[
                    SizedBox(height: 30),
                  ],
                  // Boutons navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        heroTag: "voiceButton",
                        onPressed: playAudio,
                        child: Icon(Icons.volume_up),
                        backgroundColor: Colors.blue,
                      ),
                      SizedBox(width: 20),
                      if (textIndex > 0)
                        FloatingActionButton(
                          heroTag: "backArrowButton",
                          onPressed: () {
                            setState(() {
                              textIndex--;
                            });
                          },
                          child: Icon(Icons.arrow_back),
                          backgroundColor: Colors.orange,
                        ),
                      SizedBox(width: 20),
                      if (textIndex < 9)
                        FloatingActionButton(
                          heroTag: "arrowButton",
                          onPressed: () {
                            setState(() {
                              textIndex++;
                            });
                          },
                          child: Icon(Icons.arrow_forward),
                          backgroundColor: Colors.green,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "returnButton",
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("retour", style: TextStyle(fontSize: 10)),
        backgroundColor: Colors.red,
      ),
    );
  }
}
