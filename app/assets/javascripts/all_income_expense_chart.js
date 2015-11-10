var income_expense_chart = function(container) {
  container.highcharts({
    chart: {
      type: "column"
    },
    title: {
      text: "Income & Expense Chart"
    },
    subtitle: {
      text: ""
    },
    xAxis: {
      categories: container.data("date"),
      title: {
        ext: null
      }
    },
    yAxis: {
      min: 0,
      title: {
        text: "Amount (Dollars)",
        align: "high"
      },
      labels: {
        overflow: "justify"
      }
    },
    tooltip: {
      headerFormat: "<span style='font-size:11px'>{series.name}</span>",
      pointFormat: "<b> {point.y:.1f}$<br/>"
        },
    plotOptions: {
      bar: {
        dataLabels: {
          enabled: true
        }
      }
    },
    legend: {
      layout: "vertical",
      align: "right",
      verticalAlign: "top",
      x: -40,
      y: 80,
      floating: true,
      borderWidth: 1,
      backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || "#FFFFFF"),
      shadow: true
    },
    credits: {
      enabled: false
    },
    series: container.data("chart")
  });
}


$(document).ready(function(){
  var container = $(".search-result-chart");
  if(container.length > 0) {
    income_expense_chart(container);
  }
});
