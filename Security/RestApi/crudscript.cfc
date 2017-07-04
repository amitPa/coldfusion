/**
 * restscript
 *
 * @author Amit Pandey
 * @date 6/30/17
 **/
component rest="true" restpath="/crud" {



	remote string function checkCrud(string userid="" restargsource="path") returnFormat="json" produces="application/json" httpmethod="GET" restpath="{userid}" {

	   	var data = '{empName: "amitsdd", age:"26"}';
	   var serializedStr = serializeJSON(data);
	   return serializedStr;

  }

  remote string function createData() returnFormat="json" produces="application/json" httpmethod="POST" restpath="appp" {

    var  requestBody = toString( getHttpRequestData().content );
    var serializedStr = serializeJSON(requestBody);

   return serializedStr.user;
  }

  remote struct function createParseData(required struct data) returnFormat="json" produces="application/json" httpmethod="POST" restpath="struct/post" {
        var user=createObject('component', 'security.domain.user');
        writedump(user);
        user.setName(data.name);
        user.setPassword(data.password);
        writedump(user);
        //abort;
        data.uid = createUuid();
        return data;
  }


}