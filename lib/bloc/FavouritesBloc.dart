import 'package:VeViRe/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

class FavouritesBloc {
  Repositories repositories = Repositories();
  final storage = FlutterSecureStorage();

  final id = BehaviorSubject<String>();
  final action = BehaviorSubject<String>();

  Function get getId => id.sink.add;
  Function get getAction => action.sink.add;

  getFavourites() async {}

  updateFavorites() async {
    return repositories.updateFavorites(id.value,action.value);
  }

  void dispose() {
    id.close();
    action.close();
  }
}

final favouritesBloc = FavouritesBloc();
