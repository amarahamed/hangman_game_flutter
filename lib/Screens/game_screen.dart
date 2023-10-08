import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangman_game/models/word_model.dart';
import 'package:hangman_game/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// play audio
import 'package:audioplayers/audioplayers.dart';

// generates all alphabets
final alphabets = List.generate(26, (index) => String.fromCharCode(index + 65));

class GameScreen extends StatefulWidget {
  final List<WordModel> words;

  const GameScreen(this.words, {super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // stores all alphabetic keys
  List<Widget> listBtns = [];

  // used letters
  List<String> usedLetters = [];

  // List of char array of the guessing word
  List<String> wordArray = [];

  // List of char array of the guessing word (Hidden as underscores)
  List<String> wordArrayHidden = [];

  // guessedWord will update each time a letter found
  String guessWord = "";

  // List<String> wordInUpperCase = [];

  // max 6
  int lives = 0;

  bool gameWon = false;

  // Guessing Word Model
  late WordModel wordModel;

  // Audio Player
  AudioPlayer audioPlayer = AudioPlayer();

  // Method adds _ to every letter of the guessing word and store in a string array like a character array
  void updateHiddenWord() {
    for (String c in wordArray) {
      wordArrayHidden.add("_");
    }
  }

  void updateScreen() {
    setState(() {
      guessWord = "";
      for (String x in wordArrayHidden) {
        guessWord = guessWord + x;
      }
    });
  }

  // show alert whenever called
  void showAlert(String alertTitle, String description) {
    Alert(context: context, title: alertTitle, desc: description).show();
  }

  @override
  void initState() {
    super.initState();
    listBtns = alphabetBtn();

    // get a random word from the passed List
    wordModel = widget.words[Random.secure().nextInt(widget.words.length)];
    // save to word array as a character array ex: ['H', 'E', 'L', 'L', 'O']
    wordArray = wordModel.word.split('');

    updateHiddenWord();
    // updates screen to show how many letters to be found
    updateScreen();
    print("Word ArrayL: $wordArray");
  }

  // Returns a list of alphabet key pad
  List<Widget> alphabetBtn() {
    List<Widget> buttons = [];

    // 26 alphabets
    for (int x = 0; x < 26; x++) {
      buttons.add(ElevatedButton(
        // on pressed function for each button
        onPressed: () async {
          // check if game won - doesn't let to tap if game already won
          if (!gameWon) {
            // check if player has enough lives
            if (lives < 5) {
              // check if the input letter has been already used
              if (usedLetters.contains(alphabets[x])) {
                // Alert player that the letter has been already used
                showAlert("Already Used", "${alphabets[x]} already used");
              } else {
                // change state for the used letter list
                setState(() {
                  usedLetters.add(alphabets[x]);
                });

                // check if letter guessed is correct
                if (wordArray.contains(alphabets[x])) {
                  // play answer found tone
                  await audioPlayer
                      .setSource(AssetSource('audio/correct_answer.mp3'));
                  await audioPlayer.resume();

                  // replace the dash in wordArrayHidden with the correctly guessed letter
                  for (int y = 0; y <= wordArray.length - 1; y++) {
                    if (wordArray[y] == alphabets[x]) {
                      // update screen with the new letter
                      setState(() {
                        wordArrayHidden[y] = alphabets[x];
                        updateScreen();

                        // check if all letters has been found
                        if (wordArrayHidden.join() ==
                            wordModel.word.toUpperCase()) {
                          // flag the system game won
                          gameWon = true;
                          // show alert to say game won
                          showAlert("You Won 🥳", "You found the word!");
                        }
                      });
                      // play game won tone outside setState
                      if (wordArrayHidden.join() ==
                          wordModel.word.toUpperCase()) {
                        await audioPlayer
                            .setSource(AssetSource('audio/game_won.mp3'));
                        await audioPlayer.resume();
                      }
                    }
                  }
                } else {
                  await audioPlayer
                      .setSource(AssetSource('audio/wrong_answer.mp3'));
                  await audioPlayer.resume();
                  // increment life left, max: 6
                  setState(() {
                    lives++;
                  });
                }
              }
            } else {
              // if all lives over play game over tone
              await audioPlayer.setSource(AssetSource('audio/game_over.mp3'));
              await audioPlayer.resume();
              // update hangman image
              setState(() {
                lives = 6;
              });
              // show alert saying game over
              showAlert("Hangman died 😢", "Word was ${wordModel.word}");
            }
          } else {
            // show alert saying game already won, triggers when user taps on button after game won
            showAlert("You Won 🥳", "You found the word!");
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD9D9D9),
          foregroundColor: Colors.black87,
          minimumSize: const Size(36, 36),
        ),
        child: Text(
          alphabets.elementAt(x),
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Righteous',
          ),
        ),
      ));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // hangman image - updates each time user losses life
          Image.asset("assets/images/$lives.png"),
          // guess letters
          Center(
            child: Text(
              guessWord,
              style: kWordTextStyle,
            ),
          ),
          //
          // keypad
          //
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Center(
              child: Wrap(
                spacing: 4,
                runSpacing: 2,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: listBtns,
              ),
            ),
          ),
          //
          // used letters
          //
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              const Text(
                'USED',
                style: kBtnTitleTextStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: usedLetters
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.5, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              e,
                              style: kBtnTitleTextStyle.copyWith(
                                  color: Colors.black87),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
