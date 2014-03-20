/////////////////////////////////////////////////
//
// formvalidation.js
//
// This document contains javascript code to cover
// basic form validation.
//
/////////////////////////////////////////////////



/////////////////////////////////////////////////
// REQUeST NEW CITY
// Form location: views/listings/req.html.erb
/////////////////////////////////////////////////
function validateNewCityForm() {
	alert("We've received your request, and we'll work on it as soon as possible. Thank you!");
}

/////////////////////////////////////////////////
// CREATE LISTING
// Form location: views/listings/create.html.erb
/////////////////////////////////////////////////
function validateListingForm() {
	var name = document.forms["listingform"]["name"].value;
	if (name == null || name == "") {
		alert("Listing name must be filled out.");
	  return false;
  }
  var description = document.forms["listingform"]["description"].value;
	if (description == null || description == "") {
		alert("Review description must be filled out.");
	  return false;
  }
  var address = document.forms["listingform"]["address"].value;
	if (address == null || address == "") {
		alert("Address must be filled out.");
	  return false;
  }
  var dates = document.forms["listingform"]["dates"].value;
	if (dates == null || dates == "") {
		alert("At least one date must be specified.");
	  return false;
  }
  var photo = document.forms["listingform"]["photo"].value;
	if (photo == null || photo == "") {
		alert("Please specify a valid photo.");
	  return false;
  }
}

/////////////////////////////////////////////////
// EDIT LISTING
// Form location: views/listings/edit.html.erb
/////////////////////////////////////////////////
function validateListingFormEdit() {
	var name = document.forms["listingform"]["name"].value;
	if (name == null || name == "") {
		alert("Listing name must be filled out.");
	  return false;
  }
  var description = document.forms["listingform"]["description"].value;
	if (description == null || description == "") {
		alert("Review description must be filled out.");
	  return false;
  }
  var address = document.forms["listingform"]["address"].value;
	if (address == null || address == "") {
		alert("Address must be filled out.");
	  return false;
  }
  var dates = document.forms["listingform"]["dates"].value;
	if (dates == null || dates == "") {
		alert("At least one date must be specified.");
	  return false;
  }
}

/////////////////////////////////////////////////
// CREATE REVIEW
// Form location: views/listings/review.html.erb
/////////////////////////////////////////////////
function validateReviewForm() {
	var title = document.forms["reviewform"]["title"].value;
	if (title == null || title == "") {
		alert("Review title must be filled out.");
	  return false;
  }
	var rating = document.forms["reviewform"]["rating"].value;
	if (rating == null || rating == "" || rating == 0) {
		alert("Rating must given.");
	  return false;
  }
  var description = document.forms["reviewform"]["description"].value;
	if (description == null || description == "") {
		alert("Review description must be filled out.");
	  return false;
  }
}

/////////////////////////////////////////////////
// EDIT PROFILE
// Form location: views/user/edit.html.erb
/////////////////////////////////////////////////
function validateProfileForm() {
	var email = document.forms["listingform"]["email"].value;
	if (email == null || email == "") {
		alert("Email must be filled out.");
	  return false;
  }
  var bio = document.forms["listingform"]["bio"].value;
	if (bio == null || bio == "") {
		alert("User bio must be filled out.");
	  return false;
  }
}