using AngleSharp;
using Common.Logging;
using JH.PriceScope.Data;
using Quartz;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JH.PriceScope.Loader.Jobs
{
    public class PcgsJob : IJob
    {
        private ILog log = LogManager.GetLogger<EBayJob>();

        public async Task Execute(IJobExecutionContext context)
        {
            log.Info("Executing web job");

            // Lookup eBay price sources
            var dal = new DataLayer();
            try
            {
                var priceSources = dal.GetWebPriceSources();

                // Setup the configuration to support document loading
                var config = Configuration.Default.WithDefaultLoader();

                // Load the PCGS price report table
                var address = "https://www.pcgs.com/prices/priceguidedetail.aspx?ms=4&pr=1&sp=1&c=744&title=morgan+dollar&pf=1";

                // Asynchronously get the document in a new context using the configuration
                var document = await BrowsingContext.New(config).OpenAsync(address);

                // This CSS selector gets the desired content
                var cellSelector = "#gvReport";

                // Perform the query to get all cells with the content
                var table = document.QuerySelectorAll(cellSelector).First();

                foreach (var row in table.Children.First().Children)
                {
                    if (!row.ClassName.Contains("head"))
                    {
                        foreach (var td in row.Children)
                        {
                            var span = td.Children.FirstOrDefault(c => c.Id == "lblDescription");
                            if (span != null)
                            {
                                var coinType = span.TextContent;
                                Debug.WriteLine($"Found coin {coinType}");
                            }
                        }
                    }
                }
                
                //var titles = cells.Select(m => m.TextContent);
            }
            catch (Exception ex)
            {
                log.Error("GetWebPriceSources", ex);
            }
        }
    }
}
