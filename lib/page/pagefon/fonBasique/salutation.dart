import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SltPage extends StatefulWidget {
  @override
  _SltPageState createState() => _SltPageState();
}

class _SltPageState extends State<SltPage> {
  int textIndex = 0; // 0 = Bonjour, 1 = Comment vas-tu ?, etc.
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
      default:
        return;
    }

    String filePath = 'vocal/$fileName';
    // await _audioPlayer.play(AssetSource(filePath));
    try {
      _audioPlayer.setVolume(1.0);
      await _audioPlayer.play(AssetSource(filePath));
    } catch (e) {
      print('Erreur lors de la lecture audio : $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            if (textIndex == 0) ...[
              Image.asset('assets/images/bjr.jpg', width: 20, height: 20),
              SizedBox(height: 20),
              Text("Bonjour !", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("a f̀ɔn à !", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 1) ...[
              Image.asset('assets/images/cmt.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Comment vas-tu ?", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("nɛ a de gbɔn ?", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 2) ...[
              Image.asset('assets/images/bet.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Je vais bien (et toi ?)", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("un do ganji (hwɛ lo ?)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 3) ...[
              Image.asset('assets/images/bet.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Je vais bien aussi", style: TextStyle(color: const Color.fromARGB(255, 24, 48, 184),fontSize: 20)),
              SizedBox(height: 20),
              Text("un do ganji mɔké", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 4) ...[
              Image.asset('assets/images/bam.png', width: 200, height: 200),
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
              Image.asset('assets/images/aur.jpg', width: 200, height: 200),
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
            ] else
              SizedBox(height: 30),

            // Boutons alignés horizontalement
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: "voiceButton",
                  onPressed: playAudio, // Joue l'audio correspondant
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


                if (textIndex < 8)
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