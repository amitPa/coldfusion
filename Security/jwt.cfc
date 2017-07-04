component output=false{

	public string function grantToken(required string userID) {

	var payload = {
		"iss" = "https://myapi",
		"exp" = dateAdd("n",tokenExpiration,now()),
		"sub" = userID
	};

	/* Encode the data structure as a json web token */
	return jwt.encode(payload,"HS512");
 }

}