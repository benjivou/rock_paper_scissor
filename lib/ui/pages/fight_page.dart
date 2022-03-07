import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rps/controller/computer_player.dart';
import 'package:rps/controller/rock_paper_scissor.dart';
import 'package:rps/model/fight_argument.dart';
import 'package:rps/model/rock_papers_scissors_inputs.dart';
import 'package:rps/ui/widgets/counter_star.dart';

const _durationForAComputerRound = Duration(seconds: 2);
const _durationToDisplay = Duration(seconds: 1);

/// This page represent a fight page
class FightPage extends StatefulWidget {
  static const routeName = '/fight';
  final FightArgument args;
  const FightPage({
    required this.args,
    Key? key,
  }) : super(key: key);

  @override
  _FightPageState createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  int counterP1 = 0, counterP2 = 0;
  late RockPaperScissor game;
  late RockPaperScissorInputs user1Move, user2Move;
  String computerName = 'Computer';
  late String userName;
  late int winningValue;

  ComputerPlayer ia = ComputerPlayer(RockPaperScissorInputs.values);
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    winningValue = widget.args.limitToWin;
    userName = (widget.args.isPvCGame) ? 'User' : 'Computer 2';
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _generateFight(
              computerName,
              winningValue,
              counterP1,
              false,
            ),
            _generateFight(
              userName,
              winningValue,
              counterP2,
              widget.args.isPvCGame,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer!.cancel();
  }

  /// Display the UI for each users ( U have the username, the counter,
  ///  and the dropdown if the user is a real player)
  Widget _generateFight(
    String playerName,
    int numberOfStars,
    int currentScore,
    bool isAPlayer,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            playerName,
            style: Theme.of(context).textTheme.headline3,
          ),
          CounterStar(
            numberOfStars: numberOfStars,
            initialValue: currentScore,
          ),
          (isAPlayer) ? _getDropDown() : Container(),
        ],
      ),
    );
  }

  Widget _getDropDown() {
    return DropdownButton<RockPaperScissorInputs>(
        onChanged: (element) {
          if (element != null) {
            game.calculRound(ia.playARound(), element);
          }
        },
        items: RockPaperScissorInputs.values
            .map((RockPaperScissorInputs rockPaperScissorInputs) {
          return DropdownMenuItem<RockPaperScissorInputs>(
              value: rockPaperScissorInputs,
              child: Text(rockPaperScissorInputs.toString().split('.')[1]));
        }).toList());
  }

  /// Start the game
  void _refresh() {
    setState(() {
      counterP1 = 0;
      counterP2 = 0;
    });
    game = RockPaperScissor(
      onUser1WinRound: _onUser1WinRound,
      onUser2WinRound: _onUser2WinRound,
      onWin: _onWin,
      p1Name: computerName,
      p2Name: userName,
      onEndTurn: _onEndTurn,
      winningValue: winningValue,
    );
    if (widget.args.isPvCGame == false) {
      _timer = Timer(
        _durationForAComputerRound,
        playComputervComputerRound,
      );
    }
  }

  void _onWin(String name) async {
    // Stop the ia player
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$name is the winner'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('What would you want to do?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Battle again'),
              onPressed: () {
                Navigator.of(context).pop();
                _refresh();
              },
            ),
            TextButton(
              child: const Text('Leave'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onEndTurn(
    String user1Play,
    String user2Play,
  ) async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: _durationToDisplay,
            content: Text(
                '$computerName did  $user1Play  \n  & $userName did  $user2Play '),
          ),
        );
      }
    });
    if (widget.args.isPvCGame == false) {
      _timer = Timer(
        _durationForAComputerRound,
        playComputervComputerRound,
      );
    }
  }

  void _onUser1WinRound(int counter) {
    setState(() {
      counterP1 = counter;
    });
  }

  void _onUser2WinRound(int counter) {
    setState(() {
      counterP2 = counter;
    });
  }

  /// Represent a turn palayed when you want to watch a fully autonomous game
  void playComputervComputerRound() {
    game.calculRound(
      ia.playARound(),
      ia.playARound(),
    );
  }
}
