<cfinclude template = "header.cfm" runOnce = "true">
<link rel="stylesheet" type="text/css" href="../resources/css/heroic.css"/>
<title>
	Dashboard
</title>
</head>
<body>
<cfquery name="ecom" datasource="ecommerce">
SELECT
name,
description,
price,
url
FROM
product
ORDER BY
name DESC
</cfquery>
	<!-- Navigation -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">
						Toggle navigation
					</span>
					<span class="icon-bar">
					</span>
					<span class="icon-bar">
					</span>
					<span class="icon-bar">
					</span>
				</button>
				<a class="navbar-brand" href="#">
					Cart
				</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li>
						<a href="#">
							About
						</a>
					</li>
					<li>
						<a href="#">
							Services
						</a>
					</li>
					<li>
						<a href="#">
							Contact
						</a>
					</li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<!-- Page Content -->
	<div class="container">
		<!-- Jumbotron Header -->
		<header class="jumbotron hero-spacer">
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
		<div class="row text-center">
<cfoutput>
		<cfloop query="ecom">
			<div class="col-md-3 col-sm-6 hero-feature">
				<div class="thumbnail">
					<img src="#ecom.url#" alt="">
					<div class="caption">
						<h3>
							#ecom.name#
						</h3>
						<p>
							#ecom.description#
						</p>
						<p>
							<a href="##" class="btn btn-primary">
								Buy Now!
							</a>
							<a href="##" class="btn btn-default">
								More Info
							</a>
						</p>
					</div>
				</div>
			</div>
		</cfloop>
</cfoutput>
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
