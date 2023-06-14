import 'package:drift/drift.dart';
import 'package:account_book/account.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Account,
  ],
)

class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());
  Stream<List<AccountData>> watchAccount(DateTime date) =>
      (select(account)..where((tbl) => tbl.date.equals(date))).watch();

  Future<int> createAccount(AccountCompanion data) =>
      into(account).insert(data);

  Future<int> removeAccount(int id) =>
      (delete(account)..where((tbl) => tbl.id.equals(id))).go();

  Stream<List<AccountData>> watchMAccount(DateTime date) =>
      (select(account)..where((tbl) =>
      tbl.date.year.equals(date.year) & tbl.date.month.equals(date.month))).watch();

  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}