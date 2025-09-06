import 'package:get_it/get_it.dart';
import '../api/quiz_api.dart';
import '../store/quiz_store.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<QuizApi>(
    () => QuizApi(),
  );

  getIt.registerLazySingleton<QuizStore>(
    () => QuizStore(),
  );
}
