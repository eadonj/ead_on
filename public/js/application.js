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

// auto newsfeed
setInterval(function() {
 $.ajax({
   method: "get",
   url: '/urls',
 }).success(function(response){
  $('.newsfeed').children().remove();
 var results = response;
 for (var i in results) {
   $('.newsfeed').append('<li>' + '<a href="http://localhost:9393/posts/' + results[i]['url']['shortened_url'] + '/">' + results[i]['url']['shortened_url'] + '</a>')
 }
 });
}, 2000);

// go to log in single pagey
$('.login-link').on('click', function(e){
  e.preventDefault();
  var request = $.ajax({
    method: 'get',
    url: '/login'
  }).done(function(response){
    // console.log(response)
    $('.navbar').remove();
    $('.page-container').replaceWith(response);
  });
});

// log in single pagey
$('.login-form').on('submit', function(e){
  e.preventDefault();
  var request = $.ajax({
    method: 'post',
    url: '/login',
    data: $(this).serialize()
  }).success(function(response){
    $('.navbar').remove();
    $('.page-container').replaceWith(response);
    $('.messages').fadeOut(2000);
    }
  );
});

// log out single pagey
$('.logout').on('click', function(e){
  e.preventDefault();
  var request = $.ajax({
    method: 'get',
    url: '/logout'
  }).done(function(response){
    $('.navbar').remove();
    $('.page-container').replaceWith(response);
  });
});

// move to signup page single pagey
$('.signup-link').on('click', function(e){
  e.preventDefault();
  var request = $.ajax({
    method: 'get',
    url: '/users/new'
  }).done(function(response){
    $('.navbar').remove();
    $('.page-container').replaceWith(response);
  });
});









}); // for document ready

