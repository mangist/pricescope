using Common.Logging;
using JH.PriceScope.Data;
using Quartz;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JH.PriceScope.Loader.Jobs
{
    public class WebJob : IJob
    {
        private ILog log = LogManager.GetLogger<EBayJob>();

        public Task Execute(IJobExecutionContext context)
        {
            log.Info("Executing web job");

            // Lookup eBay price sources
            var dal = new DataLayer();
            try
            {
                var priceSources = dal.GetWebPriceSources();

                // Now for each one use our web crawler client to pull the result

            }
            catch (Exception ex)
            {
                log.Error("GetWebPriceSources", ex);
            }

            return Task.CompletedTask;
        }
    }
}
