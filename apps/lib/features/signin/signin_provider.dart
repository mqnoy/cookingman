import 'package:cookingman/data/grapql.dart';
import 'package:cookingman/models/users_mod.dart';
import 'package:flutter/foundation.dart';
import 'package:cookingman/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class SignInProvider with ChangeNotifier {
  bool _loading = false;
  List<Users> _collectionUsers = [];

  GraphQLClient graphqlClient = sl<GraphQL>().getClient();

  void handleResult(QueryResult result) {
    if (result.data!['tbl_users'] != null) {
      TblUser tu = TblUser.fromJson(result.data!);
      _collectionUsers = tu.users;
      _loading = false;
      notifyListeners();
    }
  }

  List<Users> get getCollectionUsers => _collectionUsers;

  void fetchUsers() async {
    print("fetchUsers ----");
    handleResult(await sl<SignInProvider>().graphqlClient.populateUsers());
  }

  SignInProvider() {
    //fetchUsers();
  }
}
