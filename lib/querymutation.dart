class QueryMutation {
  String getAll() {
    return """ 
        {
        auction{
          code
          name
          prix
        }
      }
    """;
  }

  String editauction(String code, String name, String prix) {
    return """
      mutation{
        update_auction(where: {code :{_eq : $code}}, _set : {name :$name,prix:$prix}){
      returning{
        code,
        name,
        prix
      }
    }
  }   
     """;
  }

  String addAuction() {
    """
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
  }
}
