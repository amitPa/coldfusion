<html>
	<head>
	    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
		<script src="https://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
		<script type="text/javascript">

   function getData(){
    $.ajax({type:"GET",
         url:"http://localhost/rest/amit/crud/list/pagination",
         data:"pageNumber="+2,
         async: false,
         success:function(data){
         var objectName=$.parseJSON(data);
         alert("success");

         },
         error:function(data){
          alert("fail");
          return false;
         }
       });
    }



    </script>
		</script>
	</head>
	<body>
		<div class="container">

			<h1>
				Hello World
			</h1>
			<input type="button" onclick="getData()" value="submit">
			<h2 style="color:red">
				Helllooo
			</h2>
			<cfscript>
			  xmlParse=createObject("component","XmlParsing.ReadXml");
			  writedump(xmlParse.readXml());
			</cfscript>
		</div>
	</body>
</html>
