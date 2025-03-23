import 'package:xlox/Models/Movement.dart';
import 'package:xlox/Msc/Utilites.dart';

import 'Models/Board.dart';

// Checks
bool checkMovePermittivity(int type) {
  if (type == 2) {
    return true;
  }
  return false;
}

bool isLevelPassed(List<List<int>> board) {
  for (int y = 0; y < board[0].length; y++) {
    for (int x = 0; x < board.length; x++) {
      if (board[x][y] == 2) {
        return false;
      }
    }
  }
  return true;
}

bool areEqual(List<List<int>> b1, List<List<int>> b2) {

  if (b1.length != b2.length || b1[0].length != b2[0].length) {
    return false;
  }

  for (int i = 0; i < b1.length; i++) {
    for (int j = 0; j < b1[0].length; j++) {
      if (b1[i][j] != b2[i][j]) {
        return false;
      }
    }
  }

  return true;
}

bool boardsAreEqual(Board b1, Board b2) {
  return b1 == b2;
}

// UserPlay Actions
void clickedOnCell(x, y) {
  if (checkMovePermittivity(Board.staticBoard[x][y])) {
    Board.staticBoard[x][y] = 1;

    // UP
    if (x - 1 >= 0) {
      switch (Board.staticBoard[x - 1][y]) {
        case 1:
          Board.staticBoard[x - 1][y] = 2;
          break;
        case 2:
          Board.staticBoard[x - 1][y] = 1;
          break;
        case -1:
          Board.staticBoard[x - 1][y] = -1;
        case 0:
          Board.staticBoard[x - 1][y] = 0;
          break;
      }
    }

    // DOWN
    if (x + 1 < Board.staticBoard.length) {
      switch (Board.staticBoard[x + 1][y]) {
        case 1:
          Board.staticBoard[x + 1][y] = 2;
          break;
        case 2:
          Board.staticBoard[x + 1][y] = 1;
          break;
        case -1:
          Board.staticBoard[x + 1][y] = -1;
        default:
          Board.staticBoard[x + 1][y] = 0;
          break;
      }
    }

    // LEFT
    if (y - 1 >= 0) {
      switch (Board.staticBoard[x][y - 1]) {
        case 1:
          Board.staticBoard[x][y - 1] = 2;
          break;
        case 2:
          Board.staticBoard[x][y - 1] = 1;
          break;
        case -1:
          Board.staticBoard[x][y - 1] = -1;
        default:
          Board.staticBoard[x][y - 1] = 0;
          break;
      }
    }

    // RIGHT
    if (y + 1 < Board.staticBoard[0].length) {
      switch (Board.staticBoard[x][y + 1]) {
        case 1:
          Board.staticBoard[x][y + 1] = 2;
          break;
        case 2:
          Board.staticBoard[x][y + 1] = 1;
          break;
        case -1:
          Board.staticBoard[x][y + 1] = -1;
        default:
          Board.staticBoard[x][y + 1] = 0;
          break;
      }
    }
  }
}

// Actions

// the number of white cells in the board
int heuristicHC(List<List<int>> board) {
  int number = 0;
  for (int y = 0; y < board[0].length; y++) {
    for (int x = 0; x < board.length; x++) {
      if (board[x][y] == 2) {
        number++;
      }
    }
  }
  return number;
}

List<List<int>> clickedOnCellCopy(List<List<int>> boardCopy, x, y) {
  boardCopy[x][y] = 1;

  // UP
  if (x - 1 >= 0) {
    switch (boardCopy[x - 1][y]) {
      case 1:
        boardCopy[x - 1][y] = 2;
        break;
      case 2:
        boardCopy[x - 1][y] = 1;
        break;
      case 0:
        boardCopy[x - 1][y] = 0;
        break;
    }
  }

  // DOWN
  if (x + 1 < Board.staticBoard.length) {
    switch (boardCopy[x + 1][y]) {
      case 1:
        boardCopy[x + 1][y] = 2;
        break;
      case 2:
        boardCopy[x + 1][y] = 1;
        break;
      default:
        boardCopy[x + 1][y] = 0;
        break;
    }
  }

  // LEFT
  if (y - 1 >= 0) {
    switch (boardCopy[x][y - 1]) {
      case 1:
        boardCopy[x][y - 1] = 2;
        break;
      case 2:
        boardCopy[x][y - 1] = 1;
        break;
      default:
        boardCopy[x][y - 1] = 0;
        break;
    }
  }

  // RIGHT
  if (y + 1 < Board.staticBoard[0].length) {
    switch (boardCopy[x][y + 1]) {
      case 1:
        boardCopy[x][y + 1] = 2;
        break;
      case 2:
        boardCopy[x][y + 1] = 1;
        break;
      default:
        boardCopy[x][y + 1] = 0;
        break;
    }
  }

  return boardCopy;
}

List<Movement> getAvailableMoves(List<List<int>> board) {
  List<Movement> availableMoves = [];
  for (int y = 0; y < board[0].length; y++) {
    for (int x = 0; x < board.length; x++) {
      if (board[x][y] == 2) {
        availableMoves.add(Movement(x, y));
      }
    }
  }
  return availableMoves;
}

List<Board> getNextStates(List<List<int>> currentState, [int cost = 0]) {
  List<Board> possibleOutcomes = [];
  Board currentBoard = Board(deepCopy(currentState));

  List<Movement> availableMoves = getAvailableMoves(currentBoard.state);
  for (int i = 0; i < availableMoves.length; i++) {
    Board outcome = Board(clickedOnCellCopy(deepCopy(currentBoard.state),
        availableMoves[i].x, availableMoves[i].y));

    outcome.cost = cost + 1;
    possibleOutcomes.add(outcome);
  }
  return possibleOutcomes;
}

void printState(Board state) {
  print("-----------------------");
  for (int i = 0; i < state.state.length; i++) {
    print(state.state[i]);
  }
  print("-----------------------\n\n");
}
