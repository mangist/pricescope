using Quartz;
using Quartz.Impl;
using System;
using System.Threading.Tasks;

namespace JH.Loader
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

                // define the job and tie it to our HelloJob class
                IJobDetail job = JobBuilder.Create<EBayJob>()
                    .WithIdentity("ebay", "loaders")
                    .Build();

                // Trigger the job to run now, and then repeat every 10 seconds
                ITrigger trigger = TriggerBuilder.Create()
                    .WithIdentity("ebay10", "loaders")
                    .StartNow()
                    .WithSimpleSchedule(x => x
                        .WithIntervalInMinutes(10) // Every 10 minutes
                        .RepeatForever())
                    .Build();

                // Tell quartz to schedule the job using our trigger
                await scheduler.ScheduleJob(job, trigger);
            }
            catch (SchedulerException se)
            {
                Console.WriteLine(se);
            }
        }

        public async Task Stop()
        {

            // and last shut down the scheduler when you are ready to close your program
            await scheduler.Shutdown();
        }
    }
}
