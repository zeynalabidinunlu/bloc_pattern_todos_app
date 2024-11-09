import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_pattern_todos_app/data/entity/todos.dart';
import 'package:bloc_pattern_todos_app/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  final Todos todo;
  DetaySayfa({required this.todo});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfTitle = TextEditingController();
  var tfDescription = TextEditingController();
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    var todo = widget.todo;
    tfTitle.text = todo.title;
    tfDescription.text = todo.description;
    isDone = todo.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Detay"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
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
                  context.read<DetaySayfaCubit>().guncelle(
                        tfTitle.text,
                        tfDescription.text,
                        widget.todo.id,
                        isDone,
                      );
                },
                child: const Text("GÜNCELLE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
