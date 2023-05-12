//||||||||||||| EM TESTE  PARA POSSÍVEL FUTURA IMPLEMENTAÇÃO ||||||||||||

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const DATABASE_NAME = "barcode.db";
const TABLE_NAME = "barcode-query-results";
var col_MATERIAL = "material";
var col_NOME = "nome";
var col_CODIGO = "codigo";
var col_SET = "cod_set";

class DatabaseHelper {
  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  Future<Database?> get database async {
    //Se a plataforma for Desktop:
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();

      var databaseFactory = databaseFactoryFfi;
      var databasesPath = await databaseFactory.getDatabasesPath();
      var path = join(databasesPath, "barcode-barcode.db");
      print(databasesPath);

      // Verifica se a database existe
      var exists = await databaseExists(path);

      // Abre a database
      // var db = await databaseFactory.openDatabase(join(dirname(Platform.script.toFilePath()),"assets", "barcode-barcode.db"));
      // print(join(dirname(Platform.script.toFilePath()),"assets", "barcode-barcode.db"));
      // return db;


//       To load the asset database file, you can use the rootBundle.load() method instead of accessing it directly. Here's an example:

// dart
// Copy code
// ByteData data = await rootBundle.load("assets/barcode-barcode.db");
// List<int> bytes =
//     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// // Write and flush the bytes written
// await File(path).writeAsBytes(bytes, flush: true);
      Database db;
      if (exists) {
        db = await databaseFactory.openDatabase(path);
        return db;
      } else {
        throw Exception("Database file not found");
      }
    }

    //Se a plataforma for Mobile:
    if (Platform.isAndroid || Platform.isIOS) {
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, "barcode.db");
      print(databasesPath);

      // Verifica se a database existe
      var exists = await databaseExists(path);

      if (!exists) {
        print("Creating new copy from asset");
        // Verificando se o diretório existe
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        ByteData data =
            await rootBundle.load(join("assets", "barcode-barcode.db"));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Write and flush the bytes written
        await File(path).writeAsBytes(bytes, flush: true);
      } else {
        print("Opening existing database");
        print("From mobile");
      }

// open the database
      var db = await openDatabase(path, readOnly: false);
      return db;
    }
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(TABLE_NAME, row);
  }

  Future<bool?> read() async {
    Database? db = await instance.database;
    return await db?.isOpen;
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(TABLE_NAME);
  }

  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int?> queryRowCount(String codigo) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) FROM "$TABLE_NAME" where "$col_CODIGO" = "${codigo.trim()}" or "$col_MATERIAL" = "${codigo.trim()}"'));
  }
}
