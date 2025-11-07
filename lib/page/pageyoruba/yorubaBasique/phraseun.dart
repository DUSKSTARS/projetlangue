import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projetlangue/page/pageyoruba/yorubaBasique/exoun.dart';


class PhrPage extends StatefulWidget {
  @override
  _PhrPageState createState() => _PhrPageState();
}

class _PhrPageState extends State<PhrPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double volume = 1.0; // Volume par défaut (100%)

  final List<Map<String, String>> phrases = [
    {'fr': "Bonjour", 'fon': "Ẹ káàárọ̀", 'audio': "bjr.mp3"},
    {'fr': "Comment vas-tu ?", 'fon': "Báwo ni?", 'audio': "cmtvt.mp3"},
    {'fr': "Merci beaucoup", 'fon': "Ẹ ṣé gan", 'audio': "merci.mp3"},
    {'fr': "Je t'aime", 'fon': "Mo nífẹ̀ẹ́ rẹ", 'audio': "jetaime.mp3"},
    {'fr': "Au revoir", 'fon': "Ó dábò", 'audio': "nnn.mp3"},
    {'fr': "Non", 'fon': "Rárá", 'audio': "nnn.mp3"},
    {'fr': "Mon Dieu !", 'fon': "Olúwa mi!", 'audio': "nnn.mp3"},

    {'fr': "Je suis fâché à toi.", 'fon': "Mo bínú sí ẹ", 'audio': "nnn.mp3"},
    {'fr': "C'est faux, ce n'est pas vrai.", 'fon': "Kò tọ́, kò jẹ́ òtítọ́", 'audio': "nnn.mp3"},
    {'fr': "Merci beaucoup", 'fon': "Ẹ ṣé gan", 'audio': "nnn.mp3"},
    {'fr': "Eh, toi, le blanc, viens m'acheter quelque chose!", 'fon': "Yòvò! Wá ra nkan fún mi!", 'audio': "nnn.mp3"},
    {'fr': "Donnes mes salutations aux tiens de ma part.", 'fon': "Fi ìkíni mi ránṣẹ́ sí ẹbí rẹ", 'audio': "nnn.mp3"},
    {'fr': "Viens chez moi et nous pourrons discuter.", 'fon': "Wá sí ilé mi, a ó lè sọrọ̀", 'audio': "nnn.mp3"},
    {'fr': "Parlez-vous le fon ? Non, je ne parle pas le fon", 'fon': "Ṣé o mọ Fongbé? Rárá, mi ò mọ Fongbé", 'audio': "nnn.mp3"},
    {'fr': "Oui, je parle bien le fon", 'fon': "Béèni, mo mọ Fongbé dáadáa", 'audio': "nnn.mp3"},
    {'fr': "Parles-tu anglais ?", 'fon': "Ṣé o mọ Gẹ̀ẹ́sì?", 'audio': "nnn.mp3"},
    {'fr': "Parles-tu français ?", 'fon': "Ṣé o mọ Faranṣé?", 'audio': "nnn.mp3"},
    {'fr': "Je vais voyager", 'fon': "Mo ń lọ ìrìn-àjò", 'audio': "nnn.mp3"},
    {'fr': "C'est cher !", 'fon': "Ó jẹ́ gíga!", 'audio': "nnn.mp3"},
    {'fr': "C'est beaucoup !", 'fon': "Ó pọ̀!", 'audio': "nnn.mp3"},
    {'fr': "Waouh ! Le blanc parle le Fon !", 'fon': "Ah! Yòvò ń sọ Fongbé!", 'audio': "nnn.mp3"},
    {'fr': "Tes habits sont vraiment beaux", 'fon': "Àṣọ rẹ jẹ́ lẹ́wà", 'audio': "nnn.mp3"},
    {'fr': "Va et reviens. J'irai et je reviendrai.", 'fon': "Lọ, kí o sì padà. Èmi ó lọ, èmi ó sì padà", 'audio': "nnn.mp3"},
    {'fr': "Sors de là.", 'fon': "Jádè níbè", 'audio': "nnn.mp3"},
    {'fr': "Doucement", 'fon': "Ní ìfẹ̀", 'audio': "nnn.mp3"},
  ];



    void playAudio(String fileName) async {
      try {
        await _audioPlayer.setVolume(volume); // utilise le volume actuel
        await _audioPlayer.play(AssetSource('vocal/$fileName'));
      } catch (e) {
        print('Erreur lors de la lecture audio : $e');
      }
    }

    @override
    void dispose() {
      _audioPlayer.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phrases en français et en fon")),
      body: Column(
        children: [
          // Slider de volume en haut
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),


                              Text("Connaissance",
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
                                  child: Text("Page de test"),
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
