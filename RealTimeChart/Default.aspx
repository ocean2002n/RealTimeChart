<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RealTimeChart._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="Scripts/Chart.min.js" type="text/javascript"></script>

    
    <script src="Scripts/jquery-ui-1.8.20.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>
<script>
    function checkHTML5() {
        var canvasForLineChart = document.getElementById("canvasForLineChart");
        if (canvasForLineChart == null || canvasForLineChart == "") {
            document.write("Browser doesn't support HTML5 2D Context");
            return false;
        }
        if (canvasForLineChart.getContext) {

        }
        else {
            document.write("Browser doesn't support HTML5 2D Context");
            return false;
        }
    }

    $(function () {
        //If not HTML5 Support the Exit
        if (checkHTML5() == false) return;

        //Create the Hub
        var chartHub = $.connection.chartHub;
        

        //Call InitChartData 
        $.connection.hub.start().done(function () {            
            chartHub.server.initChartData();
            
        });

        //Call to Update LineChart from Server
        chartHub.client.updateChart = function (line_data,pie_data) {
            UpdateLineChart(line_data);  //Call the LineChart Update method
            UpdatePieChart(pie_data);     //Call the PieChart Update method
        };

      
    });
</script>
    
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>SignalR Chart Demo</h1>

            </hgroup>
            <p>
                Open multiple HTML5 compatible Browsers to see the Chart in Real time
                
            </p>
        </div>
 

    <table style="width: 100%">       
        <tr>
            <td style="width: 50%; text-align: center">
                <canvas id="canvasForLineChart" height="200" width="400">Chart is Loading...</canvas>

            </td>
            <td style="width: 50%; text-align: center">
                <canvas id="canvasForPieChart" height="200" width="400">Chart is Loading...</canvas>
            </td>
        </tr>
       
        
    </table>
    </section>


    <script type="text/javascript">
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        //Line Chart JSON Config (Line Chart Has fixed 1 data series here)
        var lineChartData = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
				{				    
				    fillColor: "",
				    data: [0]
				}
            ]

        }

        //Pie Chart JSON Config (Pie Chart Has fixed 3 Values/Slices here)
        var pieChartdata = [
                     {
                         value: 0,
                         color: "#F7464A",                        
                         label: "East"
                     },
                     {
                         value: 0,
                         color: "#46BFBD",                         
                         label: "West"
                     },
                     {
                         value: 0,
                         color: "#FDB45C",                         
                         label: "North"
                     },
                     {
                         value: 0,
                         color: "#FE94DC",                        
                         label: "South"
                     }
        ]

        ////////////////////////////////////////////////////////////////////////////////////////////////////////
       
        //PieChart Update method
        function UpdatePieChart(data) {
            //Set data returned from Server            
            pieChartdata[0].value = data.value[0];
            pieChartdata[1].value = data.value[1];
            pieChartdata[2].value = data.value[2];
            //Update the Line Chart
            var canvasForPieChart = document.getElementById("canvasForPieChart");
            var context2DPie = canvasForPieChart.getContext("2d");
            new Chart(context2DPie).Pie(pieChartdata);

        }

        //LineChart Update method
        function UpdateLineChart(data) {
            //Set data returned from Server
            lineChartData.datasets[0].fillColor = data.colorString;
            lineChartData.datasets[0].data = data.lineChartData;
            //Update the Pie Chart
            var canvasForLineChart = document.getElementById("canvasForLineChart");
            var context2DLine = canvasForLineChart.getContext("2d");
            new Chart(context2DLine).Line(lineChartData);
        }

	</script>

</asp:Content>
