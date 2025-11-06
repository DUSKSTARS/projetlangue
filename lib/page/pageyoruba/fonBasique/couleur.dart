import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projetlangue/page/pageyoruba/fonBasique/exotrois.dart';


class CltPage extends StatefulWidget {
  @override
  _CltPageState createState() => _CltPageState();
}

class _CltPageState extends State<CltPage> {
  int textIndex = 0; // 0 = Bonjour, 1 = Comment vas-tu ?, etc.
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // volume par défaut 100%


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
      await _audioPlayer.setVolume(volume); // <-- appliquer le volume
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
            Column(
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
                    _audioPlayer.setVolume(volume); // met à jour le volume instantanément
                  },
                ),
              ],
            ),

            if (textIndex == 0) ...[
              Image.asset('assets/images/vert.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Vert",
                style: TextStyle(color: Colors.green, fontSize: 20), // tu peux aussi utiliser la couleur exacte
              ),
              SizedBox(height: 20),
              Text("Amamǔ (Amanmoun)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 1) ...[
              Image.asset('assets/images/jaune.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Jaune",
                style: TextStyle(color: Colors.yellow, fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Koklojó (Koklodjo)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 2) ...[
              Image.asset('assets/images/rouge.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Rouge",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Vɔvɔ (Vorvor)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 3) ...[
              Image.asset('assets/images/bleu.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Bleu",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Fɛ́sínɔ̀ (Fèsinnon)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 4) ...[
              Image.asset('assets/images/noir.jpeg', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Noir",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Wìwì (Wouiwoui)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 5) ...[
              Image.asset('assets/images/blanc.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Blanc",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Wewé (Wéwé)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 6) ...[
              Image.asset('assets/images/cendre.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Cendre",
                style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Afín (afin)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 7) ...[
              Image.asset('assets/images/marron.jpeg', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Marron",
                style: TextStyle(color: Color(0xFF8B4513), fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Kɔ́sínnɔ̀ (Korsinnon)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 8) ...[
              Image.asset('assets/images/violet.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Violet",
                style: TextStyle(color: Color(0xFF800080), fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Kwlélésìn (Kouélésin)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 9) ...[
              Image.asset('assets/images/or.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                "Or",
                style: TextStyle(color: Color(0xFFFFD700), fontSize: 20),
              ),
              SizedBox(height: 20),
              Text("Síká (Sika)", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 10) ...[
              Text("Page spéciale",
              style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciceFontrois(),
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
                if (textIndex != 10)
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
                if (textIndex < 10)
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