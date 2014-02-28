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
}