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
            border-spacing: 0px;
        }

        td {
            width: 102.4px;
            height: 76.8px;
            padding: 0;
        }

        #divPics {
            position: absolute;
            background-size: contain;
            background-image: url(/Content/pics/bg.jpg);
            background-repeat: no-repeat;
            width: 1024px;
            height: 768px;
            /*display:block;*/
        }

        #divDone {
            position: absolute;
            background-size: contain;
            background-image: url(/Content/pics/done.jpg);
            background-repeat: no-repeat;
            width: 1024px;
            height: 768px;
            display: none;
            /*z-index: 9999;*/
        }

        #divMsg {
            width: 1024px;
            height: 300px;
            position: absolute;
            left: 0px;
            top: 300px;
            /*border: 2px solid black;*/
            background-color: red;
            opacity: 0.65;
            text-align: center;
            line-height: 300px;
            color: whitesmoke;
            font-size: 5em;
            display: none;
            z-index: 9999;
            font-family: 'Microsoft JhengHei';
        }

        .marquee {
            width: 1024px;
            height: 100px;
            overflow: hidden;
            /*border: 1px solid #ccc;*/
            /*background: #ccc;*/
            font-size: 3em;
            color: red;
            font-family: 'Microsoft JhengHei';
        }
    </style>

    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <%--    <script src="Scripts/Chart.min.js" type="text/javascript"></script>
    <script src="Scripts/Chart.bundle.js"></script>--%>
    <script src="Scripts/jquery-ui-1.8.20.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>
    <script src="Scripts/jQuery.Marquee-master/jquery.marquee.min.js"></script>
    <script>

        $(function () {
            var $mq = $('.marquee').marquee({ duration: 5000 });
            $mq.marquee('pause');
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

            //var offset = $("#tbPics").offset();
            //$("#divMsg").offset({ top: offset.top, left: offset.left });

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
            })


            function ShowPics(index) {
                var tds = [];
                if (index > 100) index = 100;
                //for (var i = 1; i <= index; i++) {
                //    var img = $("#theImg_" + i);
                //    if (!img.is(":visible")) {
                //        //setInterval(function () {
                //        //img.show("drop", 2500);
                //        //$('#test').fadeIn('slow');
                //        //}, 1024);
                //    }
                //}


                for (var i = 1; i <= index; i++) {
                    var img = $("#theImg_" + i);
                    if (!img.is(":visible")) {
                        tds.push(img);
                    }
                    //if (!img.is(":visible")) {
                    //    img.show("drop", 2500, function showNext() {
                    //        if (i + 1 <= index) {

                    //            img = $("#theImg_" + (i + 1))
                    //            img.show("drop", 2500, showNext);
                    //        }
                    //    });
                    //    break;
                    //}
                }

                var j = 0;
                tds[j].show("drop", 1000, function showNext() {
                    tds[++j].show("drop", 1000, showNext);
                });
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
                //$('.marquee').stop();
                //$("#tbPics img").hide();
                //$("#divMsg").hide();
                //$("#divDone").hide();
                //$("#divPics").show();
                location.reload();
            };
            chartHub.client.welcomeMsg = function (mode, msg) {
                $("#divMsg").html(msg);
                if (mode === 1) {
                    $("#tbPics").fadeOut(2000);
                    $("#divMsg").show("clip", 2000);

                } else {
                    $("#divMsg").hide("clip", 2000);
                    $("#tbPics").show("fade", 2000);
                }
            };
            chartHub.client.done = function () {
                $('.marquee').stop();
                $("#divMsg").hide();
                $("#divPics").fadeOut(2000);
                $("#divDone").show("explode"

                    , 3000);
                //
            };
            chartHub.client.runMsg = function (mode) {
                if (mode === 1) {
                    $mq.marquee('resume').show();
                } else {
                    $mq.marquee('pause').hide();

                }
            };
        });
    </script>

</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%-- <section>--%>
    <%--  <div class="content-wrapper">
            <hgroup class="">
                <h1 id="test">新光
                </h1>
            </hgroup>
        </div>--%>
    <div id="divMsg"></div>
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
    <div class="marquee">光無所不在，心與你同在</div>
    <%--</section>--%>
</asp:Content>
