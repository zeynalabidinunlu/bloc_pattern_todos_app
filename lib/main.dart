import 'package:bloc_pattern_todos_app/ui/cubit/anasayfa_cubit.dart';
import 'package:bloc_pattern_todos_app/ui/cubit/detay_sayfa_cubit.dart';
import 'package:bloc_pattern_todos_app/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:bloc_pattern_todos_app/ui/views/ana_sayfa_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider
    (
      providers: [
        BlocProvider(create: (context) => KayitSayfaCubit()),
        BlocProvider(create: (context) => AnaSayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Anasayfa()
        ),
      ),
    );
  }
}
