import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_qima/querymutation.dart';
import 'package:graphql_qima/screen/addauction.dart';

import 'detail.dart';

class ListAuction extends StatefulWidget {
  static final String id = 'listauction';
  @override
  _Listauctionstate createState() => _Listauctionstate();
}

class _Listauctionstate extends State<ListAuction> {
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
              final resultdata = result.data['auctions'][index];
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailAution(
                                  code: result.data['auctions'][index]['entryPrice'],
                                  name: result.data['auctions'][index]['id'],
                                  // prix: result.data['auctions'][index]['prix'],
                                )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[500],
                              offset: Offset(5.0, 5.0),
                              blurRadius: 15.0,
                              spreadRadius: 2.0)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/2/28/Sillitoe-black-white.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            resultdata['id'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
              // return ListTile(
              //     title: Text(resultdata['code']),
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => DetailAution(
              //                     code: result.data['auction'][index]['code'],
              //                     name: result.data['auction'][index]['name'],
              //                     prix: result.data['auction'][index]['prix'],
              //                   )));
              //     });
            },
            itemCount: result.data['auctions'].length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AddAuction.id);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
