<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap-fusion.min.css"/>
		<link rel="stylesheet" type="text/css" href="../resources/css/heroic.css"/>
		<link rel="stylesheet" type="text/css" href="../resources/css/booking.css"/>
		<link rel="stylesheet" type="text/css" href="../resources/css/dashboard.css"/>
		<title>
			Booking
		</title>
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
				<cfquery name="ecom" datasource="ecommerce">
SELECT
name,
description,
price,
url,
product_id as productId
FROM
product
ORDER BY
name DESC
</cfquery>
				<nav class="col-sm-3 col-md-2 hidden-xs-down bg-faded sidebar">
					<ul class="nav nav-pills flex-column">
						<li class="nav-item">
							<a class="nav-link active" href="#">
								Overview
								<span class="sr-only">
									(current)
								</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">
								Reports
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
				</nav>
				<main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3">
					<!-- Jumbotron Header -->
					<header class="jumbotron">
						<h1>
							Fusion Cart!
						</h1>
						<p>
							Welcome to the summer sale
						</p>
						<p>
							<a class="btn btn-primary btn-large">
								Call to action!
							</a>
						</p>
					</header>
					<hr>
					<!-- Title -->
					<div class="row">
						<div class="col-lg-12">
							<h3>
								Product
							</h3>
						</div>
					</div>
					<!-- /.row -->
					<!-- Page Features -->
					<section class="row text-center placeholders">
						<cfoutput>
							<cfloop query="ecom">
								<div class="col-xs-6 col-sm-4 col-lg-4  placeholder">
									<img src="#ecom.url#" alt="Generic placeholder thumbnail" style="height:200px ;width:auto;">
									<div class="caption">
										<h3>
											#ecom.name#
										</h3>
										<p>
											#ecom.description#
										</p>
										<p>
											<a href="booking.cfm?productId=#ecom.productId#" class="btn btn-primary">
												Buy Now!
											</a>
											<a href="##" class="btn btn-default">
												More Info
											</a>
										</p>
									</div>
								</div>
							</cfloop>
						</cfoutput>
					</section>
				</main>
			</div>
		</div>
		<!-- /.row -->
		<hr>
		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p>
						Copyright &copy; Your Website 2014
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
