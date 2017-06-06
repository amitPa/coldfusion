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
    	session.email= qryRes.getResult().email[1];
    	session.name= qryRes.getResult().name[1];
    	session.contact= qryRes.getResult().contact[1];
    	session.authenticated=true;
    	//writeoutput(session.email & "  Amit");
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

 remote function booking(String productId=""){
 	myQry = new Query(); // new query object
    myQry.setSQL("select url,name,description,price,discount from product where product_id =:productId"); //set query
    myQry.addParam(name="productId",value=productId,CFSQLTYPE="CF_SQL_VARCHAR");
    qryRes = myQry.execute();
      if(qryRes.getResult().recordcount >0){
      	return qryRes.getResult();
    }else{
    	location(url="/DemoCFM/views/dashboard/dashboard.cfm",addToken=false);
    }

 }
  function save( event, rc, prc ) {
    // Save a user
  }

  function remove( event, rc, prc ) {
    // Remove a user
  }

}