import 'package:contact_list_app/models/contacts.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String contactTable = 'user_contact_table';
  String colId = 'id';
  String colFirstName = 'firstName';
  String colLastName = 'lastName';
  String colPhNumber = 'phNumber';
  String colAddress = 'address';
  String colCity = 'city';
  String colPincode = 'pincode';
  String colGender = 'gender';
  String colLanguagesKnown = 'languagesKnown';
  String colDate = 'date';
  //contact Tables
  //Id | FirstName | LastName | phNumber | Address | City | Pincode | Gender | LanguagesKnown | Date
  // 0   ''           ''           ''           ''         0   ''
  // 0   ''           ''           ''           ''         0   ''
  // 0   ''           ''           ''           ''         0   ''
  // 0   ''           ''           ''           ''         0   ''

  //Getter for db object
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'contact_list_x.db';
    final todoListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    String createStatement =
        'CREATE TABLE $contactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT , $colFirstName TEXT , $colLastName TEXT , $colPhNumber TEXT,$colAddress TEXT,$colCity TEXT, $colPincode INTEGER, $colGender TEXT, $colLanguagesKnown TEXT,$colDate TEXT)';
    await db.execute(createStatement);
  }

  Future<List<Map<String, dynamic>>> getcontactMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> dbResult = await db.query(contactTable);
    return dbResult;
  }

  Future<List<Contact>> getcontactList() async {
    final List<Map<String, dynamic>> contactMapList = await getcontactMapList();
    final List<Contact> contactList = [];
    contactMapList.forEach((contactMap) {
      contactList.add(Contact.fromMap(contactMap));
    });
    return contactList;
  }

  Future<int> insertcontact(Contact contact) async {
    Database db = await this.db;
    final int result = await db.insert(contactTable, contact.toMap());
    return result;
  }

  Future<int> updatecontact(Contact contact) async {
    Database db = await this.db;
    final int result = await db.update(contactTable, contact.toMap(),
        where: '$colId = ?', whereArgs: [contact.id]);
    return result;
  }

  Future<int> deletecontact(int id) async {
    Database db = await this.db;
    return await db.delete(contactTable, where: '$colId = ?', whereArgs: [id]);
  }
}
