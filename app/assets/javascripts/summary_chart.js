var summary_chart = function (container, json_data) {
  if($(container).length > 0) {
    $(container).highcharts({
      chart: {
          plotBackgroundColor: null,
          plotBorderWidth: null,
          plotShadow: false,
          type: 'pie'
      },
      title: {
          text: ""
      },
      tooltip: {
        pointFormat: "<b> ${point.y:###,0.1f}<br/>"
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: false
          },
          showInLegend: true
        }
      },
      series: [{
          name: "Brands",
          colorByPoint: true,
          data:  json_data
      }]
    });
  }
}

$(document).on("page:update",function(){
  summary_chart(".daily-chart", $(".daily-chart").data("chart"));
  summary_chart(".monthly-chart", $(".monthly-chart").data("chart"));
  summary_chart(".yearly-chart", $(".yearly-chart").data("chart"));
});
