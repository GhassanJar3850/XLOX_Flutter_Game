import 'Models/Board.dart';
import 'Msc/Data Structures.dart';
import 'Structure.dart';

// Depth First
bool DFS(Board board) {
  final frontier = Stack<Board>();
  Set<int> visited = <int>{};
  var generatedNodes = 1;
  var maxDepth = 0;
  final executionTime = Stopwatch()..start();

  frontier.push(board);

  while (frontier.isNotEmpty) {
    final currentState = frontier.pop();

    if (visited.contains(currentState.hashCode)) {
      continue;
    }

    visited.add(currentState.hashCode);

    if (isLevelPassed(currentState.state)) {
      int costOfPath = 0;
      List<Board> path = [];
      Board? current = currentState;
      while (current != null) {
        costOfPath += current.cost;
        path.add(current);
        current = current.parent;
      }
      for (int i = path.length - 2; i >= 0; i--) {
        printState(path[i]);
      }
      print("#~- DFS -~#");
      print("Number of generated nodes: $generatedNodes");

      print("Number of visited nodes: ${visited.length - 1}");
      print("The Cost of the path: $costOfPath");
      print("depth: ${path.length - 1}");
      print("max Depth $maxDepth");
      print("Execution Time is: ${executionTime.elapsed}");
      executionTime.stop();

      return true;
    }

    List<Board> allMoves = getNextStates(currentState.state, currentState.cost);
    for (final move in allMoves) {
      if (move.cost > maxDepth) {
        maxDepth = move.cost;
      }
      if (!visited.contains(move.hashCode)) {
        generatedNodes++;
        move.parent = currentState;
        frontier.push(move);
      }
    }
  }

  return false;
}

// Breadth First
bool BFS(Board board) {
  final Queue<Board> frontier = Queue<Board>();
  Set<int> visited = <int>{};
  var generatedNodes = 1;
  var maxDepth = 0;
  final executionTime = Stopwatch()..start();

  frontier.enqueue(board);

  while (frontier.isNotEmpty()) {
    final currentState = frontier.dequeue();

    if (visited.contains(currentState.hashCode)) {
      continue;
    }

    visited.add(currentState.hashCode);

    if (isLevelPassed(currentState.state)) {
      int costOfPath = 0;
      List<Board> path = [];
      Board? current = currentState;
      while (current != null) {
        costOfPath += current.cost;
        path.add(current);
        current = current.parent;
      }
      for (int i = path.length - 2; i >= 0; i--) {
        printState(path[i]);
      }

      print("#~- BFS -~#");
      print("Number of generated nodes: $generatedNodes");

      print("Number of visited nodes: ${visited.length - 1}");
      print("The Cost of the path: $costOfPath");
      print("depth: ${path.length - 1}");
      print("max Depth $maxDepth");
      print("Execution Time is: ${executionTime.elapsed}");
      executionTime.stop();

      return true;
    }
    List<Board> allMoves = getNextStates(currentState.state, currentState.cost);

    for (final move in allMoves) {
      if (move.cost > maxDepth) {
        maxDepth = move.cost;
      }
      if (!visited.contains(move.hashCode)) {
        generatedNodes++;
        move.parent = currentState;
        frontier.enqueue(move);
      }
    }
  }

  return false;
}

// Uniform Cost (here the priority is the cost that is equal to the depth)
bool UCS(Board board) {
  final PriorityQueue<Board> frontier = PriorityQueue<Board>();
  Set<Board> visited = <Board>{};
  var generatedNodes = 1;
  var maxDepth = 0;
  final executionTime = Stopwatch()..start();

  frontier.enqueue(board, board.cost);

  while (!frontier.isEmpty) {
    final currentState = frontier.dequeue();

    bool skip = false;
    visited.forEach((element) {
      if (areEqual(currentState.state, element.state)) {
        skip = true;
      }
    });

    if (skip) {
      continue;
    }

    visited.add(currentState);

    if (isLevelPassed(currentState.state)) {
      int costOfPath = 0;
      List<Board> path = [];
      Board? current = currentState;
      while (current != null) {
        costOfPath += current.cost;
        path.add(current);
        current = current.parent;
      }
      for (int i = path.length - 2; i >= 0; i--) {
        printState(path[i]);
      }

      print("#~- Uniform Cost Search -~#");
      print("Number of generated nodes: $generatedNodes");
      print("Number of visited nodes: ${visited.length - 1}");
      print("The Cost of the path: $costOfPath");
      print("Solution depth: ${path.length - 1}");
      print("max Depth $maxDepth");
      print("Execution Time is: ${executionTime.elapsed}");
      executionTime.stop();

      return true;
    }

    List<Board> allMoves = getNextStates(currentState.state, currentState.cost);
    for (final move in allMoves) {
      bool uniqueMove = true;
      Board? boardToReplace;

      if (move.cost > maxDepth) {
        maxDepth = move.cost;
      }
      visited.forEach((element) {
        if (areEqual(element.state, move.state)) {
          uniqueMove = false;
          boardToReplace = element;
        }
      });

      if (uniqueMove) {
        generatedNodes++;
        move.parent = currentState;
        frontier.enqueue(move, move.cost);
      } else {
        // replace the move with the visited one if the cost is less
        if (move.cost < boardToReplace!.cost) {
          frontier.replace(boardToReplace!, move, move.cost);
        }
      }
    }
  }
  return false;
}

