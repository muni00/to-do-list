import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/anasayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/design/renkler.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({Key? key}) : super(key: key);

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfYapilacakAd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: tfYapilacakAd,
              style: TextStyle(color: acik),
              cursorColor: cirt,
              decoration: InputDecoration(
                hintText: "Yapilacak Ekle",
                hintStyle: TextStyle(color: acik),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: acik),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: acik),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context
                    .read<KayitSayfaCubit>()
                    .yapilacaklaraKaydet(tfYapilacakAd.text);
                context.read<AnasayfaCubit>().yapilacaklariListele();
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 8.0),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        color: cirt, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Kaydet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: koyu,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
