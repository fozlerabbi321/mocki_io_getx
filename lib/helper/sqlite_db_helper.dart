import 'dart:developer';
import 'dart:io';

import 'package:mystarter/services/api/app_config.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/response/cart_model.dart';

class DatabaseHelper {
  static const _dbName = '$appName.db';
  static const _tableCartName = 'cart';
  static const _dbVersion = 1;

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
    String path = join(directory.path, _dbName);
    var database = await openDatabase(path, version: _dbVersion,
        onCreate: (Database db, int version) async {

      //Cart table
      await db.execute('''
            CREATE TABLE $_tableCartName(
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

  //===
  //=======
  ///=----Start Cart ----=======////
  //Get All all row
  Future<List<CartModel>> getAllCartList() async {
    List<CartModel> _posts = [];
    Database? db = await instance.database;
    var results = await db!.query(_tableCartName);
    for (var element in results) {
      var posts = CartModel.fromJson(element);
      _posts.add(posts);
    }
    return _posts;
  }

  //Insert row
  Future insertCart(CartModel model) async {
    Database? db = await instance.database;
    var result = await db!.insert(
      _tableCartName,
      model.toJson(),
    );
    log('result : $result');
  }

  //Delete row
  Future<int> deleteCart(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_tableCartName,
        where: '${CartColumn.columnId} = ?', whereArgs: [id]);
  }

  //update row
  Future updateCart(int id, int qty) async {
    Database? db = await instance.database;
    Map<String, dynamic> row = {
      CartColumn.columnQty: qty,
    };
    return await db?.update(_tableCartName, row,
        where: '${CartColumn.columnId} = ?', whereArgs: [id]);
  }

  //remove table
  Future<void> emptyShopCart() async {
    Database? db = await instance.database;
    db?.delete(_tableCartName);
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

