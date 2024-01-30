import 'package:ayotripfiks/model/wisata.dart';
import 'package:ayotripfiks/model/booking.dart';
import 'package:ayotripfiks/model/story.dart';
import 'package:ayotripfiks/model/user.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<sql.Database> db() async {
    try {
      return sql.openDatabase(
        join(await sql.getDatabasesPath(),
            'fiks.db'),
        version: 2,
        onCreate: (database, version) async {
          await database.execute("""
          CREATE TABLE wisata(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            judul TEXT,
            ratting TEXT,
            deskripsi TEXT,
            harga TEXT,
            photo TEXT
          )
          """);

          await database.execute("""
          CREATE TABLE user(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            username TEXT,
            email TEXT,
            password TEXT
          )
          """);

          await database.execute("""
   CREATE TABLE booking(
     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
     nama TEXT,
     destinasi TEXT,
     nohp TEXT,
     harga TEXT,
     jumlah TEXT
   )
""");

          await database.execute("""
          CREATE TABLE story(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            judul TEXT,
            deskripsi TEXT,
            photo TEXT
          )
          """);
        },
      );
    } catch (e) {
      print("Error opening database: $e");
      throw e; // Rethrow exception untuk menangkapnya di bagian pemanggil.
    }
  }

  //wisata

  static Future<int> tambahWisata(Wisata wisata) async {
    final db = await DatabaseHelper.db(); // Membuka database.
    final data = wisata.toList(); // Mendapatkan data foto dalam bentuk Map.
    return db.insert('wisata', data); // Menambahkan data ke dalam tabel 'foto'.
  }

  static Future<List<Map<String, dynamic>>> getWisataData() async {
    final db = await DatabaseHelper.db();
    return db.query("wisata"); // Mengambil semua data dari tabel 'wisata'.
  }

  static Future<int> updateWisata(Wisata wisata) async {
    final db = await DatabaseHelper.db();
    final data = wisata.toList(); // Mendapatkan data foto dalam bentuk Map.
    return db.update('wisata', data, where: "id=?", whereArgs: [
      wisata.id
    ]); // Memperbarui data di tabel 'foto' berdasarkan ID.
  }

  static Future<int> deleteWisata(int id) async {
    final db = await DatabaseHelper.db();
    return db.delete("wisata", where: 'id = ?', whereArgs: [id]);
  }

  //booking

static Future<int> tambahBooking(Booking booking) async {
  final dbInstance = await db(); // Use the db() method from DatabaseHelper
  return dbInstance.insert('booking', booking.toMap());
}

static Future<List<Booking>> getBooking() async {
  final db = await DatabaseHelper.db();
  List<Map<String, dynamic>> results = await db.query("booking");

  // Transform data dari List<Map<String, dynamic>> menjadi List<Booking>
  List<Booking> bookings = results.map((map) => Booking.fromMap(map)).toList();

  return bookings;
}

 static Future<int> updateBooking(Booking booking) async {
    final db = await DatabaseHelper.db();
    final data = booking.toMap(); // Mendapatkan data foto dalam bentuk Map.
    return db.update('booking', data, where: "id=?", whereArgs: [booking.id]); // Memperbarui data di tabel 'foto' berdasarkan ID.
  }

    static Future<int> deleteBooking(int id) async {
    final db = await DatabaseHelper.db();
    return db.delete("booking", where: 'id = ?', whereArgs: [id]);
  }

  //story

  static Future<int> tambahStory(Story story) async {
    final db = await DatabaseHelper.db(); // Membuka database.
    final data = story.toList(); // Mendapatkan data foto dalam bentuk Map.
    return db.insert('story', data); // Menambahkan data ke dalam tabel 'foto'.
  }

   static Future<List<Map<String, dynamic>>> getStory() async {
    final db = await DatabaseHelper.db();
    return db.query("story"); // Mengambil semua data dari tabel 'story'.
  }

  static Future<int> updateStory(Story story) async {
    final db = await DatabaseHelper.db();
    final data = story.toList(); // Mendapatkan data foto dalam bentuk Map.
    return db.update('story', data, where: "id=?", whereArgs: [story.id]); // Memperbarui data di tabel 'foto' berdasarkan ID.
  }

  static Future<int> deleteStory(int id) async {
    final db = await DatabaseHelper.db();
    return db.delete("story", where: 'id = ?', whereArgs: [id]);
  }

static Future<int> tambahUser(User user) async {
  final dbInstance = await db(); // Use the db() method from DatabaseHelper
  return dbInstance.insert('user', user.toMap());
}


static Future<List<User>> getUser() async {
  final db = await DatabaseHelper.db();
  List<Map<String, dynamic>> results = await db.query("user");

  // Transform data dari List<Map<String, dynamic>> menjadi List<Booking>
  List<User> users = results.map((map) => User.fromMap(map)).toList();

  return users;
}

 static Future<int> updateUser(User user) async {
    final db = await DatabaseHelper.db();
    final data = user.toMap(); // Mendapatkan data foto dalam bentuk Map.
    return db.update('booking', data, where: "id=?", whereArgs: [user.id]); // Memperbarui data di tabel 'foto' berdasarkan ID.
  }

  static Future<int> deleteUser(int id) async {
    final db = await DatabaseHelper.db();
    return db.delete("user", where: 'id = ?', whereArgs: [id]);
  }
}
