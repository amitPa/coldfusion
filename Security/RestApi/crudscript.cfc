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


    remote string function getPageNumber(required numeric rowEnd=0 restargsource="query",required numeric rowStart=0 restargsource="query") returnFormat="json" produces="application/json" httpmethod="GET" restpath="list"  {

   var returnpath =rowStart & rowEnd;

   return returnpath;
  }

  remote Array function getPaginatedData(required numeric pageNumber=0 restargsource="query") returnFormat="json" produces="application/json" httpmethod="GET" restpath="list/pagination"  {

   var pageSize=10;

    var myQry = new Query();
    myQry.setSQL("select count(id) as idr From basket"); //set query
    qryRes = myQry.execute(); 
    var recordCount=qryRes.getResult().idr[1];
    //Calculate offset
    var offset=(pageNumber-1)*pageSize;

    if(offset>recordCount){
      offset=recordCount-(recordCount%pageSize);
    }

    var newQry = new Query();
    newQry.setSQL("select * From basket LIMIT " & pageSize & " Offset " & offset);
    writedump(newQry);
    qryNewRes=newQry.execute();
    writedump(qryNewRes);

    var array = ArrayNew(1);
    var str=structNew();
    
    for(rowS in qryNewRes.getResult()){
      str.id=rowS.id;
      str.originalAmount=rowS.original_basket_amount;
      str.discountedAmount=rowS.DISCOUNTED_BASKET_AMOUNT;
      ArrayAppend(array,str);
    }

   return array;

}


 remote query function getPaginatedDataQuery(required numeric pageNumber=0 restargsource="query") returnFormat="json" produces="application/json" httpmethod="GET" restpath="list/page"  {

   var pageSize=10;

    var myQry = new Query();
    myQry.setSQL("select count(id) as idr From basket"); //set query
    qryRes = myQry.execute(); 
    var recordCount=qryRes.getResult().idr[1];
    //Calculate offset
    var offset=(pageNumber-1)*pageSize;

    if(offset>recordCount){
      offset=recordCount-(recordCount%pageSize);
    }

    var newQry = new Query();
    newQry.setSQL("select * From basket LIMIT " & pageSize & " Offset " & offset);

    qryNewRes=newQry.execute();


   return qryNewRes.getResult();

}


}