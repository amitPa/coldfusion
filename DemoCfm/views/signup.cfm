<cfinclude template = "header.cfm" runOnce = "true">
<link rel="stylesheet" type="text/css" href="resources/css/signup.css"/>
<script type="text/javascript">

    function check(input) {
        if (input.value != document.getElementById('inpPassword').value) {
            input.setCustomValidity('Password Must be Matching.');
        } else {
            // input is valid -- reset the error message
            input.setCustomValidity('');
        }
    }

	$(document).ready(function() {

 $('#signUpForm').submit(function(event){
 	 	event.preventDefault();
 	debugger;
   $.ajax({type:"POST",
          url:"/DemoCFM/handlers/api/user.cfc?method=signup",
          data:"email="+$('#inpEmail').val()+"&password="+$('#inpPassword').val()+"&firstname="+$('#inpFirstName').val()+"&lastname="+$('#inpLastName').val()+"&contact="+$('#inpContact').val(),
          async: false,
          success:function(data){
          var objectName=$.parseJSON(data);
          alert(objectName);
          if(objectName==="success")
           window.location="/DemoCFM/views/login.cfm";
          },
          error:function(data){
          	alert(data);
          	return false;
          }
   	});

   });

});
</script>
<div class="container">
	<div class="row centered-form">
		<div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						Please sign up for BlogPost
						<small>
							It's free!
						</small>
					</h3>
				</div>
				<div class="panel-body">
					<form role="form" id="signUpForm">
						<div class="row">
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<input type="text" name="first_name" id="inpFirstName" class="form-control input-sm" placeholder="First Name"  required>
								</div>
							</div>
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<input type="text" name="last_name" id="inpLastName" class="form-control input-sm" placeholder="Last Name"  required>
								</div>
							</div>
						</div>
						<div class="form-group">
							<input type="email" name="email" id="inpEmail" class="form-control input-sm" placeholder="Email Address"  required>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Please enter contact" name="contact"  autofocus value="" id="inpContact" title="Please enter the contact" required>
						</div>
						<div class="row">
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<input type="password" name="password" id="inpPassword" class="form-control input-sm" placeholder="Password"  required>
								</div>
							</div>
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<input type="password" name="password_confirmation" id="password_confirmation" class="form-control input-sm" placeholder="Confirm Password" required oninput="check(this)">
								</div>
							</div>
							<p id="pPassword" style="display:none;color:red">
								Passwords do not match
							</p>
						</div>
						<input type="submit" value="Register" class="btn btn-info btn-block">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<cfinclude template = "footer.cfm" runOnce = "true">
