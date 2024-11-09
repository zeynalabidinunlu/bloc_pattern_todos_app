import 'package:bloc_pattern_todos_app/data/entity/todos.dart';
import 'package:bloc_pattern_todos_app/data/repository/todos_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaSayfaCubit extends Cubit<List<Todos>> {
  AnaSayfaCubit() : super(<Todos>[]);

  var krepo= TodosDaoRepository();
  Future<void> gorevleriYukle() async {
    emit(await krepo.gorevleriYukle());
  }

  Future<void> ara(String aranan) async {
    emit(await krepo.ara(aranan));
  }

Future<void> sil(int id)async{
    await krepo.sil(id);
    emit(await krepo.gorevleriYukle());
}

}