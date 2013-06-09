$(document).ready(function() {

  $(".url_form").on('submit',function(e){
   e.preventDefault();
   var getUrl = $.ajax({
    method: "POST",
    url: '/urls',
    data: $(this).serialize()
  });
   console.log("hello");
   getUrl.done(printResponse);
 });

  function printResponse(response) {
    console.log("hello2");
    console.log(response);


    $("#results").empty();
    if(response == 'This is an error message')
    {
     $("#results").append(response); 
   } else
   {
    $("#results").append('http://localhost:9393/urls/' + response['url']['shortened_url']);
    $("#url_input").val("");
  }
  };

  $("#login_button").on('click', function(e){
    e.preventDefault();
    $("#login-box").fadeIn();
    $("#login-box").mouseleave(function(){
      $("#login-box").fadeOut(500);
    });
  });

  $("#signup_button").on('click', function(e){
    e.preventDefault();
    $("#signup-box").fadeIn();
    $("#signup-box").mouseleave(function(){
      $("#signup-box").fadeOut(500);
    });
  });
}); // for document ready
