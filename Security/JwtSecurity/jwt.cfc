component output=false{

    this.key="AmitSecret";
     this.ignoreExpiration=true;
     this.issuer="localhost";
     this.audience="desktop";
     this.expiration=1800;

     this.algorithm="HmacSHA256";

   function init(){
     variables.key="AmitSecret";
     variables.ignoreExpiration=true;
     variables.issuer="localhost";
     variables.audience="desktop";
     variables.expiration=180;

     variables.algorithmMap = {
      "HS256" = "HmacSHA256"
    };

  return this;

   }

   public function  decode(required string token ){
   writeLog(text = "Verifying Check Authorization Header IsValid decode", file = "server",type="information");
     if(listLen(token,".")!=3){
       throw(message="Invalid Token", detail="Token is not a valid token");
     }

     writeLog(text = "Verifying Check Authorization Header IsValid decode header " & listGetAt(arguments.token,1,".") , file = "server",type="information");
     var header = deserializeJSON(base64UrlDecode(listGetAt(arguments.token,1,".")));

     writeLog(text = " Header IsValid decode header " & header.TYP, file = "server",type="information");

     writeLog(text = " PayLoad IsValid decode payload " & listGetAt(arguments.token,2,"."), file = "server",type="information");
     var payload = deserializeJSON(base64UrlDecode(listGetAt(arguments.token,2,".")));
     writeLog(text = "Verifying Check Authorization PayLoad IsValid decode payload " & serializeJSON(payload), file = "server",type="information");

     var signature = listGetAt(arguments.token,3,".");
     writeLog(text = "Verifying Check Authorization Signature IsValid decode signature " & signature , file = "server",type="information");

     if ((StructKeyExists(payload,"exp") && header.alg==this.algorithm) == false){
        throw(type="Invalid Token", message="Algorithm not supported");
     }

     if (StructKeyExists(payload,"exp") ){

        if (DateDiff("s",Now(),DateAdd("s",this.expiration,payload.created))<0){
          writeLog(text = "Token expired " & payload.created & "  " & DateAdd("s",this.expiration,payload.created) & " now " & now(), file = "server",type="information");
          throw(type="Token Expired" ,message="Token Expired");
        }
     }

        writeLog(text = "Invalid Token payload " , file = "server",type="information");

     if (StructKeyExists(payload,"iss")  and payload.iss != this.issuer){
      writeLog(text = "Invalid Token " , file = "server",type="information");
      throw(type="Invalid Token", message="Signature verification failed: Issuer does not match");
     }

  var signInput = listGetAt(arguments.token,1,".") & "." & listGetAt(arguments.token,2,".");
        writeLog(text = "Token expired sign " & signature & "  :::::::: spi ::::::::::::: " & sign(signInput), file = "server",type="information");
  if (signature != sign(signInput)){
         writeLog(text = "Invalid Signature  " , file = "server",type="information");
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
    public function base64UrlDecode(required str){
     var encodeDecode=createObject('component','security.Util.EncodeDecode');
     var returnStr=encodeDecode.base64UrlDecode(str);
      writeLog(text = " JWT base64UrlDecode  " & serializeJSON(returnStr) , file = "server",type="information");
     return returnStr;
   }

   //To check expiration time
   private function epochTimeToLocalDate(required any epoch){
      return createObject("java", "java.util.Date").init(epoch*1000);
   }

   //encode(struct) as String Description:  encode a data structure as a JSON Web Token
   public string function encode(required struct encryptData){
   writeLog(text = " hitting SignIn Encode " & encryptData.user, application = "no", file = "server");

   //create payload
   var payload=structNew();
   payload.exp=this.expiration;
   payload.iss=this.issuer;
   payload.user=encryptData.user;
   payload.created=Now();
   var header =structNew();
   header.typ="JWT";
   header.alg=this.algorithm;

   writeLog(text = " hitting SignIn Encode  time  " & payload.created & " / " & DateAdd("s",this.expiration,payload.created) , application = "no", file = "server");

   var segments = "";
     writeLog(text = " hitting SignIn Encode  seg1 " & segments , application = "no", file = "server");
    segments = listAppend(segments, base64UrlEscape(toBase64(serializeJSON(header))),".");
    writeLog(text = " hitting SignIn Encode  seg2 " & segments , application = "no", file = "server");


    segments=listAppend(segments, base64UrlEscape(toBase64(serializeJSON(payload))),".");
        writeLog(text = " hitting SignIn Encode  seg3 " & segments , application = "no", file = "server");

     segments=listAppend(segments, sign(segments),".");
      writeLog(text = " hitting SignIn Encode seg4 " & segments, application = "no", file = "server");

     return segments;

   }

   public boolean function verify(required string token){
   writeLog(text = "Verifying Check Authorization IsValid ", file = "server",type="information");
    var isValid=true;
    try{
    decode(token);
    writeLog(text = " Decoded string ", file = "server",type="information");
    }catch(any e){
      isValid=false;
    }
    return isValid;

   }

   private function base64UrlUnescape(required string str){
      writeLog(text = " Base64UrlUnescape IsValid decode12 " & str, file = "server",type="information");
    // Unescape url characters
    var base64String = reReplace(reReplace(arguments.str, "\-", "+", "all"), "\_", "/", "all");
     writeLog(text = " Base64UrlUnescape " & base64String, file = "server",type="information");
    var padding = repeatstring("=",4 - len(base64String) mod 4);

    writeLog(text = " Base64UrlUnescape padding " & base64String & padding, file = "server",type="information");

    return base64String & padding;
  }
}