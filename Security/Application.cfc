/**
 * Application
 *
 * @author Amit Pandey
 * @date 5/30/17
 **/
component accessors=true output=false persistent=false {

    this.name="Security2";
	  this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0 );
    this.datasource="ecommerce" ;



      function onApplicationStart() {
       application.myName = 'Security';
       application.myPosition = 'A Developer';
       
       
      // application.utilities = CreateObject('cfc.utilities');
		   return true;
      }



}