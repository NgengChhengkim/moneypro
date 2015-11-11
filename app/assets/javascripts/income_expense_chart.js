var chart_result = function (container) {
    container.highcharts({
        chart: {
            type: "column"
        },
        title: {
            text: container.data("type")
        },
        subtitle: {
            text: ""
        },
        xAxis: {
            type: "category"
        },
        yAxis: {
            title: {
                text: "Amount (Dollars)"
            }

        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    format: "${point.y:###,0.1f}"
                }
            }
        },

        tooltip: {
            headerFormat: "<span style='font-size:11px'>{series.name}</span><br>",
            pointFormat: "<span style='color:{point.color}'>{point.name}</span>: <b>${point.y:###,0.1f}<br/>"
        },

        series: [{
            name: container.data("type"),
            colorByPoint: true,
            data: container.data("chart")
        }],
        drilldown: {
            series: container.data("drilldown")
        }
    });
}

$(document).on("page:update",function(){
  var container = $(".income-expense-search-result-chart");
  if(container.length > 0) {
    chart_result(container);
  }
});
