import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projetlangue/page/pagefon/fonBasique/exoun.dart';

class SltPage extends StatefulWidget {
  @override
  _SltPageState createState() => _SltPageState();
}

class _SltPageState extends State<SltPage> {
  int textIndex = 0; // 0 = Bonjour, 1 = Comment vas-tu ?, etc.
  double volume = 1.0; // Volume par défaut (100%)

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Préparer un fichier par défaut ou rien, mais s'assurer que le player est prêt
    _audioPlayer.setReleaseMode(ReleaseMode.stop); // Pour rejouer l'audio après lecture
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  // Fonction pour jouer l'audio en fonction de textIndex
  void playAudio() async {
    String fileName = '';

    switch (textIndex) {
      case 0:
        fileName = 'bjr.mp3';
        break;
      case 1:
        fileName = 'cmtvt.mp3';
        break;
      case 2:
        fileName = 'jvb.mp3';
        break;
      case 3:
        fileName = 'jvba.mp3';
        break;
      case 4:
        fileName = 'bam.mp3';
        break;
      case 5:
        fileName = 'bn.mp3';
        break;
      case 6:
        fileName = 'av.mp3';
        break;
      case 7:
        fileName = 'ab.mp3';
        break;
      case 8:
        fileName = 'jshqtsv.mp3';
        break;
      case 9:
        // Pas de son, car on affiche juste un bouton
        return;
      default:
        return;
    }

    String filePath = 'vocal/$fileName';
    // await _audioPlayer.play(AssetSource(filePath));
    try {
      await _audioPlayer.setVolume(volume); // <-- utilise le volume actuel
      await _audioPlayer.play(AssetSource(filePath));
    } catch (e) {
      print('Erreur lors de la lecture audio : $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        
        Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
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
            if (textIndex == 0) ...[
              Image.asset('assets/images/bjr.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Bonjour !", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("Dóo núwe !", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 1) ...[
              Image.asset('assets/images/cmt.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Comment vas-tu ?", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("nɛ a dé gbɔn ?", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 2) ...[
              Image.asset('assets/images/bet.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Je vais bien (et toi ?)", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("un do ganji (hwɛ lo ?)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 3) ...[
              Image.asset('assets/images/bet.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Bonjour a toi", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("Kùdó zǎnzǎn", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 4) ...[
              Image.asset('assets/images/bam.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Bon après midi", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("kù do lé hwénu", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 5) ...[
              Image.asset('assets/images/dodo.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Bonne nuit !", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("mǎwǔ ní fɔ́n mǐ !", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 6) ...[
              Image.asset('assets/images/aure.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Au revoir", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("ma yi bo wa", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 7) ...[
              Image.asset('assets/images/nbr.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("A bientôt", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("e yi zaan de", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 8) ...[
              Image.asset('assets/images/nbr.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Je suis heureux que tu sois venu", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("wǎ è a wa ɔ́ víví nú mi", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 9) ...[
              Text("Page spéciale",
              style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciceFonun(),
                    ),
                  );
                },
                child: Text("Aller à la page spéciale"),
              ),
            ]
            else ...[
              SizedBox(height: 30),
            ],

            // Boutons alignés horizontalement
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (textIndex != 9)
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