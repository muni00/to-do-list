import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc_kullanimlari/data/entity/yapilacaklar.dart';
import 'package:sqlite_bloc_kullanimlari/data/repo/yapilacaklardao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yapilacaklar>> {
  AnasayfaCubit() : super(<Yapilacaklar>[]);

  var yrepo = YapilacaklarDaoRepository();

  Future<void> yapilacaklariListele() async {
    var liste = await yrepo.yapilacaklariListele();
    emit(liste);
  }

  Future<void> yapilacaklardaAra(String aranan) async {
    var liste = await yrepo.yapilacaklardaAra(aranan);
    emit(liste);
  }

  Future<void> yapilacaklardanSil(int yapilacakId) async {
    await yrepo.yapilacaklardanSil(yapilacakId);
    await yapilacaklariListele();
  }
}
