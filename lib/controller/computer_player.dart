import 'dart:math';

/// This class represent a computer player
///
/// You pass it the list of [values] and when it's his round
///
/// you use [playARound] to get it moves for the round
class ComputerPlayer<T> {
  final List<T> values;
  final random = Random();
  ComputerPlayer(this.values);

  T playARound() {
    return values[random.nextInt(values.length)];
  }
}
