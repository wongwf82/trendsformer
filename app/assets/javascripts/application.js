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
//= require jquery.jqplot
//= require jqplot.dateAxisRenderer
//= require jqplot.highlighter
//= require jqplot.trendline

//= require bootstrap
//= require turbolinks

jQuery(document).ready(function($) {

    // This disable submiting the form with the ENTER key only for inputs and selects
    $('input,select').keydown(function(event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

});