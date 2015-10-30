function makePie(data) {
var ctx = document.getElementById("chart").getContext("2d");
var data2 = data;
var data3 = {};
var options = {};

var piechart = new Chart(ctx).Pie(data3, options);
for(i = 0; i< data2.length; i++) {
    piechart.addData({
        value:Math.log(data2[i][1]),
        color:"#B48EAD",
        highlight:"#C69CBE",
        label:data2[i][0],
        tooltipTemplate: "<%= label %>"
    });
};
    
piechart.update();
//var legend = myPieChart.generateLegend();
}
