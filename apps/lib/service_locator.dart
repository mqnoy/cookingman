import 'dart:async';
import 'package:cookingman/data/api_repo.dart';
import 'package:cookingman/data/local_repository.dart';
import 'package:cookingman/features/signin/signin_provider.dart';
import 'package:cookingman/features/signup/signup_provider.dart';
import 'package:cookingman/services/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// sl: service locator
final sl = GetIt.instance;

Future<void> initLocator() async {
  sl.registerLazySingleton<ApiRepo>(
    () => ApiRepo(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LocalRepo>(
    () => LocalRepo(
      sharedPreferences: sl(),
    ),
  );

  Dio client = Dio(
    BaseOptions(
      //baseUrl: '', here you can set the base url so you don't have to type it every time you make an API call
      contentType: 'application/json',
    ),
  );
  sl.registerLazySingleton<Dio>(() => client);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton(() => SignInProvider());
  sl.registerLazySingleton(() => SignUpProvider());

  sl.registerLazySingleton(() => NavigationService());
}
