// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:xlox/Logic.dart';
import 'package:xlox/Msc/Levels.dart';

import '../Models/Board.dart';
import '../Structure.dart';

enum DropMenuItems { getNextStates, applyBFS, applyDFS, applyUCS, applyAStar }

// Temporarily
Widget popUpMenu() {
  return PopupMenuButton(
    offset: Offset(0, 65),
    surfaceTintColor: Colors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    initialValue: DropMenuItems.getNextStates,
    onSelected: (DropMenuItems item) {},
    itemBuilder: (BuildContext context) => <PopupMenuEntry<DropMenuItems>>[
      PopupMenuItem<DropMenuItems>(
        padding: EdgeInsets.symmetric(horizontal: 6),
        value: DropMenuItems.getNextStates,
        onTap: () {
          DFS(Board(Board.staticBoard));
        },
        child: Center(
          child: GlowText(
            'Apply DFS',
            style: TextStyle(fontWeight: FontWeight.w800),
            blurRadius: 4,
          ),
        ),
      ),
      PopupMenuItem<DropMenuItems>(
        padding: EdgeInsets.symmetric(horizontal: 6),
        value: DropMenuItems.getNextStates,
        onTap: () {
          BFS(Board(Board.staticBoard));
        },
        child: Center(
          child: GlowText(
            'Apply BFS',
            style: TextStyle(fontWeight: FontWeight.w800),
            blurRadius: 4,
          ),
        ),
      ),
      PopupMenuItem<DropMenuItems>(
        padding: EdgeInsets.symmetric(horizontal: 6),
        value: DropMenuItems.getNextStates,
        onTap: () {
          UCS(Board(Board.staticBoard));
        },
        child: Center(
          child: GlowText(
            'Apply UCS',
            style: TextStyle(fontWeight: FontWeight.w800),
            blurRadius: 4,
          ),
        ),
      ),
      PopupMenuItem<DropMenuItems>(
        padding: EdgeInsets.symmetric(horizontal: 6),
        value: DropMenuItems.getNextStates,
        onTap: () {
          HillClimbing(Board(Board.staticBoard));
        },
        child: Center(
          child: GlowText(
            'Apply HC',
            style: TextStyle(fontWeight: FontWeight.w800),
            blurRadius: 4,
          ),
        ),
      ),
      PopupMenuItem<DropMenuItems>(
        padding: EdgeInsets.symmetric(horizontal: 6),
        value: DropMenuItems.getNextStates,
        onTap: () {
          A_STAR(Board(Board.staticBoard));
        },
        child: Center(
          child: GlowText(
            'Apply A*',
            style: TextStyle(fontWeight: FontWeight.w800),
            blurRadius: 4,
          ),
        ),
      ),
      PopupMenuItem<DropMenuItems>(
        padding: EdgeInsets.symmetric(horizontal: 6),
        value: DropMenuItems.getNextStates,
        onTap: () {
          print(boardsAreEqual(Board(levels[0]), Board(levels[0])));
        },
        child: Center(
          child: GlowText(
            'Test',
            style: TextStyle(fontWeight: FontWeight.w800),
            blurRadius: 4,
          ),
        ),
      ),
    ],
  );
}
