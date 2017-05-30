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

	this.datasource="blog_test" ;
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
      		ormReload();
      }
}