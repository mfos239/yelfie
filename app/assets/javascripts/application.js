// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap.min
//= require mustache
//= require waterfall.min
//= require jquery.raty.min
//= require_tree .

var ready = function() {
    var $body = $("body");
    var controller = $body.data("controller").replace(/\//g, "_");
    var action = $body.data("action");

    var activeController = App[controller];
    if (activeController !== undefined) {
        if ($.isFunction(activeController.init)) {
            activeController.init();
        }

        if ($.isFunction(activeController[action])) {
            activeController[action]();
        }
    }

    $(window).bind('beforeunload', function(e) {
        if(window.dirty == 1) {
            return "You have unsaved changes that will be lost if you leave the page without saving.";
        }
    });
    $('form input[type=submit]').click(function(e) {window.dirty = false});

};

$(document).ready(ready);
$(document).on("page:load", ready);