import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PhrPage extends StatefulWidget {
  @override
  _PhrPageState createState() => _PhrPageState();
}

class _PhrPageState extends State<PhrPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, String>> phrases = [
    {'fr': "Bonjour", 'fon': "A fon gbé", 'audio': "bjr.mp3"},
    {'fr': "Comment vas-tu ?", 'fon': "Dɔ gbe na ?", 'audio': "cmtvt.mp3"},
    {'fr': "Merci beaucoup", 'fon': "A kpe nu", 'audio': "merci.mp3"},
    {'fr': "Je t'aime", 'fon': "Mè do wè", 'audio': "jetaime.mp3"},
    {'fr': "Au revoir", 'fon': "Dada gbé", 'audio': "nnn.mp3"},

    // Nouvelles phrases
    {'fr': "Non", 'fon': "Eho", 'audio': "nnn.mp3"},
    {'fr': "Mon Dieu !", 'fon': "Mawu", 'audio': "nnn.mp3"},
    {'fr': "Je suis fâché à toi.", 'fon': "Un sin xome nu we", 'audio': "nnn.mp3"},
    {'fr': "C'est faux, ce n'est pas vrai.", 'fon': "A din gbawe, nu gbo we ã", 'audio': "nnn.mp3"},
    {'fr': "Merci beaucoup", 'fon': "A houanu kaka", 'audio': "nnn.mp3"},
    {'fr': "Eh, toi, le blanc, viens m'acheter quelque chose!", 'fon': "Yovo! Wa xo nu!", 'audio': "nnn.mp3"},
    {'fr': "Donnes mes salutations aux tiens de ma part.", 'fon': "A na dogbe me towele nu mi,...Eeen, ye na se.", 'audio': "nnn.mp3"},
    {'fr': "Viens chez moi et nous pourrons discuter.", 'fon': "A na wa gonche kpo mi no do xo kpede.", 'audio': "nnn.mp3"},
    {'fr': "Parlez-vous le fon ? Non, je ne parle pas le fon", 'fon': "A se Fongbe a?...Eho, Un se fongbe a.", 'audio': "nnn.mp3"},
    {'fr': "Oui, je parle bien le fon", 'fon': "Eeen, Un se fongbe bi", 'audio': "nnn.mp3"},
    {'fr': "Parles-tu anglais ?", 'fon': "A se glensigbe we a?", 'audio': "nnn.mp3"},
    {'fr': "Parles-tu français ?", 'fon': "A se Flansegbe we a?", 'audio': "nnn.mp3"},
    {'fr': "Je vais voyager", 'fon': "Un na yi tonme", 'audio': "nnn.mp3"},
    {'fr': "C'est cher !", 'fon': "Ah! E ve axi din!", 'audio': "nnn.mp3"},
    {'fr': "C'est beaucoup !", 'fon': "E sukpo din!", 'audio': "nnn.mp3"},
    {'fr': "Waouh ! Le blanc parle le Fon !", 'fon': "Ah! Yovo se Fongbe!", 'audio': "nnn.mp3"},
    {'fr': "Tes habits sont vraiment beaux", 'fon': "Avo towe, enyo dekpe din.", 'audio': "nnn.mp3"},
    {'fr': "Va et reviens. J'irai et je reviendrai.", 'fon': "Bo yi bo wa...ma yi bo wa", 'audio': "nnn.mp3"},
    {'fr': "Sors de là.", 'fon': "Bo yi", 'audio': "nnn.mp3"},
    {'fr': "Doucement", 'fon': "Dedeme", 'audio': "nnn.mp3"},
  ];

  void playAudio(String fileName) async {
    await _audioPlayer.play(AssetSource('vocal/$fileName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phrases en français et en fon")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
