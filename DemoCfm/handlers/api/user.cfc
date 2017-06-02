/**
 * user
 *
 * @author Amit Pandey
 * @date 5/29/17
 **/
component  {

 remote function  checkLogin(required String username = "", String password =" " ) returnformat="json"{

    myQry = new Query(); // new query object
    myQry.setSQL("select email,name,contact from user where email =:username AND password=:password"); //set query
    myQry.addParam(name="username",value=username,CFSQLTYPE="CF_SQL_VARCHAR");
    myQry.addParam(name="password",value=password,CFSQLTYPE="CF_SQL_VARCHAR");  // add query param
    qryRes = myQry.execute(); // execute query
    if(qryRes.getResult().recordcount >0){
    	Session.email= qryRes.getResult().email[1];
    	Session.name= qryRes.getResult().name[1];
    	Session.contact= qryRes.getResult().contact[1];
    	Session.authenticated=true;
        return "success";
    }
   return "failure";

  }

  remote function signUp(required String firstname="",required String lastname="",required String password="" ,required String email="",required String contact="") returnformat="json" {
   insrtQuery=new Query();

   var fullName=firstName & lastname;

   insrtQuery.setSQL("INSERT INTO user(name,contact,email,password) VALUES(:name,:contact,:email,:password)");
   insrtQuery.addParam(name="name",value=fullName,CFSQLTYPE="CF_SQL_VARCHAR");
   insrtQuery.addParam(name="contact",value=contact,CFSQLTYPE="CF_SQL_VARCHAR");
   insrtQuery.addParam(name="email",value=email,CFSQLTYPE="CF_SQL_VARCHAR");
   insrtQuery.addParam(name="password",value=password,CFSQLTYPE="CF_SQL_VARCHAR");

   qryRes = insrtQuery.execute();

   return "success";

  }

  function save( event, rc, prc ) {
    // Save a user
  }

  function remove( event, rc, prc ) {
    // Remove a user
  }

}