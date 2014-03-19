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
  var photo = document.forms["listingform"]["photo"].value;
	if (photo == null || photo == "") {
		alert("Please specify a valid photo.");
	  return false;
  }
}

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
}