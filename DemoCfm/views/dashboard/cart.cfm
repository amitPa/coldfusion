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
						<a class="nav-link" href="#">
							Booking
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link  active" href="#">
							Cart
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
			queryObj=createObject("Component", "DemoCfm.handlers.api.user");
			product=queryObj.getCart();
			</cfscript>

  <table class="table table-striped">
    <thead>
      <tr>
        <th>Product</th>
        <th>Description</th>
        <th>Name</th>
		<th>Price</th>
		<th>Purchase</th>
      </tr>
    </thead>
		<cfoutput>
       <cfif product.recordcount && product.paid EQ 0 >
		<tbody>
      <tr>
        <td colspan="5"  class="text-center"><h2>Items in Cart</h2></td>
		<td><img src="#product.URL#" alt="Generic placeholder thumbnail" style="height:200px ;width:auto;"></td>
        <td>#product.DESCRIPTION#</td>
		<td>#product.NAME#</td>
        <td>#product.PRICE#</td>
		<td><a href="##" class="btn btn-success" role="button"><strong>Purchase Now</strong></a></td>
	 </tr>
	 </tbody>
	   <cfelse>
	   <tbody>
	 <tr>
		<td colspan="5"  class="text-center"><h2>Your have zero items in your cart</h2></td>
	 </tr>
	   </tbody>
	  </cfif>
       <cfif product.recordcount && product.paid > 0 >
		<tbody>
	 <tr>
	    <td colspan="5"  class="text-center"><h2>Items Purchased</h2></td>
		<td><img src="#product.URL#" alt="Generic placeholder thumbnail" style="height:200px ;width:auto;"></td>
        <td>#product.DESCRIPTION#</td>
		<td>#product.NAME#</td>
        <td>#product.PRICE#</td>
		<td><a href="##" class="btn btn-success" role="button"><strong>Purchase Now</strong></a></td>
     </tr>
	   </tbody>
      <cfelse>
	  <tbody>
	 <tr>
		<td colspan="5"  class="text-center"><h2>You have purchased zero items </h2></td>
	 </tr>
	  </tbody>
	 </cfif>
      </cfoutput>
    </tbody>
  </table>
</main>

</body>
</html>
