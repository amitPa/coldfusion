/**
 * Application
 *
 * @author Amit Pandey
 * @date 5/30/17
 **/
component accessors=true output=false persistent=false {
    this.name="DemoCfm";
	this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0 );
	this.sessionManagement=true;

	this.datasource="ecommerce" ;
		this.sessionTimeout = CreateTimeSpan(0, 0, 30,  0);
    this.ormEnabled = true ;
    this.ormSettings = { logsql=true,
    	                dbcreate="update"
    	               };

    this.invokeImplicitAccessor =  true;


      function onApplicationStart() {
       application.myName = 'Amit';
       application.myPosition = 'A Developer';
      // application.utilities = CreateObject('cfc.utilities');
		return true;
      }

      function onRequestStart(string targetName){
      	if(structKeyExists(url,'reload')){
      		onApplicationStart();

      	}
      }

      function onRequest(String targetName){
      	var loginUrl="/DemoCFM/views/login.cfm";
      	var signupUrl="/DemoCFM/views/signup.cfm";
      	if(structKeyExists(session,"authenticated")){
      	 if(targetName==loginUrl)
             location(url="/DemoCFM/views/dashboard/dashboard.cfm",addtoken = false);
         else
         include targetName;
      	}

      	else {
      		sessionInvalidate();
      		if(targetName==loginUrl ||targetName==signupUrl )
      		include targetName;
            else{
            	 location(loginUrl);
            }
      	}
      }

       function onMissingTemplate(){
      		 location(url="/DemoCFM/views/login.cfm",addtoken = false);
      	}
}