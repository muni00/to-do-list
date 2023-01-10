import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Veritabani {
  static const String veritabaniAdi = "yapilacaklar.sqlite";
  static Future<Database> veritabaniErisim() async {
    String veritaniYolu = join(await getDatabasesPath(), veritabaniAdi);
    if (await databaseExists(veritaniYolu)) {
      print("veritabanı mevcut");
    } else {
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritaniYolu).writeAsBytes(bytes, flush: true);
      print("veritabanı kopyalandı");
    }
    return openDatabase(veritaniYolu);
  }
}
