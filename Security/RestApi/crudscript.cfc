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
        var prop=createObject('component', 'security.domain.prop');
        writedump(user);
        user.setName(data.name);
        user.setPassword(data.password);
        user.setPhone(data.phone);
        prop.setName("amit");
        prop.setId("5");
        user.setProp(prop);
        //abort;
        data.uid = createUuid();
        return user;
  }


    remote string function getPageNumber(required numeric rowEnd=0 restargsource="query",required numeric rowStart=0 restargsource="query") returnFormat="json" produces="application/json" httpmethod="GET" restpath="list"  {

   var returnpath =rowStart & rowEnd;

   return returnpath;
  }

  remote Array function getPaginatedData(required numeric pageNumber=0 restargsource="query") returnFormat="json" produces="application/json" httpmethod="GET" restpath="list/pagination"  {

    var auth=createObject('component', 'security.Util.Authorization');
        if(!auth.verifyHeader()){
           throw(type="Authorization Header" ,message=" Authorization header is not passed ");
        }

   var pageSize=10;
 try{
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
        return array;
    }
    }catch(Any e){
      writeLog(text = " Error in creating file  " & toString(e), application = "no", file = "test");
    }
   return ArrayNew(1);
}

 remote any function getPaginatedDataQuery(required numeric pageNumber=0 restargsource="query") returnFormat="json" produces="application/json" httpmethod="GET" restpath="list/page"  {

  writeLog(text = " Hitting list/page api " , file = "test");
  try{
      var auth=createObject('component', 'security.Util.Authorization');
        if(!auth.verifyHeader()){
           throw(type="Authorization Header" ,message=" Authorization header is not passed ");
        }
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
    writeLog(text = " Hitting offset " & offset & " pageSize " & pageSize, file = "test");
    var newQry = new Query();

    
    newQry.setSQL("select * From basket LIMIT " & pageSize & " Offset " & offset);

     writeLog(text = " Hitting offset " & offset & " pageSize " & pageSize, file = "test");
      writelog(text = "creating file  " & myFile, application = "no", file = "test");
    qryNewRes=newQry.execute();
      writelog(text = "creating file  " & myFile, application = "no", file = "test");
     myFile = expandPath("/myFiles.json"); 
     writelog(text = "creating file  " & myFile, application = "no", file = "test");
     data = "I'm going to create a file object";
     FileWrite( myFile, serializeJSON(qryNewRes.getResult()));
     newFileObj = FileRead( "fileObj" );
     writeDump(var=newFileObj);
     // OR write direct to filemyFile = expandPath( "somefile.txt" );
     //data = "I'm going to write to direct to file";
    // FileWrite(myFile, data);

       return qryNewRes.getResult();
    }catch(Any e){
       writeLog(text = " Error in creating file  " & toString(e), application = "no", file = "test");
       return new Query();
    }


}

  remote string function postBatchData(required array data) produces="application/json" httpmethod="POST" restpath="struct/batchPost" {
       
          writeLog(text = " hitting PostBatchData Api", application = "no", file = "server");

        var auth=createObject('component', 'security.Util.Authorization');
        writeLog(text = " hitting PostBatchData Api auth ", application = "no", file = "server");
        if(!auth.verifyHeader()){
           var stri = '{responseCode: "500", reason:"Token is required"}';
           return serializeJSON(stri);
        }

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

      return serializeJSON(stri);

     }
     catch(any e){
         var stri = '{responseCode: "500", reason:"' & toString(e) & '"}';
         variables.objDataCon.rollback();
         return serializeJSON(stri);
       writedump(e);
     }
  }

  remote struct function postData(required struct data) returnFormat="json" produces="application/json" httpmethod="POST" restpath="struct/signIn" {

   writeLog(text = " hitting SignIn Api", application = "no", file = "server");

      try{
      var jwt=createObject('component', 'security.JwtSecurity.jwt');
          writeLog(text = " hitting SignIn Api f", application = "no", file = "server");
        var token=jwt.encode(data);
      }
      catch(any e){
      var stri={
       responseCode: "500",
       reason:" failed to encode token " & toString(e)
      };

      return stri;

      }
       var stri={
       responseCode: "200",
       token:token
      };

      return stri;
  }

  remote any function jsonFeed() returnFormat="json" produces="application/json" httpmethod="GET" restpath="jsonfeed"{

    var query= new Query();
    query.setSQL("CALL `partner-portal-db`.amitp()");
    qryNewRes=query.execute();
     try{
    var myFile = expandPath("mytryFiles.json"); 
     writelog(text = "creating file  " & myFile, application = "no", file = "test");
     data = "I'm going to create a file object";
     var array=arrayNew(1);
    for(rowS in qryNewRes.getResult()){
      str.company=rowS.company;
      str.companyNew=rowS.companyNew;
      ArrayAppend(array,rowS);
    }
     var structData=qryNewRes.getResult();
     FileWrite( myFile, serializeJson(deserializeJSON(serializeJSON(structData)).DATA));

      var myFileN = expandPath("mytryFilesNew.json"); 
      FileWrite( myFileN, serializeJSON(structData));

        var myFileArray = expandPath("mytryFilesArray.json"); 
      FileWrite( myFileArray, serializeJSON(array)); 

      newFileObj = FileRead( myFile );
     } catch(Any e){
       writeLog(text = " hitting jsonfeed apis", application = "no", file = "test");
      var stri={
       responseCode: "200",
       response:"File write failed " & e
      };
     return stri;
     }
       var stri={
       responseCode: "200",
       response:"File not written"
      };
     return stri;


  }
}