# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class YelpersController

  new: ->
    init_form()

  create: ->
    init_form()

  show: ->

    init_form()

    $('.waterfall-container').waterfall
      itemCls: 'item',
      colWidth: 250,
      gutterWidth: 15,
      gutterHeight: 15,
      checkImagesLoaded: false,
      path: (page) ->
        return "/yelpers/" + $('.waterfall-container').data("yelper-id") + '/reviews/?page=' + page
      ,
      callbacks: {

        loadingFinished: ($loading, isBeyondMaxPage) ->

          $("div.rating").raty(
            readOnly: true,
            hints: ['1 stars', '2 stars', '3 stars', '4 stars', '5 stars'],
            path: '/assets/raty',
            score: () ->
              return $(this).attr('data-number')
          )


          if !isBeyondMaxPage
            $loading.fadeOut();
          else
            $loading.remove();
        ,
        renderData: (data) ->
          if data.total == 0
            $('.waterfall-container').waterfall('pause')
          template = $('#waterfall-tpl').html();
          return data.reviews
      }

  init_form = ->
    $("#new_yelper .btn").click(() ->
      $btn = $(this)
      $btn.button('loading')
    )

this.App.yelpers = new YelpersController
