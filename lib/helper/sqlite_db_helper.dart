import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/strings.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initiateDatabase();
    return _database;
  }

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    var database = await openDatabase(path, version: dbVersion,
        onCreate: (Database db, int version) async {

      //Cart table
      await db.execute('''
            CREATE TABLE $tableCartName(
            ${CartColumn.columnId} INTEGER,
            ${CartColumn.columnQty} INTEGER,
            ${CartColumn.columnPrice} INTEGER,
            ${CartColumn.columnImage} TEXT,
            ${CartColumn.columnTitle} TEXT,
            ${CartColumn.columnVariation} INTEGER,
            ${CartColumn.columnBrand} TEXT,
            ${CartColumn.columnSize} TEXT,
            ${CartColumn.columnColor} TEXT,
            ${CartColumn.columnBarcode} TEXT,
            ${CartColumn.columnStockQty} INTEGER,
            ${CartColumn.products} TEXT
            
            )
            
        ''');
    });
    return database;
  }
  ///=----End Cart ----=======////
}

class CartColumn {
  static const columnId = 'id';
  static const columnPrice = 'price';
  static const columnQty = 'quantity';
  static const columnImage = 'image';
  static const columnTitle = 'title';
  static const columnVariation = 'product_variant_id';
  static const columnSize = 'size';
  static const columnColor = 'color';
  static const columnBrand = 'brand';
  static const columnBarcode = 'barcode';
  static const columnStockQty = 'stockQty';
  static const products = 'products';
}

