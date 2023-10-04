import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF101815);
const Color kBtnBackgroundColor = Color(0xFF6FC28A);

const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 68,
  color: Color(0xFFFFFFFF),
  fontFamily: 'Righteous',
);

const TextStyle kBtnTitleTextStyle = TextStyle(
  fontSize: 20,
  color: Color(0xFFFFFFFF),
  fontFamily: 'Righteous',
  letterSpacing: 1,
);

// List<Widget> alphabetBtn(int start, int end) {
//   List<Widget> buttons = [];
//
//   for (int x = start; x < end; x++) {
//     buttons.add(Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 2.5),
//         child: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFD9D9D9),
//               foregroundColor: Colors.black87),
//           child: Text(
//             alphabets.elementAt(x),
//             style: const TextStyle(
//               fontSize: 16,
//               fontFamily: 'Righteous',
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
//
//   return buttons;
// }

// Row(
// children: alphabetBtn(0, 7),
// ),
// Row(
// children: alphabetBtn(7, 14),
// ),
// Row(
// children: alphabetBtn(14, 21),
// ),
// Row(
// children: alphabetBtn(21, 26),
// ),
