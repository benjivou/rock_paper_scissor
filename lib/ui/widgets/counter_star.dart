import 'package:flutter/material.dart';
import 'package:rps/ui/widgets/start_btn.dart';

/// This a counter, each starts represent 1 level.
///
/// If you add an [onPressed] use when the user press a star.
/// The value passed in parameter is the position of the star (1 to N).
///
/// [initialValue] is the intial value show in the counter.
///
/// [numberOfStars] is the number of elements show in the counter.
///
class CounterStar extends StatefulWidget {
  CounterStar({
    required this.numberOfStars,
    this.initialValue = 0,
    this.onPressed,
    Key? key,
  }) : super(key: key);
  int numberOfStars, initialValue;
  ValueChanged<int>? onPressed;
  @override
  _CounterStarState createState() => _CounterStarState();
}

class _CounterStarState extends State<CounterStar> {
  @override
  Widget build(BuildContext context) {
    final counter = <StarButton>[];
    for (var i = 1; i <= widget.numberOfStars; i++) {
      counter.add(
        StarButton(
          idButton: i,
          currentValue: widget.initialValue,
          onPressed: (widget.onPressed != null)
              ? (id) => setState(
                    () {
                      widget.initialValue = id;
                      widget.onPressed!(id);
                    },
                  )
              : null,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: counter,
    );
  }
}
