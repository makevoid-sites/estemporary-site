(function() {
  var gallery;

  gallery = $(".fancy");

  gallery.fancybox({
    padding: 0,
    maxWidth: "80%",
    helpers: {
      overlay: {
        css: {
          background: 'rgba(200, 200, 200, 0.6)'
        }
      }
    }
  });

  $(function() {
    return $("*[data-subnav]").on("click", function(evt) {
      var name;
      name = $(evt.target).data("subnav");
      return $("*[data-name='" + name + "']").slideToggle();
    });
  });

}).call(this);
