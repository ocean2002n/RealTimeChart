using System;
using Microsoft.Owin;
using Owin;
[assembly: OwinStartup(typeof(RealTimeChart.Startup))]
namespace RealTimeChart
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            // Any connection or hub wire up and configuration should go here
            app.MapSignalR();
        }
    }
}