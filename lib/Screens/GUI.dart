// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_glow/flutter_glow.dart';
// import 'package:soundpool/soundpool.dart';
import 'package:xlox/Models/Cell.dart';
import 'package:xlox/Msc/Components.dart';
import 'package:xlox/Msc/Utilites.dart';
import 'package:xlox/Structure.dart';
import 'package:xlox/generated/assets.dart';

import '../Models/Board.dart';
import '../Msc/Levels.dart';

class XLOXGame extends StatefulWidget {
  const XLOXGame({super.key});

  static String id = "UI";

  _XLOXGameState createState() => _XLOXGameState();
}

int movementSound = 0;
int levelUpSound = 0;
int gameWonSound = 0;
// Soundpool pool = Soundpool.fromOptions();

class _XLOXGameState extends State<XLOXGame> with TickerProviderStateMixin {
  late AnimationController animationController;

  int currentLevel = 1;
  int numberOfMoves = 0;

  void initPlayer() async {
    // movementSound =
    //     await rootBundle.load(Assets.soundsMovement).then((ByteData soundData) {
      // return pool.load(soundData);
    // });
    //
    // levelUpSound =
    //     await rootBundle.load(Assets.soundsLevelup).then((ByteData soundData) {
      // return pool.load(soundData);
    // });
    //
    // gameWonSound = await rootBundle
    //     .load(Assets.soundsSolvedAll)
    //     .then((ByteData soundData) {
      // return pool.load(soundData);
    // });
  }

  @override
  void initState() {
    initPlayer();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: popUpMenu(),
        toolbarHeight: 100,
        actions: [
          IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        child: Material(
                          color: Colors.black,
                          child: GridWithNumbers(maxNumber: levels.length),
                        ),
                      );
                    });
                setState(() {
                  for (int i = 0; i < levels.length; i++) {
                    if (areEqual(levels[i], Board.staticBoard)) {
                      currentLevel = i + 1;
                    }
                  }
                });
              },
              icon: Icon(Icons.list)),
        ],
        title: GlowText(
          'XLOX',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 45,
          ),
          blurRadius: 3,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 55.0, left: 5, right: 5),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Board.staticBoard[0].length,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: Board.staticBoard.length *
                          Board.staticBoard[0].length,
                      itemBuilder: (context, index) {
                        int x = index % Board.staticBoard[0].length;
                        int y = index ~/ Board.staticBoard[0].length;
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              if (checkMovePermittivity(
                                  Board.staticBoard[y][x])) {
                                numberOfMoves++;
                                // pool.play(movementSound);
                              }
                              clickedOnCell(y, x);
                            });

                            if (isLevelPassed(Board.staticBoard)) {
                              if (currentLevel < levels.length) {
                                Board.staticBoard =
                                    deepCopy(levels[currentLevel]);
                                currentLevel++;
                                numberOfMoves = 0;
                                // pool.play(levelUpSound);
                                animationController.reset();
                                animationController.forward();
                              } else {
                                // pool.play(gameWonSound);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                        onWillPop: () async {
                                          return false;
                                        },
                                        child: AlertDialog(
                                          backgroundColor: Color(0xff151515)
                                              .withOpacity(0.7),
                                          surfaceTintColor: Colors.black,
                                          elevation: 15,
                                          title: GlowText(
                                            'Well Done !',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 2,
                                              fontSize: 32,
                                            ),
                                            textAlign: TextAlign.center,
                                            blurRadius: 10,
                                          ),
                                          content: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Board.staticBoard =
                                                    deepCopy(levels[0]);
                                                currentLevel = 1;
                                                numberOfMoves = 0;
                                                animationController.reset();
                                                animationController.forward();
                                                Navigator.pop(context);
                                              });
                                            },
                                            icon: GlowIcon(
                                              Icons.restart_alt,
                                              glowColor: Colors.white,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                            splashRadius: 3,
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                              6.0 -
                                  1.5 *
                                      max(Board.staticBoard.length,
                                          Board.staticBoard[0].length) /
                                      5,
                            ),
                            child: Cell(
                              type: Board.staticBoard[y][x],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ).animate(controller: animationController).fadeIn(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GlowText(
                  'Level: ${currentLevel}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  blurRadius: 2,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      Board.staticBoard = deepCopy(levels[currentLevel - 1]);
                      numberOfMoves = 0;
                      animationController.reset();
                      animationController.forward();
                    });
                  },
                  icon: GlowIcon(
                    Icons.restart_alt,
                    glowColor: Colors.white,
                    color: Colors.white,
                    size: 50,
                  ),
                  splashRadius: 3,
                ),
                GlowText(
                  'Moves: $numberOfMoves',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GridWithNumbers extends StatefulWidget {
  final int maxNumber;

  const GridWithNumbers({
    Key? key,
    required this.maxNumber,
  }) : super(key: key);

  @override
  State<GridWithNumbers> createState() => _GridWithNumbersState();
}

class _GridWithNumbersState extends State<GridWithNumbers> {
  List<Widget> _gridItems = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.maxNumber; i++) {
      _gridItems.add(
        Padding(
          padding: EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              setState(() {
                Board.staticBoard = deepCopy(levels[i]);
              });
              Navigator.pop(context);
              setState(() {});
            },
            child: GlowContainer(
              padding: const EdgeInsets.all(8),
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,
              child: Center(
                  child: GlowText(
                (i + 1).toString(),
                style: TextStyle(fontSize: 18),
              )),
            ).animate(delay: Duration(milliseconds: 25 * i)).fadeIn(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: GlowText(
            "Choose a Level",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          height: 300,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: _gridItems,
          ),
        ),
      ],
    );
  }
}
