import 'package:graphql/client.dart';

class GraphQL {
  final String baseURL;

  GraphQL({required this.baseURL});

  GraphQLClient getClient() => GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink(baseURL),
      );
}

extension Graph on GraphQLClient {
  Future populateUsers() {
    final String readUsers = """
      query readUsers {
        tbl_users {
          email
          id
          password
          username
        }
      }
    """;

    return this.query(
      QueryOptions(
        document: gql(readUsers),
        // variables: {'tbl_users': ""},
      ),
    );
  }
}
