import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_pattern_todos_app/data/entity/todos.dart';
import 'package:bloc_pattern_todos_app/ui/cubit/anasayfa_cubit.dart';
import 'package:bloc_pattern_todos_app/ui/views/detay_sayfa.dart';
import 'package:bloc_pattern_todos_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().gorevleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                placeholder: "Ara",
                onChanged: (searchText) {
                  context.read<AnaSayfaCubit>().ara(searchText);
                },
              ),
            ),
            BlocBuilder<AnaSayfaCubit, List<Todos>>(
              builder: (context, todosListesi) {
                if (todosListesi.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todosListesi.length,
                      itemBuilder: (context, indeks) {
                        var todo = todosListesi[indeks];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetaySayfa(todo: todo),
                              ),
                            ).then((value) {
                              context.read<AnaSayfaCubit>().gorevleriYukle();
                            });
                          },
                          child: Card(
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          todo.title,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          todo.description,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          todo.isDone
                                              ? "Tamamlandı"
                                              : "Tamamlanmadı",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: todo.isDone
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "${todo.title} silinsin mi?"),
                                          action: SnackBarAction(
                                            label: "Evet",
                                            onPressed: () {
                                              context
                                                  .read<AnaSayfaCubit>()
                                                  .sil(todo.id);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.clear,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("Todo listesi boş"));
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KayitSayfa()),
          ).then((value) {
            context.read<AnaSayfaCubit>().gorevleriYukle();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
