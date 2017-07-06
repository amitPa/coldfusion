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


  remote string function postBatchData(required array data) produces="application/json" httpmethod="POST" restpath="struct/batchPost" {

     var stri = '{empName: "amitsdd", age:"26"}';

      try{

        variables.count = 1;
        variables.totalNumberOfRecords = arrayLen(data);
        variables.countLimit = 2;
        variables.noOfBatch = Ceiling(variables.totalNumberOfRecords / variables.countLimit);
        variables.objFactory = CreateObject("java","coldfusion.server.ServiceFactory");
        // get connection object
        variables.objDataCon = variables.objFactory.getDataSourceService().getDatasource("ecommerce").getConnection();

        variables.objDataCon.setAutoCommit(false);

        // set sql statement
        variables.sql = "INSERT INTO demotable(name,data) VALUES(?,?)";
        variables.sqlStatement = variables.objDataCon.prepareStatement(variables.sql);
        variables.flag=true;

     //Process Batch Request
     for (i=1;i<=variables.noOfBatch;i++){
       writeLog(text = "Batch " & i , type = "information", application = "no", file = "server");
       variables.countLimit=IIF((i*variables.countLimit > variables.totalNumberOfRecords),variables.totalNumberOfRecords,i*variables.countLimit);
       writeLog(text = "CountLimit " & variables.countLimit, type = "information", application = "no", file = "server");

        //Adding data in Batches
        for(j=variables.count;j<=variables.countLimit; j++){
              writeLog(text = "Index " & j & data[j].name & data[j].pass, type = "information", application = "no", file = "server");
            variables.sqlStatement.setString(1,data[j].name);
            variables.sqlStatement.setString(2,data[j].pass);
            variables.sqlStatement.addBatch();

       }

       writedump(variables);
       variables.updateCounts = variables.sqlStatement.executeBatch();

       variables.sqlStatement.clearBatch();

       // increse counter
       variables.count = variables.countLimit+1;
    }
      variables.objDataCon.commit();

     if(variables.flag){
      variables.objDataCon.commit();
      var stri = '{responseCode: "200", age:"Operation Successful"}';
     }else{
        var stri = '{responseCode: "500", age:"Operation Failed"}';
     }

    var serializedStr = serializeJSON(stri);
     return serializedStr;
     }
     catch(any e){
         var stri = '{responseCode: "500", reason:"' & toString(e) & '"}';
         variables.objDataCon.rollback();
         return serializeJSON(stri);
       writedump(e);
     }
  }

}