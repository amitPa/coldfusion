<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap-fusion.min.css"/>
		<link rel="stylesheet" type="text/css" href="../resources/css/booking.css"/>
		<title>
			Booking
		</title>
		<cfscript>

		</cfscript>
	   <style type="text/css">
			.sp{
			padding-top:20px;
			}
		</style>
	</head>
	<body>
		<!-- Navigation -->
	<nav class="navbar navbar-toggleable-md navbar-inverse fixed-top bg-inverse">
			<button class="navbar-toggler navbar-toggler-right hidden-lg-up" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon">
					Dashboard
				</span>
			</button>
			<a class="navbar-brand" href="##">
				Fusion Cart
			</a>
			<div class="collapse navbar-collapse" id="navbarsExampleDefault">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="#">
							Home
							<span class="sr-only">
								(current)
							</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">
							Settings
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">
							Profile
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">
							Help
						</a>
					</li>
				</ul>
				<form class="form-inline mt-2 mt-md-0">
					<input class="form-control mr-sm-2" type="text" placeholder="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">
						Search
					</button>
				</form>
			</div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<nav class="col-sm-3 col-md-2 hidden-xs-down bg-faded sidebar">
				<ul class="nav nav-pills flex-column">
					<li class="nav-item">
						<a class="nav-link" href="#">
							Overview
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active" href="#">
							Booking
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">
							Analytics
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">
							Export
						</a>
					</li>
				</ul>
			</div><a href="../../handlers/api/user.cfc"></a>
					<main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3">
			<div class="row">
			<cfscript>
			productId = url.productId;
			queryObj=createObject("Component", "DemoCfm.handlers.api.user");
			product=queryObj.booking(productId="#productId#");
			</cfscript>
			<cfoutput>
				     <div class="col-sm-6  text-center">
				     <div class="row sp"><div class="col-sm-12 text-center">	<img src="#product.URL#"  style="height:300px ;width:auto;"></img></div>
					 <div class="col-sm-12 text-center"><h1><strong>#product.NAME#</strong></h1></div>
					 </div>
					</div>
                     <div class="col-sm-6">
					<div class="row sp">
					    <div class="col-sm-4"><strong>Name:</strong></div>
					    <div class="col-sm-8"><span>#product.NAME#</span></div>
					 </div>
					 <div class="row sp">
					   <div class="col-sm-4"><span><strong>Description:</strong></span></div>
					   <div class="col-sm-8"><span>#product.DESCRIPTION#</span></div>
					</div>
					<div class="row sp">
						 <div class="col-sm-4"><span><strong>Price:</strong></span></div>
						<div class="col-sm-8"><span>#product.PRICE#</span></div>
					</div>
					</div>
            </cfoutput>
			</div>
		</main>


		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p>
					</p>
				</div>
			</div>
			<script src="../resources/js/jquery.js"></script>
			<!-- Bootstrap Core JavaScript -->
			<script src="../resources/bootstrap.min.js"></script>
		</footer>
			</div>
		<!-- /.container -->
		<!-- jQuery -->
		<cfinclude template = "footer.cfm" runOnce = "true">