// (the priority is the heuristic (approximation function) which is the number of white cells in the board)
bool HillClimbing(Board board) {
  final PriorityQueue<Board> frontier = PriorityQueue<Board>();
  Set<Board> visited = <Board>{};
  var generatedNodes = 1;
  var maxDepth = 0;
  final executionTime = Stopwatch()..start();

  frontier.enqueue(board, heuristicHC(board.state));

  while (!frontier.isEmpty) {
    final currentState = frontier.dequeue();

    bool skip = false;
    visited.forEach((element) {
      if (areEqual(currentState.state, element.state)) {
        skip = true;
      }
    });

    if (skip) {
      continue;
    }

    visited.add(currentState);

    if (isLevelPassed(currentState.state)) {
      int costOfPath = 0;
      List<Board> path = [];
      Board? current = currentState;
      while (current != null) {
        costOfPath += current.cost;
        path.add(current);
        current = current.parent;
      }
      for (int i = path.length - 2; i >= 0; i--) {
        printState(path[i]);
      }

      print("#~- Hill Climbing -~#");
      print("Number of generated nodes: $generatedNodes");
      print("Number of visited nodes: ${visited.length - 1}");
      print("The Cost of the path: $costOfPath");
      print("Solution depth: ${path.length - 1}");
      print("max Depth $maxDepth");
      print("Execution Time is: ${executionTime.elapsed}");
      executionTime.stop();

      return true;
    }

    List<Board> allMoves = getNextStates(currentState.state, currentState.cost);
    for (final move in allMoves) {
      bool uniqueMove = true;
      Board? boardToReplace;

      if (move.cost > maxDepth) {
        maxDepth = move.cost;
      }
      visited.forEach((element) {
        if (areEqual(element.state, move.state)) {
          uniqueMove = false;
          boardToReplace = element;
        }
      });

      if (uniqueMove) {
        generatedNodes++;
        move.parent = currentState;
        frontier.enqueue(move, heuristicHC(move.state));
      } else {
        // replace the move with the visited one if the cost is less
        if (heuristicHC(move.state) < heuristicHC(boardToReplace!.state)) {
          frontier.replace(boardToReplace!, move, heuristicHC(move.state));
        }
      }
    }
  }
  return false;
}

// The priority here is the previous heuristic added with the cost
// f(n) = c(n) + h(n) ; n := node

bool A_STAR(Board board) {
  final PriorityQueue<Board> frontier = PriorityQueue<Board>();
  Set<Board> visited = <Board>{};

  var generatedNodes = 1;
  var maxDepth = 0;
  final executionTime = Stopwatch()..start();

  frontier.enqueue(board, heuristicHC(board.state) + board.cost);

  while (!frontier.isEmpty) {
    final currentState = frontier.dequeue();

    bool skip = false;
    visited.forEach((element) {
      if (areEqual(currentState.state, element.state)) {
        skip = true;
      }
    });

    if (skip) {
      continue;
    }

    visited.add(currentState);
    if (isLevelPassed(currentState.state)) {
      int costOfPath = 0;
      List<Board> path = [];
      Board? current = currentState;
      while (current != null) {
        costOfPath += current.cost;
        path.add(current);
        current = current.parent;
      }
      for (int i = path.length - 2; i >= 0; i--) {
        printState(path[i]);
      }

      print("#~- A* -~#");
      print("Number of generated nodes: $generatedNodes");
      print("Number of visited nodes: ${visited.length - 1}");
      print("The Cost of the path: $costOfPath");
      print("Solution depth: ${path.length - 1}");
      print("max Depth $maxDepth");
      print("Execution Time is: ${executionTime.elapsed}");
      executionTime.stop();

      return true;
    }

    List<Board> allMoves = getNextStates(currentState.state, currentState.cost);
    for (final move in allMoves) {
      bool uniqueMove = true;
      Board? boardToReplace;

      if (move.cost > maxDepth) {
        maxDepth = move.cost;
      }
      visited.forEach((element) {
        if (areEqual(element.state, move.state)) {
          uniqueMove = false;
          boardToReplace = element;
        }
      });

      if (uniqueMove) {
        generatedNodes++;
        move.parent = currentState;
        frontier.enqueue(move, heuristicHC(move.state) + move.cost);
      } else {
        // replace the move with the visited one if the cost is less
        if (heuristicHC(move.state) + move.cost <
            heuristicHC(boardToReplace!.state) + boardToReplace!.cost) {
          frontier.replace(
              boardToReplace!, move, heuristicHC(move.state) + move.cost);
        }
      }
    }
  }
  return false;
}

