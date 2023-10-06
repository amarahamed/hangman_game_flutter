import 'package:flutter/material.dart';
import 'package:hangman_game/models/game_brain.dart';
import 'package:hangman_game/models/word_model.dart';

import '../Screens/game_screen.dart';
import 'constants.dart';

class ReusableBtn extends StatelessWidget {
  final String btnTitle;

  const ReusableBtn({
    super.key,
    required this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          List<WordModel> words = [];
          GameBrain gameBrain = GameBrain();

          switch (btnTitle) {
            case "Football":
              {
                words = gameBrain.getFootballWords();
              }
              break;
            case "Easy":
              {
                words = gameBrain.getRandomWords();
              }
              break;
            case "Hard":
              {
                words = gameBrain.getHardWords();
              }
            case "Movies":
              {
                words = gameBrain.getMovies();
              }
            default:
              {
                words = gameBrain.getRandomWords();
              }
              break;
          }

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GameScreen(words);
          }));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: kBtnBackgroundColor,
            textStyle: kBtnTitleTextStyle),
        child: Text(btnTitle),
      ),
    );
  }
}
