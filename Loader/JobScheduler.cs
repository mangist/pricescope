using JH.PriceScope.Loader.Jobs;
using Quartz;
using Quartz.Impl;
using System;
using System.Threading.Tasks;

namespace JH.PriceScope.Loader
{
    public class JobScheduler
    {
        private IScheduler scheduler = null;

        public async Task Start()
        {
            try
            {
                Common.Logging.LogManager.Adapter = new Common.Logging.Simple.DebugLoggerFactoryAdapter { Level = Common.Logging.LogLevel.Info };

                // Grab the Scheduler instance from the Factory 
                this.scheduler = await StdSchedulerFactory.GetDefaultScheduler();

                // and start it off
                await scheduler.Start();

                // eBay job
                var trigger = GetHourlyTrigger("ebay");
                var eBay = GetJob<EBayJob>("ebay");
                await scheduler.ScheduleJob(eBay, trigger);

                // Web job
                trigger = GetHourlyTrigger("web");
                var web = GetJob<WebJob>("web");
                await scheduler.ScheduleJob(web, trigger);
            }
            catch (SchedulerException se)
            {
                Console.WriteLine(se);
            }
        }

        private IJobDetail GetJob<T>(string key)
            where T: IJob
        {
            // define the job and tie it to our HelloJob class
            return JobBuilder.Create<T>()
                .WithIdentity(key, "loaders")
                .Build();
        }

        private ITrigger GetHourlyTrigger(string key)
        {
            // Trigger the job to run now, and then repeat every hour
            return TriggerBuilder.Create()
                .WithIdentity(key, "loaders")
                .StartNow()
                .WithSimpleSchedule(x => x
                    .WithIntervalInMinutes(60) // Every 10 minutes
                    .RepeatForever())
                .Build();
        }

        public async Task Stop()
        {

            // and last shut down the scheduler when you are ready to close your program
            await scheduler.Shutdown();
        }
    }
}
