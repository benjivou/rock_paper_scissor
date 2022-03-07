mixin GameLogic<T> {
  String get p1Name;
  String get p2Name;
  Function(int) get onUser1WinRound;
  Function(int) get onUser2WinRound;
  Function(
    String,
    String,
  ) get onEndTurn;
  Function(String) get onWin;
  void calculRound(T user1Inputs, T user2Inputs);
}
