import 'package:xlox/Msc/Levels.dart';
import 'package:xlox/Msc/Utilites.dart';

class Board {
  static List<List<int>> staticBoard = deepCopy(levels[0]);

  List<List<int>> state;
  Board? parent;
  int cost = 0;

  Board(this.state);

  @override
  int get hashCode => hashList(state);

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}

int hashList(List<List<int>> list) {
  String string = list.join();
  return string.hashCode;
}
