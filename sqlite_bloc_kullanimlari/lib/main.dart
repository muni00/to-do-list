import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/anasayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/detay_sayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:sqlite_bloc_kullanimlari/ui/screen/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => KayitSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: Anasayfa(),
      ),
    );
  }
}
