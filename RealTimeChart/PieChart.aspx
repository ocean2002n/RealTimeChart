<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PieChart.aspx.cs" Inherits="RealTimeChart.PieChart1" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <style>
        img {
            float: left;
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
            $("#divPics")
            for (var i = 1; i <= 100; i++) {

                $("#divPics").append('<img id="theImg_' + i + '" src="Content/pics/' + i + '.jpg" height="100px" width="100px"  style="display: none;"/>')
                if (i % 10 == 0) {
                    //$("#divPics").append("<br>");
                    //alert(i);
                }

                //<img src="Content/background.jpg" alt="Smiley face" height="42" width="42">
            }


            $("#test").click(function () { ShowPics($("#testValue").val()); })
            function ShowPics(index) {

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
                chartHub.server.initPieChartData();
            });

            //Call to Update LineChart from Server
            chartHub.client.updatePieChart = function (pie_data) {
                // UpdatePieChart(pie_data);     //Call the PieChart Update method
                alert(pie_data);
                alert(pie_data.value);
                ShowPics(pie_data);
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
            <input type="text" id="testValue">
            <div id="test">來來來來</div>

        </div>

        <div id="divPics" style="background-image: url(/Content/pics/bg.jpg); width: 1000px; height: 1000px">
        </div>
    </section>


</asp:Content>
