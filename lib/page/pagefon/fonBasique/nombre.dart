import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NbrPage extends StatefulWidget {
  @override
  _NbrPageState createState() => _NbrPageState();
}

class _NbrPageState extends State<NbrPage> {
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
      appBar: AppBar(title: Text("Les nombres en fon")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            if (textIndex == 0) ...[
              Text("Un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("ɖokpó\n[dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 1) ...[
              Text("Deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Wè\n[We]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 2) ...[
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
              Text("Dix", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Wǒ\n[Wo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 10) ...[
              Text("Onze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Wŏ ɖokpó\n[Wo dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 11) ...[
              Text("Douze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Wĕwè\n[Wéwé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 12) ...[
              Text("Treize", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Wǎtɔ̀n\n[Waton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 13) ...[
              Text("Quatorze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Wɛ̌nɛ̀\n[Wènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 14) ...[
              Text("Quinze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Afɔtɔ̀n\n[Afoton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 15) ...[
              Text("Seize", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Fɔtɔ̀n nukún ɖokpó\n[Foton noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 16) ...[
              Text("Dix-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Fɔtɔ̀n nukún wè\n[Foton noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 17) ...[
              Text("Dix-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Fɔtɔ̀n nukún atɔ̀n\n[Foton noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 18) ...[
              Text("Dix-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Fɔtɔ̀n nukún ɛnɛ̀\n[Foton noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 19) ...[
              Text("Vingt", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko\n[Ko]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 20) ...[
              Text("Vingt et un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko nukún ɖokpó\n[Ko noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ]else if (textIndex == 21) ...[
              Text("Vingt-deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko nukún wè\n[Ko noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 22) ...[
              Text("Vingt-trois", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko nukún atɔ̀n\n[Ko noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 23) ...[
              Text("Vingt-quatre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko nukún ɛnɛ̀\n[Ko noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 24) ...[
              Text("Vingt-cinq", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko atɔ̀ɔ̀n\n[Ko aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 25) ...[
              Text("Vingt-six", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko atɔ̀ɔ̀n nukún ɖokpó\n[Ko aton noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 26) ...[
              Text("Vingt-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko atɔ̀ɔ̀n nukún wè\n[Ko aton noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 27) ...[
              Text("Vingt-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko atɔ̀ɔ̀n nukún atɔ̀n\n[Ko aton noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 28) ...[
              Text("Vingt-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Ko atɔ̀ɔ̀n nukún ɛnɛ̀\n[Ko aton noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 29) ...[
              Text("Trente", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn\n[Gban]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 30) ...[
              Text("Trente et un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn nukún ɖokpó\n[Gban noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 31) ...[
              Text("Trente-deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn nukún wè\n[Gban noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 32) ...[
              Text("Trente-trois", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn nukún atɔ̀n\n[Gban noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 33) ...[
              Text("Trente-quatre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn nukún ɛnɛ̀\n[Gban noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 34) ...[
              Text("Trente-cinq", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn’tɔ́ɔ́n\n[Gbanton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 35) ...[
              Text("Trente-six", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn’tɔ́ɔ́n nukún ɖokpó\n[Gbanton noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 36) ...[
              Text("Trente-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn’tɔ́ɔ́n nukún wè\n[Gbanton noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 37) ...[
              Text("Trente-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn’tɔ́ɔ́n nukún atɔ̀n\n[Gbanton noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 38) ...[
              Text("Trente-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Gbàn’tɔ́ɔ́n nukún ɛnɛ̀\n[Gbanton noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 39) ...[
              Text("Quarante", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé\n[Kandé]", style: TextStyle(fontSize: 20)),
            ]else if (textIndex == 40) ...[
              Text("Quarante et un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé nukún ɖokpó\n[Kandé noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 41) ...[
              Text("Quarante-deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé nukún wè\n[Kandé noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 42) ...[
              Text("Quarante-trois", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé nukún atɔ̀n\n[Kandé noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 43) ...[
              Text("Quarante-quatre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé nukún ɛnɛ̀\n[Kandé noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 44) ...[
              Text("Quarante-cinq", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé atɔ̀ɔ̀n\n[Kandé aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 45) ...[
              Text("Quarante-six", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ayizɛ́n\n[Kandé Ayizin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 46) ...[
              Text("Quarante-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé tɛ́nwè\n[Kandé Tinwé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 47) ...[
              Text("Quarante-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé tántɔ̀n\n[Kandé Tanton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 48) ...[
              Text("Quarante-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé tɛ́nnɛ̀\n[Kandé Tinnin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 49) ...[
              Text("Cinquante", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé wŏ\n[Kandé Wo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 50) ...[
              Text("Cinquante et un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé wŏ ɖokpó\n[Kandé Wo dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 51) ...[
              Text("Cinquante-deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé wɛ̌wè\n[Kandé Wéwé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 52) ...[
              Text("Cinquante-trois", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé Wǎtɔ̀n\n[Kandé Waton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 53) ...[
              Text("Cinquante-quatre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé wɛ̌nɛ̀\n[Kandé Wènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 54) ...[
              Text("Cinquante-cinq", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖè’fɔtɔ̀n\n[Kandéfoton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 55) ...[
              Text("Cinquante-six", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖè’fɔtɔ̀n nukún ɖokpó\n[Kandéfoton noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 56) ...[
              Text("Cinquante-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖè’fɔtɔ̀n nukún wè\n[Kandéfoton noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 57) ...[
              Text("Cinquante-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖè’fɔtɔ̀n nukún atɔ̀n\n[Kandéfoton noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 58) ...[
              Text("Cinquante-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖè’fɔtɔ̀n nukún ɛnɛ̀\n[Kandéfoton noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 59) ...[
              Text("Soixante", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko\n[Kandé ko]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 60) ...[
              Text("Soixante et un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko nukún ɖokpó\n[Kandé ko noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ]else if (textIndex == 61) ...[
              Text("Soixante-deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko nukún wè\n[Kandé ko noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 62) ...[
              Text("Soixante-trois", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko nukún atɔ̀n\n[Kandé ko noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 63) ...[
              Text("Soixante-quatre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko nukún ɛnɛ̀\n[Kandé ko noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 64) ...[
              Text("Soixante-cinq", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko atɔ́ɔ́n\n[Kandé ko aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 65) ...[
              Text("Soixante-six", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko atɔ́ɔ́n nukún ɖokpó\n[Kandé ko aton noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 66) ...[
              Text("Soixante-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko atɔ́ɔ́n nukún wè\n[Kandé ko aton noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 67) ...[
              Text("Soixante-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko atɔ́ɔ́n nukún atɔ̀n\n[Kandé ko aton noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 68) ...[
              Text("Soixante-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé ko atɔ́ɔ́n nukún ɛnɛ̀\n[Kandé ko aton noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 69) ...[
              Text("Soixante-dix", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn\n[Kandé gban]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 70) ...[
              Text("Soixante et onze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn nukún ɖokpó\n[Kandé gban noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 71) ...[
              Text("Soixante-douze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn nukún wè\n[Kandé gban noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 72) ...[
              Text("Soixante-treize", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn nukún atɔ̀n\n[Kandé gban noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 73) ...[
              Text("Soixante-quatorze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn nukún ɛnɛ̀\n[Kandé gban noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 74) ...[
              Text("Soixante-quinze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn’tɔ́ɔ́n\n[Kandé Gbanton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 75) ...[
              Text("Soixante-seize", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn’tɔ́ɔ́n nukún ɖokpó\n[Kandé Gbanton noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 76) ...[
              Text("Soixante-dix-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn’tɔ́ɔ́n nukún wè\n[Kandé Gbanton noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 77) ...[
              Text("Soixante-dix-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn’tɔ́ɔ́n nukún atɔ̀n\n[Kandé Gbanton noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 78) ...[
              Text("Soixante-dix-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanɖé gbàn’tɔ́ɔ́n nukún ɛnɛ̀\n[Kandé Gbanton noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 79) ...[
              Text("Quatre-vingts", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè\n[Kanwé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 80) ...[
              Text("Quatre-vingt-un", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè nukún ɖokpó\n[Kanwé noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ]else if (textIndex == 81) ...[
              Text("Quatre-vingt-deux", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè nukún wè\n[Kanwé noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 82) ...[
              Text("Quatre-vingt-trois", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè nukún atɔ̀n\n[Kanwé noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 83) ...[
              Text("Quatre-vingt-quatre", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè nukún ɛnɛ̀\n[Kanwé noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 84) ...[
              Text("Quatre-vingt-cinq", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè atɔ́ɔ́n\n[Kanwé aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 85) ...[
              Text("Quatre-vingt-six", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè ayizɛ́n\n[Kanwé ayizin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 86) ...[
              Text("Quatre-vingt-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè tɛ́nwè\n[Kanwé tinwé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 87) ...[
              Text("Quatre-vingt-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè tántɔ̀n\n[Kanwé tanton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 88) ...[
              Text("Quatre-vingt-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè tɛ́nnɛ̀\n[Kanwé tinnin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 89) ...[
              Text("Quatre-vingt-dix", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè wŏ\n[Kanwé wo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 90) ...[
              Text("Quatre-vingt-onze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè wŏ ɖokpó\n[Kanwé wo dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 91) ...[
              Text("Quatre-vingt-douze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè wěwè\n[Kanwé wéwé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 92) ...[
              Text("Quatre-vingt-treize", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè wǎtɔ̀n\n[Kanwé waton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 93) ...[
              Text("Quatre-vingt-quatorze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè wɛ̌nɛ̀\n[Kanwé wènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 94) ...[
              Text("Quatre-vingt-quinze", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè’fɔtɔ̀n\n[Kanwé afoton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 95) ...[
              Text("Quatre-vingt-seize", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè’fɔtɔ̀n nukún ɖokpó\n[Kanwéfoton noukoun dokpo]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 96) ...[
              Text("Quatre-vingt-dix-sept", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè’fɔtɔ̀n nukún wè\n[Kanwéfoton noukoun wé]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 97) ...[
              Text("Quatre-vingt-dix-huit", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè’fɔtɔ̀n nukún atɔ̀n\n[Kanwéfoton noukoun aton]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 98) ...[
              Text("Quatre-vingt-dix-neuf", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè’fɔtɔ̀n nukún ɛnɛ̀\n[Kanwéfoton noukoun Ènin]", style: TextStyle(fontSize: 20)),
            ] else if (textIndex == 99) ...[
              Text("Cent", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Kanwè ko\n[Kanwé ko]", style: TextStyle(fontSize: 20)),
            ]else if (textIndex == 100) ...[
              Text("Page spéciale",
              style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () { },
                child: Text("Aller à la page spéciale"),
                ),
            ]
            else ...[
              SizedBox(height: 30),
            ],

            // Boutons navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (textIndex != 100)
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
                if (textIndex < 100)
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
