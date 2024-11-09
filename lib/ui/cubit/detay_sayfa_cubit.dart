import 'package:bloc_pattern_todos_app/data/repository/todos_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() : super(0);
  var krepo = TodosDaoRepository();
  Future<void> guncelle(
      String title, String description, int id, bool isDone) async {
    await krepo.guncelle(title, description, id, isDone);
  }
}
