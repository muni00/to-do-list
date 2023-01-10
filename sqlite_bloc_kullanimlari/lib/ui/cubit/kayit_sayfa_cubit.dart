import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc_kullanimlari/data/repo/yapilacaklardao_repository.dart';

class KayitSayfaCubit extends Cubit<void> {
  KayitSayfaCubit() : super(0);
  var yrepo = YapilacaklarDaoRepository();

  Future<void> yapilacaklaraKaydet(String yapilacakName) async {
    await yrepo.yapilacaklaraKaydet(yapilacakName);
  }
}
