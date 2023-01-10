import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc_kullanimlari/data/entity/yapilacaklar.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/anasayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/detay_sayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/design/renkler.dart';

class DetaySayfa extends StatefulWidget {
  Yapilacaklar yapilacaklar;
  DetaySayfa({required this.yapilacaklar});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfYapilacakAd = TextEditingController();

  @override
  void initState() {
    //sayfa acıldığı gibi çalısacak
    super.initState();
    var yapilacaklar = widget.yapilacaklar;
    tfYapilacakAd.text = yapilacaklar.yapilacak;
  }

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
                hintText: "Yapilacağı Güncelle",
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
                context.read<DetaySayfaCubit>().yapilacaklariGuncelle(
                    widget.yapilacaklar.id, tfYapilacakAd.text);
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
                          "Güncelle",
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
