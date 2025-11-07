import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/exoquatre.dart';


class CorpsPage extends StatefulWidget {
  @override
  _CorpsPageState createState() => _CorpsPageState();
}

class _CorpsPageState extends State<CorpsPage> {
  int textIndex = 0; // 0 = Bonjour, 1 = Comment vas-tu ?, etc.
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // volume par défaut 100%


  // Fonction pour jouer l'audio en fonction de textIndex
  void playAudio() async {
    String fileName = '';

    switch (textIndex) {
      case 0:
        fileName = 'nnn.mp3';
        break;
      case 1:
        fileName = 'nnn.mp3';
        break;
      case 2:
        fileName = 'nnn.mp3';
        break;
      case 3:
        fileName = 'nnn.mp3';
        break;
      case 4:
        fileName = 'nnn.mp3';
        break;
      case 5:
        fileName = 'nnn.mp3';
        break;
      case 6:
        fileName = 'nnn.mp3';
        break;
      case 7:
        fileName = 'nnn.mp3';
        break;
      case 8:
        fileName = 'nnn.mp3';
        break;
      case 9:
        fileName = 'nnn.mp3';
        break;
      case 10:
        fileName = 'nnn.mp3';
        break;
      case 11:
        fileName = 'nnn.mp3';
        break;
      case 12:
        fileName = 'nnn.mp3';
        break;
      case 13:
        fileName = 'nnn.mp3';
        break;
      case 14:
        fileName = 'nnn.mp3';
        break;
      case 15:
        fileName = 'nnn.mp3';
        break;
      case 16:
        fileName = 'nnn.mp3';
        break;
      case 17:
        fileName = 'nnn.mp3';
        break;
      case 18:
        // Pas de son, car on affiche juste un bouton
        return;
      default:
        return;
    }

    String filePath = 'vocal/$fileName';
    await _audioPlayer.play(AssetSource(filePath));
    await _audioPlayer.setVolume(volume); // <-- appliquer le volume
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
              Image.asset('assets/images/tete.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Tête", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Orí [ori]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 1) ...[
              Image.asset('assets/images/cheveux.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("Cheveux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Irun orí [Iroun ori]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 2) ...[
              Image.asset('assets/images/oreille.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("L’oreille", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("etí [è-ti]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 3) ...[
              Image.asset('assets/images/bouche.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("la bouche", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ẹnu [è-nou]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 4) ...[
              Image.asset('assets/images/yeux.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("les yeux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("oju [o-djou]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 5) ...[
              Image.asset('assets/images/nez.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("le nez", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Imú [imou]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 6) ...[
              Image.asset('assets/images/cou.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("le cou", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ọ̀nà ẹ̀dá [aw-nah eh-dah]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 7) ...[
              Image.asset('assets/images/poitrine.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("la poitrine", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("àyà [ah-yah]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 8) ...[
              Image.asset('assets/images/ventre.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("le ventre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ìdí [idi]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 9) ...[
              Image.asset('assets/images/bras.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("le bras", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ọwọ́ [oh-wô]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 10) ...[
              Image.asset('assets/images/coude.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("le coude", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ìkòkò ọwọ́ [ii-ko-ko oh-wô]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 11) ...[
              Image.asset('assets/images/main.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("la main", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ọwọ́ [oh-wô]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 12) ...[
              Image.asset('assets/images/doigt.jpeg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("les doigts", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ìkànnì ọwọ́ [ii-kahn-nee oh-wô]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 13) ...[
              Image.asset('assets/images/cuisse.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("la cuisse", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ìyàrá ẹsẹ́ [ii-yah-rah eh-seh]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 14) ...[
              Image.asset('assets/images/jambe.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("la jambe", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ẹsẹ́ [eh-seh]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 15) ...[
              Image.asset('assets/images/genou.jpg', width: 200, height: 200),
              SizedBox(height: 20),
              Text("le genou", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ìpèlẹ́ ẹsẹ́ [ee-peh-leh eh-seh]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 16) ...[
              Image.asset('assets/images/pied.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("le pied", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ẹsẹ́ [eh-seh]", style: TextStyle(fontSize: 20)),
            ]else if (textIndex == 17) ...[
              Image.asset('assets/images/orteille.png', width: 200, height: 200),
              SizedBox(height: 20),
              Text("les orteils", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ìbèjì ẹsẹ́ [ee-beh-jee eh-seh]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 18) ...[
              Text("Page spéciale", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciceFonquatre(),
                    ),
                  );
                },
                child: Text("Aller à la page spéciale"),
              ),
            ]

             else
              SizedBox(height: 30),

            // Boutons alignés horizontalement
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                if (textIndex != 18)
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

                if (textIndex < 18)
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
