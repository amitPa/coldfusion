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
    //writedump(qryRes.getResult().recordcount, true); // get resultcount
    //writedump(qryRes.getResult(), false); // dump result
   // writeoutput('<BR>');
    if(qryRes.getResult().recordcount >0)
    return "success";

   return "failure";

  }

  remote function signUp(String username,String password ) {
   writedump(arguments);
  }

  function save( event, rc, prc ) {
    // Save a user
  }

  function remove( event, rc, prc ) {
    // Remove a user
  }

}