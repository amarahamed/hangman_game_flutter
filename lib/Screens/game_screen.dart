import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangman_game/models/word_model.dart';
import 'package:hangman_game/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

  List<Widget> alphabetBtn() {
    List<Widget> buttons = [];

    for (int x = 0; x < 26; x++) {
      buttons.add(ElevatedButton(
        onPressed: () {
          // check if game won
          if (!gameWon) {
            // check if player has enough lives
            if (lives < 6) {
              // check if the letter has been already used
              if (usedLetters.contains(alphabets[x])) {
                // Alert player that the letter has been already used
                showAlert("Already Used", "${alphabets[x]} already used");
              } else {
                // change state for the used letter
                setState(() {
                  usedLetters.add(alphabets[x]);
                });

                // check if letter
                if (wordArray.contains(alphabets[x])) {
                  for (int y = 0; y <= wordArray.length - 1; y++) {
                    if (wordArray[y] == alphabets[x]) {
                      // update screen with the new letter
                      setState(() {
                        wordArrayHidden[y] = alphabets[x];
                        // wordArray[y] = alphabets[x];
                        updateScreen();

                        if (wordArrayHidden.join() ==
                            wordModel.word.toUpperCase()) {
                          gameWon = true;

                          showAlert("You Won", "Good Job! You found the word!");
                        }
                      });
                    }
                  }
                } else {
                  setState(() {
                    lives++;
                  });
                }
              }
            } else {
              showAlert("Game Over", "Hangman died : ( ");
            }
          } else {
            showAlert("You Won", "Good Job! You found the word!");
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
          // Add asset image
          Image.asset("assets/images/$lives.png"),
          // number of blanks
          Center(
            child: Text(
              guessWord,
              style: kWordTextStyle,
            ),
          ),
          // keypad
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
          // used letters

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
