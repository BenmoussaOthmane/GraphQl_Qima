import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_qima/graphql.dart';

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

var price = 0;

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
  String mutationGetAuction = '''
  mutatuion Get_auction
  query(\$code:String!){
  auction(where: {code: {_eq: \$code}}) {
    code,
    name
    prix
  }
}''';
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
  double addcent = 0;
  String some;
  String queryGetAuction = "";
  @override
  void initState() {
    queryGetAuction = '''
query getAuctionid() {
  auction(where: {code: {_eq: "${widget.code}"}}) {
    code,
    name,
    prix
  }
}  
 
''';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail auction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Query(
              options: WatchQueryOptions(
                documentNode: gql(queryGetAuction),
                pollInterval: 5,
              ),
              builder: (result, {fetchMore, refetch}) {
                    addcent = double.parse(result.data['auction'][0]['prix']);
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.loading) {
                  return Text('Loading');
                }
                return Column(
                  children: [
                    if (result.data['auction'][0]['code'] != null)
                      Container(
                        child: Text(
                          result.data['auction'][0]['code'],
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    // Text(result.data['auction'][0]['name']),
                    SizedBox(
                      height: 50,
                    ),
                    result.data['auction'][0]['prix'] == null
                        ? Text('Loading')
                        : Text(
                            result.data['auction'][0]['prix'],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: 50,
                    ),
                    Mutation(
                      options: MutationOptions(
                          document: mutationUpdate,
                          update: (Cache cache, QueryResult result) {
                            return cache;
                          },
                          // or do something with the result.data on completion
                          onCompleted: (dynamic resultData) {}),
                      builder: (runMutationUpdate, result) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                color: Colors.blue,
                                child: MaterialButton(
                                  child: Text(
                                    'Add 100',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      some = (addcent + 100).toString();
                                    });
                                    runMutationUpdate({
                                      'code': widget.code,
                                      'name': 'widget.name',
                                      'prix': some
                                    });
                                  },
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                child: MaterialButton(
                                  child: Text(
                                    'Add 200',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      some = (addcent + 200).toString();
                                    });
                                    runMutationUpdate({
                                      'code': widget.code,
                                      'name': 'widget.name',
                                      'prix': some
                                    });
                                  },
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                child: MaterialButton(
                                  child: Text(
                                    'Add 500',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      some = (addcent + 500).toString();
                                    });
                                    runMutationUpdate({
                                      'code': widget.code,
                                      'name': 'widget.name',
                                      'prix': some
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
