import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc_kullanimlari/data/entity/yapilacaklar.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/anasayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/design/renkler.dart';
import 'package:sqlite_bloc_kullanimlari/ui/screen/detay_sayfa.dart';
import 'package:sqlite_bloc_kullanimlari/ui/screen/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yapilacaklariListele();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: birTikKoyu,
      appBar: AppBar(
        backgroundColor: birTikKoyu,
        title: aramaYapiliyorMu ? buildTextField(context) : buildCenterText(),
        actions: [
          aramaYapiliyorMu
              ? buildIconButtonClose(context)
              : buildIconButtonSearch()
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yapilacaklar>>(
        builder: (context, yapilacaklarListesi) {
          if (yapilacaklarListesi.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: buildGridViewBody(yapilacaklarListesi, context),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  GridView buildGridViewBody(
      List<Yapilacaklar> yapilacaklarListesi, BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: yapilacaklarListesi.length,
        itemBuilder: (BuildContext ctx, index) {
          var yapilacak = yapilacaklarListesi[index];
          return yapilacaklarListesi.indexOf(yapilacaklarListesi[index]) == 0
              ? buildGestureDetectorBirinciElemanIse(context)
              : buildGestureDetectorBirinciElemanDegilse(
                  context, yapilacak, yapilacaklarListesi, index);
        });
  }

  GestureDetector buildGestureDetectorBirinciElemanDegilse(
      BuildContext context,
      Yapilacaklar yapilacak,
      List<Yapilacaklar> yapilacaklarListesi,
      int index) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            backgroundColor: birTikKoyu,
            builder: (context) {
              return SizedBox(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [DetaySayfa(yapilacaklar: yapilacak)],
                ),
              );
            });
      },
      child: Stack(children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: cirt, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              yapilacaklarListesi[index].yapilacak,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: 5.0,
          right: 10.0,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "${yapilacaklarListesi[index].yapilacak} silinsin mi?",
                        style: TextStyle(color: cirt),
                      ),
                      action: SnackBarAction(
                          textColor: cirt,
                          label: "Sil",
                          onPressed: () {
                            context.read<AnasayfaCubit>().yapilacaklardanSil(
                                yapilacaklarListesi[index].id);
                          }),
                    ));
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: koyu,
                  )) //sil
            ],
          ),
        ),
      ]),
    );
  }

  GestureDetector buildGestureDetectorBirinciElemanIse(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            backgroundColor: birTikKoyu,
            builder: (context) {
              return SizedBox(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [KayitSayfa()],
                ),
              );
            });
      },
      child: Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: cirt, borderRadius: BorderRadius.circular(15)),
        child: Icon(
          Icons.add,
          color: koyu,
          size: 30,
        ),
      ),
    );
  }

  IconButton buildIconButtonSearch() {
    return IconButton(
      onPressed: () {
        setState(() {
          aramaYapiliyorMu = true;
        });
      },
      icon: const Icon(Icons.search),
    );
  }

  IconButton buildIconButtonClose(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          aramaYapiliyorMu = false;
          context.read<AnasayfaCubit>().yapilacaklariListele();
        });
      },
      icon: const Icon(Icons.clear),
    );
  }

  Center buildCenterText() {
    return Center(
      child: Text(
        "Yapilacaklar",
        style: TextStyle(color: acik),
      ),
    );
  }

  TextField buildTextField(BuildContext context) {
    return TextField(
      style: TextStyle(color: acik),
      cursorColor: cirt,
      decoration: InputDecoration(
        hintText: "Arama",
        hintStyle: TextStyle(color: acik),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: acik),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: acik),
        ),
      ),
      onChanged: (aramaSonucu) {
        context.read<AnasayfaCubit>().yapilacaklardaAra(aramaSonucu);
      },
    );
  }
}
