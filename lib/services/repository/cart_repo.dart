import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../../constants/strings.dart';
import '../../helper/sqlite_db_helper.dart';
import '../../models/response/cart_model.dart';


class CartRepo {
  final DatabaseHelper databaseHelper;

  CartRepo({required this.databaseHelper,});


  //Get All all row
  Future<List<CartModel>> getAllCartList() async {
    List<CartModel> _posts = [];
    Database? db = await databaseHelper.database;
    var results = await db!.query(tableCartName);
    for (var element in results) {
      var posts = CartModel.fromJson(element);
      _posts.add(posts);
    }
    return _posts;
  }

  //Insert row
  Future insertCart(CartModel model) async {
    Database? db = await databaseHelper.database;
    var result = await db!.insert(
      tableCartName,
      model.toJson(),
    );
    log('result : $result');
  }

  //Delete row
  Future<int> deleteCart(int id) async {
    Database? db = await databaseHelper.database;
    return await db!.delete(tableCartName,
        where: '${CartColumn.columnId} = ?', whereArgs: [id]);
  }

  //update row
  Future updateCart(int id, int qty) async {
    Database? db = await databaseHelper.database;
    Map<String, dynamic> row = {
      CartColumn.columnQty: qty,
    };
    return await db?.update(tableCartName, row,
        where: '${CartColumn.columnId} = ?', whereArgs: [id]);
  }

  //remove table
  Future<void> emptyShopCart() async {
    Database? db = await databaseHelper.database;
    db?.delete(tableCartName);
  }

}