/* Previous DFS */
// bool DFS(Board board) {
//   final frontier = Stack<Board>();
//   Set<int> visited = <int>{};
//
//   frontier.push(board);
//
//   while (frontier.isNotEmpty) {
//     final currentState = frontier.pop();
//     visited.add(currentState.hashCode);
//     if (isLevelPassed(currentState.state)) {
//       int costOfPath = 0;
//       List<Board> path = [];
//       Board? current = currentState;
//       while (current != null) {
//         costOfPath += current.cost;
//         path.add(current);
//         current = current.parent;
//       }
//       for (int i = path.length - 2; i >= 0; i--) {
//         printState(path[i]);
//       }
//       print("#~- DFS -~#");
//       print("Number of visited nodes: ${visited.length - 1}");
//       print("The Cost of the path: $costOfPath");
//       print("depth: ${path.length - 1}");
//
//       return true;
//     }
//     List<Board> allMoves = getNextStates(currentState.state, currentState.cost);
//     for (final move in allMoves) {
//       move.parent = currentState;
//       if (!visited.contains(move.hashCode)) {
//         frontier.push(move);
//       }
//     }
//   }
//
//   return false;
// }

/* Previous BFS */
// bool BFS(Board board) {
//   final Queue<Board> frontier = Queue<Board>();
//   Set<int> visited = <int>{};
//
//   frontier.enqueue(board);
//   while (frontier.isNotEmpty()) {
//     final currentState = frontier.dequeue();
//     visited.add(currentState.hashCode);
//
//     if (isLevelPassed(currentState.state)) {
//       int costOfPath = 0;
//       List<Board> path = [];
//       Board? current = currentState;
//       while (current != null) {
//         costOfPath += current.cost;
//         path.add(current);
//         current = current.parent;
//       }
//       for (int i = path.length - 2; i >= 0; i--) {
//         printState(path[i]);
//       }
//
//       print("#~- BFS -~#");
//       print("Number of visited nodes: ${visited.length - 1}");
//       print("The Cost of the path: $costOfPath");
//       print("depth: ${path.length - 1}");
//
//       return true;
//     }
//
//     List<Board> allMoves = getNextStates(currentState.state, currentState.cost);
//     for (final move in allMoves) {
//       move.parent = currentState;
//       if (!visited.contains(move.hashCode)) {
//         frontier.enqueue(move);
//       }
//     }
//   }
//   return false;
// }

/* Previous UCS */
// bool UCS(Board board) {
//   final PriorityQueue<Board> frontier = PriorityQueue<Board>();
//   Set<int> visited = <int>{};
//   frontier.enqueue(board, board.cost);
//
//   while (!frontier.isEmpty) {
//     final currentState = frontier.dequeue();
//     visited.add(currentState.hashCode);
//
//     if (isLevelPassed(currentState.state)) {
//       int costOfPath = 0;
//       List<Board> path = [];
//       Board? current = currentState;
//       while (current != null) {
//         costOfPath += current.cost;
//         path.add(current);
//         current = current.parent;
//       }
//       for (int i = path.length - 2; i >= 0; i--) {
//         printState(path[i]);
//       }
//       print("#~- UCS -~#");
//       print("Number of visited nodes: ${visited.length - 1}");
//       print("The Cost of the path: $costOfPath");
//       print("depth: ${path.length - 1}");
//
//       return true;
//     }
//
//     List<Board> allMoves = getNextStates(currentState.state, currentState.cost);
//     for (final move in allMoves) {
//       move.parent = currentState;
//       if (!visited.contains(move.hashCode)) {
//         frontier.enqueue(move, move.cost);
//       }
//     }
//   }
//   return false;
// }
