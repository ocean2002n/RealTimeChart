using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace RealTimeChart
{
    public class ChartHub : Hub
    {
        // Create the instance of ChartDataUpdate
        private readonly ChartDataUpdate _ChartInstance;
        public ChartHub() : this(ChartDataUpdate.Instance) { }

        public ChartHub(ChartDataUpdate ChartInstance)
        {
            _ChartInstance = ChartInstance;
        }

        public void InitChartData()
        {
            //Show Chart initially when InitChartData called first time
            LineChart lineChart = new LineChart();
            PieChart pieChart = new PieChart();
            lineChart.SetLineChartData();
            pieChart.SetPieChartData();
            Clients.All.UpdateChart(lineChart, pieChart);
            //Call GetChartData to send Chart data every 5 seconds
            _ChartInstance.GetChartData();
        }

        public void InitPieChartData()
        {
            // PieChart pieChart = new PieChart();
            // pieChart.SetPieChartData();
            //Clients.All.UpdatePieChart(0);
            //Call GetChartData to send Chart data every 5 seconds
            //  _ChartInstance.GetPieChartData();
        }

        public void SetPieChartData(int data)
        {
            //PieChart pieChart = new PieChart();
            // pieChart.SetPieChartData(data);
            Clients.All.UpdatePieChart(data);
            //Call GetChartData to send Chart data every 5 seconds
            //_ChartInstance.GetPieChartData();
        }

        /// <summary>
        /// 通知前端更新
        /// </summary>
        /// <param name="data"></param>
        public void SetPicData(int data)
        {
            Clients.All.UpdatePieChart(data);
        }

        /// <summary>
        /// 通知前端清除
        /// </summary>
        /// <param name="data"></param>
        public void ResetData()
        {
            Clients.All.ResetData();
        }

        /// <summary>
        /// 跳歡迎董ㄟ訊息
        /// </summary>
        public void WelcomeMsg(int mode, string msg)
        {
            Clients.All.WelcomeMsg(mode, msg);
        }

        /// <summary>
        /// 結束
        /// </summary>
        public void Done()
        {
            Clients.All.Done();
        }

        public void RunMsg(int mode)
        {
            Clients.All.RunMsg(mode);
        }
    }
}