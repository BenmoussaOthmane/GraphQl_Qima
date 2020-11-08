import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_qima/graphql.dart';
import 'package:graphql_qima/screen/detail.dart';
import 'package:graphql_qima/screen/list.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() => runApp(

    MyApp());

class MyApp extends StatelessWidget {
 
  // }
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLConfiguration.client,
      child: CacheProvider(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListAuction(),
        routes: {
          ListAuction.id: (context) => ListAuction(),
          DetailAution.id: (context) => DetailAution()
        },
      )),
    );
  }
}
