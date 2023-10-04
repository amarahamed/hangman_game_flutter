import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangman_game/models/word_model.dart';
import 'package:hangman_game/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final alphabets = List.generate(26, (index) => String.fromCharCode(index + 65));

class GameScreen extends StatefulWidget {
  final List<WordModel> words;

  const GameScreen(this.words, {super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Widget> listBtns = [];
  // String word = widget.words.elementAt(0).word;

  // used letters
  List<String> usedLetters = [];

  // List of char array of the guessing word
  List<String> wordArray = [];

  // List of char array of the guessing word (Hidden as dashes)
  List<String> wordArrayHidden = [];

  String guessWord = "";

  List<String> wordInUpperCase = [];

  // max 6
  int lives = 0;

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

  @override
  void initState() {
    super.initState();
    listBtns = alphabetBtn();

    // get a random word from the passed List
    WordModel w = widget.words[Random.secure().nextInt(widget.words.length)];
    // save to word array as a character array ex: ['H', 'E', 'L', 'L', 'O']
    wordArray = w.word.split('');

    updateHiddenWord();
    updateScreen();
    print(wordArray);
    wordInUpperCase = wordArray.map((e) => e.toUpperCase()).toList();
  }

  List<Widget> alphabetBtn() {
    List<Widget> buttons = [];

    for (int x = 0; x < 26; x++) {
      buttons.add(ElevatedButton(
        onPressed: () {
          // check if the letter has been already used
          if (usedLetters.contains(alphabets[x])) {
            // say already used
            Alert(
                    context: context,
                    title: "Already Used!",
                    desc: "The letter ${alphabets[x]} already used")
                .show();
          } else {
            setState(() {
              usedLetters.add(alphabets[x].toUpperCase());
            });

            if (wordInUpperCase.contains(alphabets[x].toUpperCase())) {
              print("Letter matched!");
              for (int y = 0; y <= wordInUpperCase.length - 1; y++) {
                if (wordInUpperCase[y] == alphabets[x].toUpperCase()) {
                  // update screen with the new letter
                  setState(() {
                    wordArrayHidden[y] = alphabets[x].toUpperCase();
                    print("Hidden Array: $wordArrayHidden");
                    updateScreen();
                  });
                }
              }
            } else {
              print("Letter not in the word : (");
              if (lives == 6) {
                Alert(
                        context: context,
                        title: "Game Over!",
                        desc: "Hangman Died : (")
                    .show();
              } else {
                lives++;
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD9D9D9),
          foregroundColor: Colors.black87,
          minimumSize: const Size(40, 40),
        ),
        child: Text(
          alphabets.elementAt(x),
          style: const TextStyle(
            fontSize: 16,
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
          Image.asset("assets/images/1.png"),
          // number of blanks
          Center(
            child: Text(
              guessWord,
              style: kTitleTextStyle,
            ),
          ),
          // keypad
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Center(
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: listBtns,
              ),
            ),
          ),
          // used letters

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'USED: ',
                style: kBtnTitleTextStyle,
              ),
              // const SizedBox(
              //   width: 5,
              // ),
              Row(
                children: usedLetters
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            padding: const EdgeInsets.all(5),
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
