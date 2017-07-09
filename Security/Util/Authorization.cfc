component  output=false{

	public boolean function verifyHeader(){

	 writeLog(text = " Check Authorization Header ", file = "server",type="information");

	
	  try{
	  var authorization=getHttpRequestData().headers["Authorization"];
	  var jwt=createObject('component', 'security.JwtSecurity.jwt');
	  if(len(trim(authorization))){   
	  writeLog(text = "Verifying Check Authorization Header " & authorization, file = "server",type="information");
          if(jwt.verify(authorization)){
          writeLog(text = "Verifying Check Authorization Header true", file = "server",type="information");
           return true;
          }
        return false;
	  }
	  else{
	   writeLog(text = "Authorization header is not passed", file = "server",type="error");
	   throw(type="Authorization Header" ,message="Authorization header is not passed");
	  }

	  }catch(Any e){
	   writeLog(text = " Problem in processing header request " & toString(e), file = "server",type="error");
	   return false;
	  }
	 
	}
}