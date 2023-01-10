import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc_kullanimlari/data/repo/yapilacaklardao_repository.dart';

class DetaySayfaCubit extends Cubit {
  DetaySayfaCubit() : super(0);

  var yrepo = YapilacaklarDaoRepository();

  Future<void> yapilacaklariGuncelle(
      int yapilacakId, String yapilacakName) async {
    await yrepo.yapilacaklariGuncelle(yapilacakId, yapilacakName);
  }
}
