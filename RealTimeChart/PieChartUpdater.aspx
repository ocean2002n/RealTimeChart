<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PieChartUpdater.aspx.cs" Inherits="RealTimeChart.PieChartUpdater" %>

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

            var chartHub = $.connection.chartHub;

            // 註冊給伺服端呼叫的方法
            chartHub.client.updatePieChart = function (pie_data) {
                UpdatePieChart(pie_data);
            };

            // 連線到 SignalR 伺服器
            $.connection.hub.start()
                // 註冊連線成功後要執行的作業
                .done(function () {
                    chartHub.server.initPieChartData();
                });
            
            document.getElementById('sendmessage').addEventListener('click', function () {
                var pieChartdata = $('#percent1').val();
                chartHub.server.setPieChartData(pieChartdata);
            });

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
                <td style="width: 50%; text-align: center">
                    <input type="text" class="form-control" placeholder="Percent1" id="percent1" />
                    <input type="text" class="form-control" placeholder="Percent2" id="percent2" />
                    <input type="button" class="btn btn-default" id="sendmessage" value="發送" />
                </td>
                <td style="width: 50%; text-align: center">
                    <canvas id="canvasForPieChart" height="200" width="400">Chart is Loading...</canvas>
                </td>
            </tr>
       
        </table>
    </section>
</asp:Content>
