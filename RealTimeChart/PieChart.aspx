<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PieChart.aspx.cs" Inherits="RealTimeChart.PieChart1" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="Scripts/Chart.min.js" type="text/javascript"></script>
    <script src="Scripts/Chart.bundle.js"></script>
    <script src="Scripts/jquery-ui-1.8.20.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>
    <script>

        $(function () {

            var randomScalingFactor = function () {
                return Math.round(Math.random() * 100);
            };

            var config = {
                type: 'pie',
                data: {
                    datasets: [{
                        data: [
                            randomScalingFactor(),
                            randomScalingFactor()
                        ],
                        backgroundColor: [
                            'rgb(255, 99, 132)',
                            'rgb(255, 159, 64)'
                        ],
                        label: 'Dataset 1'
                    }],
                    labels: [
                        "Red",
                        "Orange"
                    ]
                },
                options: {
                    responsive: true,
                    animation: {
                        duration: 0
                    }
                }
            };

            var ctx = document.getElementById("canvasForPieChart").getContext("2d");
            window.myPie = new Chart(ctx, config);

            //Create the Hub
            var chartHub = $.connection.chartHub;

            //Call InitChartData 
            $.connection.hub.start().done(function () {            
                chartHub.server.initPieChartData();
            });

            //Call to Update LineChart from Server
            chartHub.client.updatePieChart = function (pie_data) {
                UpdatePieChart(pie_data);     //Call the PieChart Update method
            };

            //PieChart Update method
            function UpdatePieChart(data) {
                config.data.datasets.forEach(function (dataset) {
                    dataset.data = data.value;
                });
                window.myPie.update();
            }
            
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
                <canvas id="canvasForPieChart" height="400" width="400">Chart is Loading...</canvas>
            </tr>
        </table>
    </section>


    <%--<script type="text/javascript">
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

    </script>--%>

</asp:Content>
