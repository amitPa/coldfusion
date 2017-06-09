<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap-fusion.min.css"/>
		<link rel="stylesheet" type="text/css" href="../resources/css/booking.css"/>
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine">
		<title>
			Booking
		</title>
		<cfscript>

		</cfscript>
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
			</div>
			<main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3" id="booking">

			<cfscript>
			productId = url.productId;
			queryObj=createObject("Component", "DemoCfm.handlers.api.user");
			product=queryObj.booking(productId="#productId#");
			</cfscript>
			     <div class="row">
			<cfoutput>
				     <div class="col-sm-12 col-lg-6 col-md-6 text-center border">
				     <div class="row sp"><div class="col-sm-12 col-xs-12 text-center">	<img src="#product.URL#"  alt="Generic placeholder thumbnail"></img></div>
					 <div class="col-sm-12 text-center"><h1><strong>#product.NAME#</strong></h1></div>
					 </div>
					 <div class="row sp">
					<div class="col-sm-6 col-xs-6 text-center">
                       <a href="cart.cfm?type=purchased&productId=#productId#" class="btn btn-success" role="button"><strong>Purchase Now</strong></a>
					</div>
                    <div class="col-sm-6 col-xs-6 text-center">
                       <a href="cart.cfm?type=cart&productId=#productId#" class="btn btn-warning" role="button"><strong>Add to Cart </strong></a>
					</div>
					 </div>
					</div>
                     <div class="col-sm-12 col-lg-6  col-md-6 border">
					<div class="row sp">
					    <div class="col-sm-3 col-md-4"><strong>Name:</strong></div>
					    <div class="col-sm-9 col-md-8"><strong>#product.NAME#</strong></div>
					 </div>
					 <div class="row sp">
					   <div class="col-md-4 col-sm-3"><strong>Description:</strong></div>
					   <div class="col-md-8 col-sm-9"><strong>#product.DESCRIPTION#</strong></div>
					</div>
					<div class="row sp">
						 <div class="col-md-4 col-sm-3"><strong>Price:</strong></div>
						<div class="col-md-8 col-sm-9"><strong>#product.PRICE#</strong></div>
					</div>
					<div class="row sp">
						 <div class="col-md-4 col-sm-3"><strong>Summary:</strong></div>
						<div class="col-md-8 col-sm-9"><span>#product.SUMMARY#</span></div>
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
