import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_qima/graphql.dart';
import 'package:graphql_qima/main.dart';
import 'package:graphql_qima/screen/list.dart';

import '../querymutation.dart';

class DetailAution extends StatefulWidget {
  DetailAution({Key key, this.code, this.name, this.prix}) : super(key: key);
  final String code;
  final String name;
  final String prix;
  static final String id = 'detailauction';
  @override
  _DetailAutionState createState() => _DetailAutionState();
}

class _DetailAutionState extends State<DetailAution> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  String mutation = """
  mutation Insert_auction(\$code:String!,\$name:String,\$prix:String){
    insert_auction(objects:{
      code:\$code,
      name:\$name,
      prix:\$prix
    }){
      affected_rows
    }
  }
"""
      .replaceAll('\n', '');

  String mutationUpdate = '''
  mutation Update_auction(\$code:String!,\$name:String,\$prix:String){
  update_auction(where: 
    {code: {_eq: \$code}}, 
    _set: {name: \$name, prix: \$prix}) {
    affected_rows
  }
}
  ''';

  String mutationDelete = '''
  mutation Delete_auction(\$code:String!){
  delete_auction(where: {code: {_eq: \$code}}) {
    affected_rows
  }
}
  ''';

  String codew;
  @override
  void setState(fn) {
    codew = widget.code;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail auction'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.code),
          Text(widget.name),
          SizedBox(
            height: 50,
          ),
          Text(
            widget.prix,
            style: TextStyle(
                color: Colors.blue, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Mutation(
            options: MutationOptions(document: mutationUpdate),
            builder: (runMutationUpdate, result) {
              return MaterialButton(
                child: Text(
                  'Add Auction',
                  style: TextStyle(color: Colors.black),
                ),
                // onPressed: () => runMutation(
                //     {'code': '000', 'name': 'Othmane', 'prix': '500'}),
                onPressed: () => runMutationUpdate(
                    {'code': widget.code, 'name': 'widget.name', 'prix': '6000'}),
                // onPressed: () => runMutationDelete({'code': widget.code}),
              );
            },
          )
        ],
      ),
    );
  }
}
