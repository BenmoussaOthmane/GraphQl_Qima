import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddAuction extends StatefulWidget {
  static final String id = 'addauction';
  @override
  _AddAuctionState createState() => _AddAuctionState();
}

class _AddAuctionState extends State<AddAuction> {
  final _codeControler = TextEditingController();
  final _nameControler = TextEditingController();
  final _prixControler = TextEditingController();

  String addmutation = """
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Mutation(
        options: MutationOptions(
          document: addmutation,
          update: (Cache cache, QueryResult result) {
            return cache;
          },
          // or do something with the result.data on completion
          onCompleted: (dynamic resultData) {
            Navigator.pop(context);
          },
        ),
        builder: (runMutation, result) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.7),
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('ADD Auction',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Add Code Auction',
                      ),
                      controller: _codeControler,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Add Name',
                      ),
                      controller: _nameControler,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Add Id Prix',
                      ),
                      controller: _prixControler,
                    ),
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: FlatButton(
                          onPressed: () => runMutation({
                            'code': _codeControler.text,
                            'name': _nameControler.text,
                            'prix': _prixControler.text
                          }),
                          child: Text('ADD Auction',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
