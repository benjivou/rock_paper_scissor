// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rps/controller/rock_paper_scissor.dart';

import 'package:rps/main.dart';
import 'package:rps/model/rock_papers_scissors_inputs.dart';

void main() {
  testWidgets('Test Home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MyApp(),
    );

    // Verify that the home page is display

    expect(find.text('Computer vs Computer'), findsOneWidget);
    expect(find.text('Player vs Computer'), findsOneWidget);
  });

  test('RockPaperScissor work properly', () async {
    const user1Name = 'p1';
    const user2Name = 'p2';
    const userWin = user1Name;

    var user1expected = RockPaperScissorInputs.rock;
    var user2expected = RockPaperScissorInputs.scissor;
    var counter1 = 1;
    var counter2 = 0;

    final game = RockPaperScissor(
        onEndTurn: (user1P, user2P) {
          expect(user1P, user1expected.toString().split('.')[1]);
          expect(user2P, user2expected.toString().split('.')[1]);
        },
        onUser1WinRound: (count) {
          expect(count, counter1);
        },
        onWin: (winner) {
          expect(winner, userWin);
        },
        p2Name: user2Name,
        p1Name: user1Name,
        onUser2WinRound: (count) {
          expect(count, counter2);
        },
        winningValue: 3);

    await game.calculRound(user1expected, user2expected);
    counter1++;
    user1expected = RockPaperScissorInputs.paper;

    user2expected = RockPaperScissorInputs.rock;

    await game.calculRound(user1expected, user2expected);

    counter2++;
    user1expected = RockPaperScissorInputs.rock;

    user2expected = RockPaperScissorInputs.paper;
    // new round
    await game.calculRound(user1expected, user2expected);

    user2expected = RockPaperScissorInputs.rock;
    // test on Par
    debugPrint('Test on Par');
    await game.calculRound(user1expected, user2expected);

    counter1++;
    user1expected = RockPaperScissorInputs.paper;

    user2expected = RockPaperScissorInputs.rock;
    // Test on Win
    debugPrint('Test on Win');
    await game.calculRound(user1expected, user2expected);
  });
}
