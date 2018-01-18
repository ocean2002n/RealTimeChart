<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PieChart.aspx.cs" Inherits="RealTimeChart.PieChart1" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <style>
        img {
            width: 100%;
            height: 100%;
            display: block;
        }

        #tbPics {
            width: 1024px;
            height: 768px;
            border: none;
        }

        td {
            width: 102.4px;
            height: 76.8px;
            padding: 0;
        }

        #divPics {
            position: absolute;

            background-image: url(/Content/pics/bg.jpg);
            width: 1024px;
            height: 768px;
        }

        #divDone {
            position: absolute;
            background-image: url(/Content/pics/done.jpg);
            width: 1024px;
            height: 768px;
            display: none;
        }

        #divMsg {
            width: 1024px;
            height: 768px;
            position: absolute;
            left: 0px;
            top: 0px;
            /*border: 2px solid black;*/
            background-color: #ddd;
            opacity: 0.65;
            text-align: center;
            line-height: 768px;
            color: red;
            font-size: 10em;
            display: none;
            z-index: 9999;
            font-family: 'Microsoft JhengHei';
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

            for (var i = 9; i >= 0; i--) {
                for (var j = 1; j <= 10; j++) {
                    maxLength.push(i * 10 + j);
                }
            }
            // newMaxLength = shuffle(maxLength);
            //alert(maxLength);
            var k = 0;
            $("#tbPics td").each(function () {
                $(this).html('<img id="theImg_' + maxLength[k] + '" src="Content/pics/' + maxLength[k] + '.jpg"/>');
                k++
            });

            $("#tbPics img").hide();

            var offset = $("#tbPics").offset();
            $("#divMsg").offset({ top: offset.top, left: offset.left });

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
                    //alert(img.attr("id"));
                    if (!img.is(":visible")) {
                        //setInterval(function () {
                        img.show("drop", 2000);
                            //$('#test').fadeIn('slow');
                        //}, 1000);
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

            chartHub.client.resetData = function () {
                $("#tbPics img").hide();
                $("#divPics").show();
                $("#divDone").hide();
            };
            chartHub.client.welcomeMsg = function (mode) {
                if (mode === 1) {
                    $("#divMsg").show("clip", 2000);

                } else {
                    $("#divMsg").hide("clip", 2000);

                }
            };
            chartHub.client.done = function () {
                $("#divMsg").hide();
                $("#divPics").hide("drop", 2000);
                $("#divDone").show("explode", 2000);

            };

        });
    </script>

</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1 id="test">新光
                </h1>
            </hgroup>
        </div>
        <div id="divMsg">董ㄟ 來啊</div>
        <div id="divDone"></div>
        <div id="divPics">
            <table id="tbPics">
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
