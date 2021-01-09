import 'package:tmdb_api/tmdb_api.dart';

class TMDBApi {
  static TMDBApi _instance;
  static TMDBApi get instance => _instance ??= TMDBApi._(); // Singleton

  TMDB api;
  TMDBApi._() {
    // Construtor inicializa a API com as keys
    api = TMDB(
      ApiKeys(
        'f3efd6c22bfa89aea7a97ecb86c49643',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2VmZDZjMjJiZmE4OWFlYTdhOTdlY2I4NmM0OTY0MyIsInN1YiI6IjVmZjg5NGY4ZWZlYTdhMDAzZDZkMTI3NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GZdowF9XuD3rjzajevIlqrp9slVBSr4t5ZS5UvktLl0',
      ),
    );
  }
}
