import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_qima/querymutation.dart';

import 'detail.dart';

class ListAuction extends StatefulWidget {
  static final String id = 'listauction';
  @override
  _ListAuctionState createState() => _ListAuctionState();
}

class _ListAuctionState extends State<ListAuction> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LISTE GHRAPHQL'),
      ),
      body: Query(
        options: WatchQueryOptions(
          documentNode: gql(QueryMutation().getAll()),
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return Text('Loading');
          }
          return ListView.builder(
            itemBuilder: (_, index) {
              final resultdata = result.data['auction'][index];
              return ListTile(
                  title: Text(resultdata['code']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailAution(
                                  code: result.data['auction'][index]['code'],
                                  name: result.data['auction'][index]['name'],
                                  prix: result.data['auction'][index]['prix'],
                                )));
                  });
            },
            itemCount: result.data['auction'].length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
}
