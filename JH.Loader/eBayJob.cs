using Common.Logging;
using eBay.Service.Core.Soap;
using JH.Loader.EBayApi;
using Quartz;
using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Text;
using System.Threading.Tasks;

namespace JH.Loader
{
    public class EBayJob : IJob
    {
        private ILog log = LogManager.GetLogger<EBayJob>();

        public Task Execute(IJobExecutionContext context)
        {
            log.Info("Executing eBay job");

            EBayApi.FindItemsByKeywordsRequest req = new EBayApi.FindItemsByKeywordsRequest();
            req.keywords = "gauden ms65";
            req.buyerPostalCode = "02472";
            req.sortOrder = EBayApi.SortOrderType.StartTimeNewest;
            req.paginationInput = new PaginationInput
            {
                pageNumber = 1,
                entriesPerPage = 50
            };

            //string appId = "JonHunt-PriceSco-PRD-ee0394388-53bada8a";     // use your app ID
            //string devId = "9de24f02-8ec8-4f6b-9111-01c1a69a7c8c";     // use your dev ID
            //string certId = "PRD-e039438849e2-1edf-4ba7-b969-b0f0";   // use your cert ID

            using (var client = new EBayApi.FindingServicePortTypeClient())
            {
                MessageHeader header = MessageHeader.CreateHeader("CustomHeader", "", "");

                using (new OperationContextScope(client.InnerChannel))
                {
                    OperationContext.Current.OutgoingMessageHeaders.Add(header);

                    // Add a HTTP Header to an outgoing request
                    var requestMessage = new HttpRequestMessageProperty();
                    requestMessage.Headers["X-EBAY-SOA-SECURITY-APPNAME"] = "JonHunt-PriceSco-PRD-ee0394388-53bada8a";
                    requestMessage.Headers["X-EBAY-SOA-SERVICE-NAME"] = "FindingService";
                    requestMessage.Headers["X-EBAY-SOA-OPERATION-NAME"] = "findItemsByKeywords";
                    requestMessage.Headers["X-EBAY-SOA-GLOBAL-ID"] = "EBAY-US";

                    OperationContext.Current.OutgoingMessageProperties[HttpRequestMessageProperty.Name] = requestMessage;

                    var response = client.findItemsByKeywords(req);

                    foreach (var searchItem in response.searchResult.item)
                    {
                        log.Info(searchItem);
                    }
                }
            }

            // Connect to eBay API and pull current / latest price information
            return Task.Delay(10);
        }
    }
}
