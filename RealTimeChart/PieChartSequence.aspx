<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PieChartSequence.aspx.cs" Inherits="RealTimeChart.PieChart1" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <style>
        img {
            height: 100px;
            width: 100px;
            float: left;
        }

        td {
            height: 100px;
            width: 100px;
            padding: 0;
        }
    </style>

    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="Scripts/Chart.min.js" type="text/javascript"></script>
    <script src="Scripts/Chart.bundle.js"></script>
    <script src="Scripts/jquery-ui-1.8.20.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>
    <script>

        $(function () {

            for (var i = 1; i <= 100; i++) {
                $("#divPics").append('<img id="theImg_' + i + '" src="Content/pics/' + i + '.jpg" height="100px" width="100px"  style="display: none;"/>')
            }

            $("#test").click(function () {
                ShowPics(100);
                
            })


            function ShowPics(index) {
                if (index > 100) index = 100;
                for (var i = 1; i <= index; i++) {
                    var img = $("#divPics").find("#theImg_" + i);
                    if (!img.is(":visible")) {
                        img.show("drop", 2000);
                    }
                }
            }

            //Create the Hub
            var chartHub = $.connection.chartHub;

            //Call InitChartData 
            $.connection.hub.start().done(function () {
                // chartHub.server.initPieChartData();
            });

            //Call to Update LineChart from Server
            chartHub.client.updatePieChart = function (pie_data) {
                ShowPics(pie_data);
            };

            chartHub.client.resetData = function () { $("#divPics img").hide(); };
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

            <div id="test">新光</div>
        </div>
        <div id="divPics" style="background-image: url(/Content/pics/bg.jpg); width: 1000px; height: 1000px">
        </div>
    </section>
</asp:Content>
