using Common.Logging;
using JH.PriceScope.Data;
using JH.PriceScope.Loader.EBayApi;
using Quartz;
using System;
using System.Configuration;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Threading.Tasks;
using System.Linq;

namespace JH.PriceScope.Loader.Jobs
{
    public class EBayJob : IJob
    {
        private ILog log = LogManager.GetLogger<EBayJob>();

        #region Configuration Parameters 

        private string AppName
        {
            get
            {
                return ConfigurationManager.AppSettings["eBayAppName"];
            }
        }

        private string BuyerPostalCode
        {
            get
            {
                return ConfigurationManager.AppSettings["eBayBuyerPostalCode"];
            }
        }

        #endregion

        public Task Execute(IJobExecutionContext context)
        {
            log.Info("Executing eBay job");

            // Lookup eBay price sources
            var dal = new DataLayer();
            try
            {
                var priceSources = dal.GetEBayPriceSources();

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
                        requestMessage.Headers["X-EBAY-SOA-SECURITY-APPNAME"] = AppName;
                        requestMessage.Headers["X-EBAY-SOA-SERVICE-NAME"] = "FindingService";
                        requestMessage.Headers["X-EBAY-SOA-OPERATION-NAME"] = "findItemsByKeywords";
                        requestMessage.Headers["X-EBAY-SOA-GLOBAL-ID"] = "EBAY-US";

                        OperationContext.Current.OutgoingMessageProperties[HttpRequestMessageProperty.Name] = requestMessage;

                        // Query each price source
                        foreach (var ps in priceSources)
                        {
                            // Build eBay request
                            var req = BuildRequest(ps.eBayQuery);

                            // Call eBay API
                            try
                            {
                                log.Info($"Calling FindingAPI (keywords={req.keywords})");

                                var response = client.findItemsByKeywords(req);

                                // Build results for ItemPrice 
                                var result = new ItemPrice
                                {
                                    PriceSourceId = ps.Id,
                                    UpdateTime = DateTime.Now
                                };

                                log.Info($"Found {response.searchResult.count} items");
                                var items = response.searchResult.item;

                                if (response.searchResult.count > 0)
                                {
                                    result.CCPaypalPrice = Convert.ToDecimal(items.Min(i => i.sellingStatus.currentPrice.Value));
                                    result.MinPrice = result.CCPaypalPrice;
                                    result.MaxPrice = Convert.ToDecimal(items.Max(i => i.sellingStatus.currentPrice.Value));

                                    result.ItemUrl = items.First().viewItemURL;

                                    // Update result
                                    dal.UpdateItemPrice(result, false, null);
                                }
                                else
                                {
                                    // What do we do when there is no result
                                    dal.UpdatePriceSourceError(ps.Id, Strings.NoListings);
                                }
                            }
                            catch (Exception ex)
                            {
                                // Update PriceSource with last error
                                dal.UpdatePriceSourceError(ps.Id, ex.Message);
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                log.Error("GetEBayPriceSources", ex);
            }

            // Connect to eBay API and pull current / latest price information
            return Task.CompletedTask;
        }

        private FindItemsByKeywordsRequest BuildRequest(string keywords, int pageNumber = 1, int entriesPerPage = 10)
        {
            var req = new EBayApi.FindItemsByKeywordsRequest();
            req.keywords = keywords;
            req.buyerPostalCode = BuyerPostalCode;
            req.sortOrder = EBayApi.SortOrderType.PricePlusShippingLowest;
            req.paginationInput = new PaginationInput
            {
                pageNumber = pageNumber,
                entriesPerPage = entriesPerPage
            };
            req.itemFilter = new ItemFilter[1];
            req.itemFilter[0] = new ItemFilter
            {
                name = ItemFilterType.ListingType,
                value = new string[] { "FixedPrice" }
            };

            return req;
        }
    }
}
