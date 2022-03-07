import 'package:rps/controller/game_logic_mixin.dart';
import 'package:rps/model/rock_papers_scissors_inputs.dart';

/// This the Rock Paper Scissor game it stores :
///
/// - The number of points of each player [counter1] & [counter2]
///
/// - [winningValue] is the score to win the game
///
/// - [onUser1WinRound] represents what to do on a user1 Win
/// and pass the current score of the user 1
///
/// - [onUser2WinRound] represents what to do on a  user2 Win
/// and pass the current score of the user 2
///
/// - [p1Name] && [p2Name] represent the user's names
///
/// - [onEndTurn] in parameter you have the move of each players and
/// this represents what to do at the end.
///
class RockPaperScissor implements GameLogic<RockPaperScissorInputs> {
  int counter1 = 0, counter2 = 0;
  int winningValue;
  @override
  Function(int) onUser1WinRound;

  @override
  Function(int) onUser2WinRound;

  @override
  String p1Name;

  @override
  String p2Name;

  @override
  Function(String) onWin;

  @override
  Function(String, String) onEndTurn;

  RockPaperScissor({
    required this.onUser1WinRound,
    required this.onUser2WinRound,
    required this.onWin,
    required this.p1Name,
    required this.p2Name,
    required this.onEndTurn,
    required this.winningValue,
  });

  /// Compute the result of a round
  @override
  Future<void> calculRound(
    RockPaperScissorInputs user1Inputs,
    RockPaperScissorInputs user2Inputs,
  ) async {
    await onEndTurn(user1Inputs.toString().split('.')[1],
        user2Inputs.toString().split('.')[1]);
    if (user1Inputs == user2Inputs) return;

    if (_isUser1WinnerOfTheRound(user1Inputs, user2Inputs)) {
      counter1++;
      onUser1WinRound(counter1);
      if (counter1 == winningValue) await onWin(p1Name);
    } else {
      counter2++;
      onUser2WinRound(counter2);
      if (counter2 == winningValue) await onWin(p2Name);
    }
  }

  bool _isUser1WinnerOfTheRound(
      RockPaperScissorInputs user1Inputs, RockPaperScissorInputs user2Inputs) {
    bool is1Win;
    switch (user1Inputs) {
      case RockPaperScissorInputs.paper:
        is1Win = (user2Inputs == RockPaperScissorInputs.rock);
        break;
      case RockPaperScissorInputs.scissor:
        is1Win = (user2Inputs == RockPaperScissorInputs.paper);
        break;
      case RockPaperScissorInputs.rock:
        is1Win = (user2Inputs == RockPaperScissorInputs.scissor);
        break;
    }
    return is1Win;
  }
}
