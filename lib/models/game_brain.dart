import 'package:hangman_game/models/word_model.dart';
import 'package:english_words/english_words.dart';

class GameBrain {
  List<WordModel> words = [
    // Football players
    WordModel("Messi", "Football"),
    WordModel("Ronaldo", "Football"),
    WordModel("Benzema", "Football"),
    WordModel("Neymar", "Football"),
    WordModel("Pele", "Football"),
    WordModel("Maradona", "Football"),
    WordModel("Zidane", "Football"),
    WordModel("Puskas", "Football"),
    WordModel("Henry", "Football"),
    WordModel("Maldini", "Football"),
    WordModel("Ronaldinho", "Football"),
    WordModel("Beckham", "Football"),
    WordModel("Iniesta", "Football"),
    WordModel("Xavi", "Football"),
    WordModel("Mbappe", "Football"),
    WordModel("Hakimi", "Football"),
    WordModel("Drogba", "Football"),
    WordModel("Valverde", "Football"),
    WordModel("Rakitic", "Football"),
    WordModel("Rashford", "Football"),
    WordModel("Dembele", "Football"),
    WordModel("Hernandez ", "Football"),
    WordModel("Pulisic", "Football"),
    WordModel("Muller", "Football"),
    WordModel("Carlos", "Football"),
    WordModel("Pique", "Football"),
    WordModel("Fabregas", "Football"),
    WordModel("Puyol", "Football"),

    // Movies
    WordModel("Titanic ", "Movies"),
    WordModel("Matrix ", "Movies"),
    WordModel("Inception", "Movies"),
    WordModel("Godfather ", "Movies"),
    WordModel("Avengers", "Movies"),
    WordModel("Interstellar", "Movies"),
    WordModel("GetOut", "Movies"),
    WordModel("BlackPanther", "Movies"),
    WordModel("Parasite", "Movies"),
    WordModel("Joker", "Movies"),
    WordModel("SpiderMan", "Movies"),
    WordModel("Dune", "Movies"),
    WordModel("TheNun", "Movies"),
    WordModel("Avatar", "Movies"),
    WordModel("Oppenheimer", "Movies"),
    WordModel("Transporter", "Movies"),
    WordModel("Terminator", "Movies"),
    WordModel("Transformers", "Movies"),
    WordModel("Cars", "Movies"),
    WordModel("BossBaby", "Movies"),
    WordModel("BabyDriver", "Movies"),

    // Hard Words
    WordModel("Breeze", "Hard"),
    WordModel("Canvas", "Hard"),
    WordModel("Animal", "Hard"),
    WordModel("Dazzle", "Hard"),
    WordModel("Effort", "Hard"),
    WordModel("Fumble", "Hard"),
    WordModel("Glisten", "Hard"),
    WordModel("Harmony", "Hard"),
    WordModel("Inform", "Hard"),
    WordModel("Jumble", "Hard"),
    WordModel("Kindly", "Hard"),
    WordModel("Lively", "Hard"),
    WordModel("Marvel", "Hard"),
    WordModel("Noble", "Hard"),
    WordModel("Oyster", "Hard"),
    WordModel("Plunge", "Hard"),
    WordModel("Quiver", "Hard"),
    WordModel("Radiant", "Hard"),
    WordModel("Serene", "Hard"),
    WordModel("Thrive", "Hard"),
    WordModel("Jungle", "Hard"),
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

  List<WordModel> getMovies() {
    List<WordModel> movies = [];

    for (var element in words) {
      if (element.wordCategory == "Movies") {
        movies.add(element);
      }
    }

    return movies;
  }

  List<WordModel> getRandomWords() {
    List<WordModel> words = [];
    var list = nouns.take(60);

    for (var element in list) {
      words.add(WordModel(element, "Hard"));
    }

    return words;
  }

  List<WordModel> getHardWords() {
    List<WordModel> hardWords = [];

    for (var element in words) {
      if (element.wordCategory == "Hard") {
        hardWords.add(element);
      }
    }

    return hardWords;
  }
}
