// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require highcharts
//= require highcharts/highcharts-more
//= require highcharts/modules/drilldown
//= require bootstrap-sprockets
//= require bootstrap-datepicker

var flash = function() {
  setTimeout(function() {
    $(".hide-flash").fadeOut("normal");
  }, 3000);
}

var datepicker = function() {
  $(".datepicker").datepicker({
    inline: true,
    sideBySide: true,
    todayHighlight: true,
    showButtonPanel: true,
    format: "yyyy-mm-dd",
  }).on("changeDate", function(ev){
    $(this).datepicker("hide");
  });
}

var disabled_link = function() {
  $("a[disabled=disabled]").click(function(event){
    return false;
  });
}

$(document).on("ready", disabled_link);
$(document).on("page:update", disabled_link);
$(document).on("ready", flash);
$(document).on("page:update", flash);
$(document).on("page:update", datepicker);
