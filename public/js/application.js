$(document).ready(function() {


 $(".url_form").on("submit", function(e){
    e.preventDefault();
    var request = $.ajax({
        method: "POST",
        url: '/urls',
        data: $(this).serialize()
    }).done(function(response){
      $(".url_container").empty();
      if(response == 'This is an error message')
      {
       $(".url_container").append(response); 
      } else
      {
        $(".url_container").append('http://localhost:9393/urls/' + response['url']['shortened_url']);
      }
    }); //for done
  }); // for form


 
}); // for document ready
