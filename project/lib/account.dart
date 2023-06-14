import 'package:drift/drift.dart';

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get content => text()();
  IntColumn get price => integer()();
  DateTimeColumn get date => dateTime()();
}