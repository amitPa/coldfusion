<link rel="stylesheet" type="text/css" href="resources/css/signin.css"/>
<cfinclude template = "header.cfm" runOnce = "true">
<script type="text/javascript">
	$(document).ready(function() {
 $('#signInForm').submit(function(event){

 	event.preventDefault();
 	debugger;
   $.ajax({type:"POST",
          url:"/DemoCFM/handlers/api/user.cfc?method=checkLogin",
          data:"username="+$('#inpEmail').val()+"&password="+$('#inpPassword').val(),
          async: false,
          success:function(data){
          var objectName=$.parseJSON(data);
          alert(objectName);
          if(objectName==="success")
           window.location="/DemoCFM/views/signup.cfm";
          },
          error:function(data){
          	alert(data);
          }
   	});
   	 	event.preventDefault();

   });
});
</script>
<div class="container" style="margin-top:40px">
	<div class="row">
		<div class="col-sm-6 col-md-4 col-md-offset-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<strong>
						Sign in to continue
					</strong>
				</div>
				<div class="panel-body">
					<form role="form" name="form" action="DemoCFM/handlers/api/user.cfc?method=checkLogin" id="signInForm" >
						<fieldset>
							<div class="row">
								<div class="center-block">
									<img class="profile-img"
										src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120" alt="">
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-10  col-md-offset-1 ">
									<div class="form-group">
										<div class="input-group">
											<span class="input-group-addon">
												<i class="glyphicon glyphicon-user">
												</i>
											</span>
											<input type="email" class="form-control" placeholder="Please enter Username" name="email" type="text" autofocus value="" id="inpEmail" title="Please enter the email" required>
										</div>
									</div>
									<div class="form-group">
										<div class="input-group">
											<span class="input-group-addon">
												<i class="glyphicon glyphicon-lock">
												</i>
											</span>
											<input class="form-control" placeholder="Password" name="password" type="password" value=""  id="inpPassword"  title="Please enter the password" required>
										</div>
									</div>
									<div class="form-group">
										<input type="submit" id="btnSubmit"class="btn btn-lg btn-primary btn-block" value="Sign in">
									</div>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
				<div class="panel-footer ">
					Don't have an account!
					<a href="##" onClick="">
						Sign Up Here
					</a>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<cfinclude template = "footer.cfm" runOnce = "true">
