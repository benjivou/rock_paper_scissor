import 'package:flutter/material.dart';
import 'package:rps/model/fight_argument.dart';
import 'package:rps/ui/pages/fight_page.dart';
import 'package:rps/ui/widgets/counter_star.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentDifficulty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: TextButton(
                  onPressed: _launchPvC,
                  child: const Text('Player vs Computer'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: TextButton(
                  onPressed: () => _launchCvC(),
                  child: const Text('Computer vs Computer'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Number of victories to win : '),
                      CounterStar(
                        numberOfStars: 5,
                        initialValue: currentDifficulty,
                        onPressed: (id) {
                          currentDifficulty = id;
                        },
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchPvC() => _launchFight(true);

  void _launchCvC() => _launchFight(false);

  void _launchFight(bool isPVC) {
    Navigator.pushNamed(
      context,
      FightPage.routeName,
      arguments: FightArgument(
        isPvCGame: isPVC,
        limitToWin: currentDifficulty,
      ),
    );
  }
}
