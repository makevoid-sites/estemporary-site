# app

gallery = $ ".fancy"
gallery.fancybox
  padding: 0
  maxWidth: "80%"
  helpers:
    overlay:
      css:
        background: 'rgba(200, 200, 200, 0.6)'

$ ->
  $("*[data-subnav]").on "click", (evt) ->
    name = $(evt.target).data "subnav"
    $("*[data-name='#{name}']").slideToggle()
