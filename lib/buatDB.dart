import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> bukaDataBase() async {
  final pathDB = await getDatabasesPath();
  final path = join(pathDB, 'databaseUtama.db');
  final database =
      await openDatabase(path, version: 1, onCreate: (db, version) {});
  return database;
}
