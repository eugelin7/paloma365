import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static const _databaseName = "paloma365.db";

  // make this a singleton class
  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  static bool _isInitialized = false;

  Database get database {
    if (!_isInitialized) throw Exception('Database is not initialized');
    return _database!;
  }

  // init function must be called before any other action
  Future<void> init() async {
    if (_isInitialized) return;
    await _initDatabase();
    _isInitialized = true;
  }

  //------------------------------------------------------------
  // this opens the database (or creates it if it doesn't exist)
  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE Groups (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL
            )
          ''');
      await db.execute('''
          INSERT INTO Groups (id, name) values
            (1, 'Горячее'),
            (2, 'Вторые блюда'),
            (3, 'Салаты'),
            (4, 'Напитки')
          ''');
      await db.execute('''
          CREATE TABLE Products (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            groupId INTEGER NOT NULL,
            FOREIGN KEY (groupId) REFERENCES Groups(id)
            )
          ''');
      await db.execute('''
          INSERT INTO Products (groupId, id, name) values
            (1, 1, 'Борщ'),
            (1, 2, 'Гороховый суп'),
            (1, 3, 'Рассольник'),
            (1, 4, 'Вермишелевый суп'),
            (2, 5, 'Картошка-пюре с котлетой'),
            (2, 6, 'Фасоль с грибами'),
            (2, 7, 'Макароны с сыром'),
            (2, 8, 'Омлет с ветчиной'),
            (2, 9, 'Капуста с сардельками'),
            (3, 10, 'Оливье'),
            (3, 11, 'Винегрет'),
            (3, 12, 'Овощной'),
            (4, 13, 'Чай'),
            (4, 14, 'Кофе'),
            (4, 15, 'Какао'),
            (4, 16, 'Водка'),
            (4, 17, 'Коньяк'),
            (4, 18, 'Вино'),
            (4, 19, 'Пиво')
          ''');
      await db.execute('''
          CREATE TABLE Places (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL
            )
          ''');
      await db.execute('''
          INSERT INTO Places (id, name) values
            (1, 'Стол №1'),
            (2, 'Стол №2'),
            (3, 'Стол №3'),
            (4, 'VIP-Стол 1'),
            (5, 'VIP-Стол 2')
          ''');
      await db.execute('''
          CREATE TABLE Orders (
            id INTEGER PRIMARY KEY,
            isActive INTEGER DEFAULT 1 NOT NULL,
            placeId INTEGER NOT NULL,
            FOREIGN KEY (placeId) REFERENCES Places(id)
            )
          ''');
      await db.execute('''
          CREATE TABLE OrderDetails (
            orderId INTEGER NOT NULL,
            productId INTEGER NOT NULL,
            amount INTEGER NOT NULL,
            PRIMARY KEY (orderId, productId),
            FOREIGN KEY (orderId) REFERENCES Orders(id),
            FOREIGN KEY (productId) REFERENCES Products(id)
            )
          ''');
    });
  }
  //------------------------------------------------------------
}
