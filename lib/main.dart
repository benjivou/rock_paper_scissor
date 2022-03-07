import 'package:flutter/material.dart';
import 'package:rps/model/fight_argument.dart';
import 'package:rps/ui/pages/fight_page.dart';
import 'package:rps/ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPS',
      onGenerateRoute: (RouteSettings settings) {
        final routes = <String, WidgetBuilder>{
          HomePage.routeName: (context) => const HomePage(),
          FightPage.routeName: (context) => FightPage(
                args: settings.arguments as FightArgument,
              ),
        };
        final builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
      theme: ThemeData(
        fontFamily: 'hibo',
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
