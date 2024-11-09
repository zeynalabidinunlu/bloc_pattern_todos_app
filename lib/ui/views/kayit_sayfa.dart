import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_pattern_todos_app/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfTitle = TextEditingController();
  var tfDescription = TextEditingController();
  bool isDone = false;

  int generateId() {
    return Random().nextInt(100000); // 0 ile 100000 arasında rastgele bir id
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Kayıt Sayfası"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0, left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfTitle,
                decoration: const InputDecoration(hintText: "Başlık"),
              ),
              TextField(
                controller: tfDescription,
                decoration: const InputDecoration(hintText: "Açıklama"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tamamlandı mı?"),
                  Checkbox(
                    value: isDone,
                    onChanged: (bool? value) {
                      setState(() {
                        isDone = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  int id = generateId();
                  context
                      .read<KayitSayfaCubit>()
                      .kaydet(tfTitle.text, tfDescription.text, id, isDone);
                },
                child: const Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
