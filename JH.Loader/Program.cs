using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JH.Loader
{
    class Program
    {
        static void Main(string[] args)
        {
            var runner = new JobScheduler();

            Task.Run(runner.Start);


            // Wait for scheduling to finish
            Console.WriteLine("Job scheduler running...");
            Console.WriteLine("Press any key to quit");
            Console.ReadKey();

            runner.Stop().RunSynchronously();

            Console.WriteLine("Done");
        }
    }
}
