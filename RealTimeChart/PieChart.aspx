<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PieChart.aspx.cs" Inherits="RealTimeChart.PieChart1" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <style>
        img {
            height: 100px;
            width: 100px;
            display: none;
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
            var maxLength = [];
            for (var i = 1; i <= 100; i++) { maxLength.push(i); }
            newMaxLength = shuffle(maxLength);

            var i = 0;
            $("#tbPics td ").each(function () {
                $(this).html('<img id="theImg_' + newMaxLength[i] + '" src="Content/pics/' + newMaxLength[i] + '.jpg"  />');
                i++
            });

            function shuffle(array) {
                var currentIndex = array.length, temporaryValue, randomIndex;

                // While there remain elements to shuffle...
                while (0 !== currentIndex) {

                    // Pick a remaining element...
                    randomIndex = Math.floor(Math.random() * currentIndex);
                    currentIndex -= 1;

                    // And swap it with the current element.
                    temporaryValue = array[currentIndex];
                    array[currentIndex] = array[randomIndex];
                    array[randomIndex] = temporaryValue;
                }

                return array;
            }

            $("#test").click(function () {

                ShowPics(100);

                //for (var i = 1; i <= 5; i++) {

                //    setTimeout(function () { ShowPics(i * 20) }, i * 1000);
                //}
            })


            function ShowPics(index) {
                if (index > 100) index = 100;
                for (var i = 1; i <= index; i++) {
                    var img = $("#theImg_" + i);
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

            chartHub.client.resetData = function () { $("#tbPics img").hide(); };
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
        <div style="background-image: url(/Content/pics/bg.png); width: 1000px; height: 1000px">
            <table style="width: 100%" id="tbPics">
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
    </section>
</asp:Content>
