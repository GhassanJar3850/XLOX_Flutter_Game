// import 'dart:convert';

// List<List<int>> convertToListOfListInt(List<dynamic> list) {
//   List<List<int>> convertedList = [];
//
//   for (dynamic item in list) {
//     if (item is List) {
//       convertedList.add(List<int>.from(item));
//     } else {
//       convertedList.add([item as int]);
//     }
//   }
//   return convertedList;
// }
//
// List<List<int>> deepCopy(List<List<int>> toCopy) {
//   var json = jsonEncode(toCopy);
//   return convertToListOfListInt(jsonDecode(json));
// }

List<List<int>> deepCopy(List<List<int>> toCopy) {
  final List<List<int>> copy = [];

  for (final list in toCopy) {
    copy.add(List<int>.from(list));
  }

  return copy;
}
