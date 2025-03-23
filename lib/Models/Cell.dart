import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../Msc/Constants.dart';

class Cell extends StatefulWidget {
  const Cell({Key? key, required this.type}) : super(key: key);
  final int type;

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return cellDesign[widget.type]!;
  }
}

Map<int, Widget> cellDesign = {
  -1: Container(),
  0: rockCell(),
  1: darkCell(),
  2: litCell(),
};

Widget rockCell() {
  return Material(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kCornerRoundness),
      side: BorderSide(
        color: Colors.grey.withOpacity(0.3),
        width: 3,
      ),
    ),
    color: Colors.transparent,
    shadowColor: Colors.grey,
  );
}

Widget litCell() {
  Color glowColor = Colors.white.withOpacity(0.7);
  return GlowContainer(
    glowColor: glowColor,
    spreadRadius: 2,
    blurRadius: 7,
    color: glowColor,
    borderRadius: BorderRadius.circular(kCornerRoundness),
  );
}

Widget darkCell() {
  return GlowContainer(
    borderRadius: BorderRadius.circular(kCornerRoundness),
    child: Material(
      borderRadius: BorderRadius.circular(kCornerRoundness),
      color: Colors.blueGrey.withOpacity(0.3),
      elevation: 4,
      shadowColor: Colors.grey,
    ),
  );
}
