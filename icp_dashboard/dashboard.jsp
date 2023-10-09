
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>IndexForm</title>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="css/style1.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/all.min.css" media="all">
<link rel="stylesheet" href="css/style.css" media="all">
<script src="bar.js" type="text/javascript"></script>
<script src="js/Charts.js"></script>
</head>
<body>
		<h1
			style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif; background-color: #ffffff">Arrival
			and Departure Immigration Clearance in last 7 days</h1>
<div class="container-fluid">	
<div class="row">		
<div class="col-sm-6">
		<canvas id="canvasPAX" class="chart" style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #b1d2d8 100%);"></canvas>
	</div>
	<script>
		// Data define for bar chart

		var myData = {
			labels: ["Oct 1", "Oct 2", "Oct 3", "Oct 4", "Oct 5"],
			datasets: [{ 
				  label: "Arrival Footfalls",
			      backgroundColor: "#00dcb0",
			      borderColor: "MediumSeaGreen",
			      borderWidth: 1,
			      data: [55, 49, 44, 24, 15]
			}, { 
				  label: "Departure Footfalls",
			      backgroundColor: "#BEADFA",
			      borderColor: "Violet",
			      borderWidth: 1,
			      data: [55, 49, 44, 24, 15]
			}]
		};
		 	

		// Options to display value on top of bars

		var myoptions = {
				
scales: {
		yAxes: [{
		ticks: { beginAtZero: true },
		stacked: true
		}],
		xAxes: [{
		stacked: true
		}]
},
					 title: {
					        fontSize: 14,		
					      },
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "black";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 7px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metas = chartInstances.controller.getDatasetMeta(i);
						metas.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y);
							
						});
					});
				}
			},
			
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('canvasPAX').getContext('2d');
		var myCharts = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoptions 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>




<div class="col-sm-6">
		<canvas id="canvasPAX1" class="chart" style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #b1d2d8 100%);"></canvas>
	</div>
	</div>
	</div>
	<script>
		// Data define for bar chart


const data = {
			labels: ["Oct 1", "Oct 2", "Oct 3", "Oct 4", "Oct 5", "Oct 5", "Oct 5", "Oct 5", "Oct 5", "Oct 5"],
  datasets: [
    {
      label: 'Dataset 1',
      data: [55,50,35],
      backgroundColor: 'aqua',
    },
    {
      label: 'Dataset 2',
      data: [75,49,35],
      backgroundColor: 'slateblue',
    },
    {
      label: 'Dataset 3',
      data: [60,40,35],
      backgroundColor: 'red',
    }
  ]
};
		// Options to display value on top of bars


		
		//Code to drow Chart

var ctx = document.getElementById('canvasPAX1').getContext('2d');
	const stackedBar = new Chart(ctx, {
    type: 'bar',
    data: data,
    options: {
scales: {
		yAxes: [{
		ticks: { beginAtZero: true },
		stacked: true
		}],
		xAxes: [{
		stacked: true
		}]
}
    }
});

	</script>

	<%
	///////////////////////////	  Arrival and Departure Immigration Clearance in last 7 days - End	///////////////////////////////
	%>



</body>
</html>