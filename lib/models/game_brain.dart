import 'package:hangman_game/models/word_model.dart';

class GameBrain {
  List<WordModel> words = [
    WordModel("Messi", "Football"),
    WordModel("Ronaldo", "Football"),
    WordModel("Benzema", "Football"),
    WordModel("Neymar", "Football"),
    WordModel("Hello", "Easy")
  ];

  List<WordModel> getFootballWords() {
    List<WordModel> footballWords = [];

    for (var element in words) {
      if (element.wordCategory == "Football") {
        footballWords.add(element);
      }
    }

    return footballWords;
  }

  List<WordModel> getEasyWords() {
    List<WordModel> easyWords = [];

    for (var element in words) {
      if (element.wordCategory == "Easy") {
        easyWords.add(element);
      }
    }

    return easyWords;
  }
}
