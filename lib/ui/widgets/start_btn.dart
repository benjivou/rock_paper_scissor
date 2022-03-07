import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  StarButton({
    required this.idButton,
    required this.currentValue,
    Key? key,
    this.btnIcon = Icons.star,
    this.activeColor,
    this.hiddenColor,
    this.onPressed,
  }) : super(key: key);
  int idButton, currentValue;
  IconData btnIcon;
  Color? activeColor, hiddenColor;
  ValueChanged<int>? onPressed;
  @override
  _StarButtonState createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  late Color currentColor;
  @override
  Widget build(BuildContext context) {
    if (widget.currentValue >= widget.idButton) {
      currentColor = widget.activeColor ?? Theme.of(context).primaryColor;
    } else {
      currentColor =
          widget.hiddenColor ?? Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return IconButton(
      icon: Icon(widget.btnIcon, color: currentColor),
      iconSize: 40,
      onPressed: widget.onPressed != null
          ? () => widget.onPressed!(widget.idButton)
          : null,
    );
  }
}
