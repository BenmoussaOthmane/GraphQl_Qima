import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final _nameControler = TextEditingController();
    final _emailControler = TextEditingController();
    final _passwodControler = TextEditingController();
    final _phoneControler = TextEditingController();

    String addmutation = """
  mutation{
    signup(input:{
      fullName:"c",
      email:"c@gmail.com",
      password:"azerty",
      phone:123456789
    }){
      email
    }
  }
"""
        .replaceAll('\n', '');

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
                        hintText: 'Fullname',
                      ),
                      controller: _nameControler,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'email',
                      ),
                      controller: _emailControler,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      controller: _passwodControler,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'phone',
                      ),
                      controller: _phoneControler,
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
                            'fullName': _nameControler.text,
                            'email': _emailControler.text,
                            'password': _passwodControler.text,
                            'phone': _phoneControler.text
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
