/**
 * restscript
 *
 * @author Amit Pandey
 * @date 6/30/17
 **/
component rest="true" restpath="/crud" {

remote string function checkCrud(string userid="" restargsource="path") returnFormat="json" produces="application/json" httpmethod="GET" restpath="{userid}" {

   	var data = '{empName: "#userid#", age:"26"}';
   var serializedStr = serializeJSON(data);
   return serializedStr;

  }
}