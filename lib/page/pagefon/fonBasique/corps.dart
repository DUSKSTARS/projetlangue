import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CorpsPage extends StatefulWidget {
  @override
  _CorpsPageState createState() => _CorpsPageState();
}

class _CorpsPageState extends State<CorpsPage> {
  int textIndex = 0; // 0 = Bonjour, 1 = Comment vas-tu ?, etc.
  final AudioPlayer _audioPlayer = AudioPlayer();

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
        // Pas de son, car on affiche juste un bouton
        return;
      default:
        return;
    }

    String filePath = 'vocal/$fileName';
    await _audioPlayer.play(AssetSource(filePath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Les parties du corps")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            if (textIndex == 0) ...[
              Text("Un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("dokpo", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 1) ...[
              Text("Deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("we", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 2) ...[
              Text("Trois", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("atɔn", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 3) ...[
              Text("Quatre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ɛnɛ", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 4) ...[
              Text("Cinq", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("atɔ́ɔ́n", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 5) ...[
              Text("Six", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ayizɛn", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 6) ...[
              Text("Sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("tɛnwe", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 7) ...[
              Text("Huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("tantɔ́n", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 8) ...[
              Text("Neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("tɛnnɛ", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 9) ...[
              Text("Page spéciale", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text("Aller à la page spéciale"),
              ),
            ]

             else
              SizedBox(height: 30),

            // Boutons alignés horizontalement
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FloatingActionButton(
                //   heroTag: "voiceButton",
                //   onPressed: playAudio, // Joue l'audio correspondant
                //   child: Icon(Icons.mic),
                //   backgroundColor: Colors.blue,
                // ),

                

                if (textIndex != 9)
                  FloatingActionButton(
                    heroTag: "voiceButton",
                    onPressed: playAudio,
                    child: Icon(Icons.mic),
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
