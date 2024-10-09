import 'package:drift/drift.dart';

class ResultInstruction extends Table {
  IntColumn get saveId => integer().autoIncrement()();

  TextColumn get id => text()();

  TextColumn get path => text()();

  TextColumn get points => text().withDefault(const Constant('[]'))();
}
