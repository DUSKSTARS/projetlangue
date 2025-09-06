import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projetlangue/page/pagefon/fonBasique/exoquatre.dart';


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
              Text("Tête", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ta [ta]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 1) ...[
              Text("Cheveux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ɖà [da]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 2) ...[
              Text("L’oreille", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Tó [to]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 3) ...[
              Text("la bouche", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Nù [nou]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 4) ...[
              Text("les yeux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Nukún [noukoun]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 5) ...[
              Text("le nez", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Awɔntín [awontin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 6) ...[
              Text("le cou", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kɔ [kor]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 7) ...[
              Text("la poitrine", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Akɔ́nta [ajonta]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 8) ...[
              Text("le ventre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Adɔgo [adorgo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 9) ...[
              Text("le bras", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Awà [awa]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 10) ...[
              Text("le coude", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Awagóli [awagoli]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 11) ...[
              Text("la main", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Alɔ [alor]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 12) ...[
              Text("les doigts", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Alɔví [alorvi]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 13) ...[
              Text("la cuisse", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Asá [assa]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 14) ...[
              Text("la jambe", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gɛtɛ́ [guétè]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 15) ...[
              Text("le genou", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Koligó [koligo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 16) ...[
              Text("le pied", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Afɔ [afor]", style: TextStyle(fontSize: 20)),
            ]else if (textIndex == 17) ...[
              Text("les orteils", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Afɔví [aforvi]", style: TextStyle(fontSize: 20)),
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
