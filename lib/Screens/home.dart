import 'package:flutter/material.dart';
import 'package:hangman_game/utilities/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'HANG \n MAN',
                style: kTitleTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableBtn(
                        btnTitle: 'Football',
                      ),
                      SizedBox(width: 18),
                      ReusableBtn(
                        btnTitle: 'Movies',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ReusableBtn(
                        btnTitle: 'Easy',
                      ),
                      SizedBox(width: 18),
                      ReusableBtn(
                        btnTitle: 'Hard',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          print('Hello');
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: kBtnBackgroundColor,
            textStyle: kBtnTitleTextStyle),
        child: Text(btnTitle),
      ),
    );
  }
}
