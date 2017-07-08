component output=false{

    this.key="AmitSecret";
     this.ignoreExpiration=true;
     this.issuer="localhost";
     this.audience="desktop";
     this.expiration=99999999999;

     this.algorithm="HmacSHA256";

   function init(){
     variables.key="AmitSecret";
     variables.ignoreExpiration=true;
     variables.issuer="localhost";
     variables.audience="desktop";
     variables.expiration=99999999999;

     variables.algorithmMap = {
			"HS256" = "HmacSHA256"
		};

	return this;

   }

   public string function  decode(required string token ){
     if(listLen(token,".")!=3){
       throw(message="Invalid Token", detail="Token is not a valid token");
     }

     var header = deserializeJSON(base64UrlDecode(listGetAt(arguments.token,1,".")));
     var payload = deserializeJSON(base64UrlDecode(listGetAt(arguments.token,2,".")));
     var signiture = listGetAt(arguments.token,3,".");

     if (listFindNoCase(structKeyList(algorithmMap),header.alg) == false){
        throw(type="Invalid Token", message="Algorithm not supported");
     }

     if (StructKeyExists(payload,"exp") ){
        if (epochTimeToLocalDate(payload.exp) > now()){
          throw(type="Token Expired" ,message="Token Expired");
        }
     }

     if (StructKeyExists(payload,"iss") and variables.issuer != "" and payload.iss != variables.issuer){
			throw(type="Invalid Token", message="Signature verification failed: Issuer does not match");
     }

    if (StructKeyExists(payload,"aud") and variables.audience neq "" and payload.aud neq variables.audience){
			throw(type="Invalid Token",message="Signature verification failed: Audience does not match");
	}

	var signInput = listGetAt(arguments.token,1,".") & "." & listGetAt(arguments.token,2,".");

	if (signiture != sign(signInput)){
	    throw(type="Invalid Token" ,message="Signature verification failed: Audience does not match");
	}

	 return payload;

   }


   //sign(string,[string]) as String Description: Create an MHAC of provided string using the secret key and algorithm
   private string function sign(required string msg){
      writeLog(text = " hitting JWT Key " & this.key, application = "no", file = "server");
     var key = createObject("java", "javax.crypto.spec.SecretKeySpec").Init(this.key.getBytes(), this.algorithm);
       writeLog(text = " hitting JWT Key compile" & key, application = "no", file = "server");
     var mac= createObject("java", "javax.crypto.Mac").getInstance(this.algorithm);
       writeLog(text = " hitting JWT mac " & mac, application = "no", file = "server");
     mac.init(key);
     return base64UrlEscape(toBase64(mac.doFinal(msg.getBytes())));
   }

   //base64UrlEscape(String) as String Description:  Escapes unsafe url characters from a base64 string
   private string function base64UrlEscape (required string str){

       writeLog(text = " hitting base64UrlEscape Api replace replace relace  " & reReplace(reReplace(reReplace(str, "\+", "-", "all"), "\/", "_", "all"),"=", "", "all"), application = "no", file = "server");

     return reReplace(reReplace(reReplace(str, "\+", "-", "all"), "\/", "_", "all"),"=", "", "all");
   }

    //base64UrlDecode(String) as String Description:  Decode a url encoded base64 string
   	private function base64UrlDecode(required string str){
   	  return toString(toBinary(base64UrlUnescape(arguments.str)));
   	}


   //To check expiration time
   private function epochTimeToLocalDate(required any epoch){
      return createObject("java", "java.util.Date").init(epoch*1000);
   }

   //encode(struct) as String Description:  encode a data structure as a JSON Web Token
   public string function encode(required struct payload){
   writeLog(text = " hitting SignIn Encode " & payload.name, application = "no", file = "server");
 
   var segments = "";
     writeLog(text = " hitting SignIn Encode  seg1 " & segments , application = "no", file = "server");
    segments = listAppend(segments, base64UrlEscape(toBase64(serializeJSON({ "typ" =  "JWT", "alg" = this.algorithm }))),".");
    writeLog(text = " hitting SignIn Encode  seg2 " & segments , application = "no", file = "server");


    segments=listAppend(segments, base64UrlEscape(toBase64(serializeJSON(arguments.payload))),".");
        writeLog(text = " hitting SignIn Encode  seg3 " & segments , application = "no", file = "server");

     segments=listAppend(segments, sign(segments),".");
      writeLog(text = " hitting SignIn Encode seg4 " & segments, application = "no", file = "server");

     return segments;

   }

   public boolean function verify(required string token){

    var isValid=true;
    try{
    decode(token);
    }catch(any e){
      isValid=false;
    }
    return isValid;

   }

   private function base64UrlUnescape(required string str){

		// Unescape url characters
		var base64String = reReplace(reReplace(arguments.str, "\-", "+", "all"), "\_", "/", "all");
		var padding = repeatstring("=",4 - len(base64String) mod 4);

		return base64String & padding;
	}
}