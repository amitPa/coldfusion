<link rel="stylesheet" type="text/css" href="resources/css/signin.css"/>
<cfinclude template = "header.cfm" runOnce = "true">

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
					<form role="form" name="form" action="checklogin.cfm" method="POST">
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
											<input class="form-control" placeholder="Username" name="name" type="text" autofocus value="#form.name#">
										</div>
									</div>
									<div class="form-group">
										<div class="input-group">
											<span class="input-group-addon">
												<i class="glyphicon glyphicon-lock">
												</i>
											</span>
											<input class="form-control" placeholder="Password" name="password" type="password" value="#form.password#">
										</div>
									</div>
									<div class="form-group">
										<input type="submit" class="btn btn-lg btn-primary btn-block" value="Sign in">
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
