import 'package:sqlite_bloc_kullanimlari/data/entity/yapilacaklar.dart';
import 'package:sqlite_bloc_kullanimlari/data/sqlite/veritabani.dart';

class YapilacaklarDaoRepository {
  Future<void> yapilacaklaraKaydet(String yapilacakName) async {
    var db = await Veritabani.veritabaniErisim();
    var bilgiler = Map<String, dynamic>();
    bilgiler["name"] = yapilacakName;
    await db.insert("toDos", bilgiler);
  }

  Future<void> yapilacaklariGuncelle(
      int yapilacakId, String yapilacakName) async {
    var db = await Veritabani.veritabaniErisim();
    var bilgiler = Map<String, dynamic>();
    bilgiler["name"] = yapilacakName;
    await db.update("toDos", bilgiler, where: "id=?", whereArgs: [yapilacakId]);
  }

  Future<List<Yapilacaklar>> yapilacaklariListele() async {
    var db = await Veritabani.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM toDos");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Yapilacaklar(id: satir["id"], yapilacak: satir["name"]);
    });
  }

  Future<List<Yapilacaklar>> yapilacaklardaAra(String aranan) async {
    var db = await Veritabani.veritabaniErisim();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM toDos WHERE name like '%$aranan%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Yapilacaklar(id: satir["id"], yapilacak: satir["name"]);
    });
  }

  Future<void> yapilacaklardanSil(int yapilacak_id) async {
    var db = await Veritabani.veritabaniErisim();
    await db.delete("toDos", where: "id=?", whereArgs: [yapilacak_id]);
  }
}
