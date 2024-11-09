import 'package:bloc_pattern_todos_app/data/repository/todos_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KayitSayfaCubit extends Cubit<void> {
  KayitSayfaCubit() : super(0);
  var krepo = TodosDaoRepository();
  Future<void> kaydet(
      String title, String description, int id, bool isDone) async {
    await krepo.todosSave(title, description, id, isDone);
  }
}
