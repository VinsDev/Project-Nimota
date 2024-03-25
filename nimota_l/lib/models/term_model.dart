import 'package:hive_flutter/hive_flutter.dart';

import 'student_model.dart';

part 'term_model.g.dart';

@HiveType(typeId: 1)
class TermClass {
  @HiveField(0)
  String termName;
  @HiveField(1)
  List<Student> students = [];
  @HiveField(2)
  List<String> subjects = [];
  @HiveField(3)
  String nextTermBegins = "";
  @HiveField(4)
  String termEnds = "";
  @HiveField(5)
  String nextTermFees = "";
  @HiveField(6)
  String averageAge = "";
  TermClass(this.termName);
}
