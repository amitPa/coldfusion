/**
 * restscript
 *
 * @author Amit Pandey
 * @date 6/30/17
 **/
component output=false {

 any function readXml(){
   myxmldoc = XmlParse("E:\workspace\CFEclipse\Security\BookStore.xml");
   selectedElements = XmlSearch(myxmldoc, "/client/table/");
   var array=arrayNew(1);
    for(table in selectedElements){
     query=" ";
      tableValue=table.xmlattributes;
      if(tableValue.isRequired=="true"){
       stringColumn=" ";
       for(columns in table.xmlchildren){
          if(columns.xmlattributes.isrequired=="true"){

            stringColumn=stringColumn & 'CONCAT("{"," ' & columns.xmlText & ' ~~",coalesce(concat("\"",trim(' & columns.xmlText & '),"\""),"\"\"") ,"}"), ';

          }

       }

   stringColumn = rereplace( stringColumn , ',(?=[^,]+$)' , '' );
          query="SELECT " & stringColumn &
                    "FROM " & tableValue.name & ";" ;
         arrayAppend(array,query);
     }
    }
      return array;
  }

}