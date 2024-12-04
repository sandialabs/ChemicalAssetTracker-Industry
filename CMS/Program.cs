using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using DataModel;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;

namespace CMS
{
    public class Program
    {
        //---------------------------------------------------------------------
        //
        // HTTPS Control
        //
        //---------------------------------------------------------------------
        
        public const bool USE_HTTPS = false;
        public const int LISTEN_PORT = 443;
        
        static bool UsingProxy = false;
        private static int _listenPort;
        private static X509Certificate2 _certificate;

        public static int ListenPort { get => _listenPort; private set => _listenPort = value; }

        public static void Main(string[] args)
        {
            List<string> webbuilder_args = new List<string>();
            _listenPort = LISTEN_PORT;

            int i = 0;
            while (i < args.Length)
            {
                string arg = args[i++];
                if (arg == "-proxy")
                {
                    UsingProxy = true;
                    continue;
                }
                if (arg == "-help")
                {
                    Banner(
                        "Use: dotnet run [-port <listen_port>] [-proxy]",
                        "     -port specifies the port to listen on - default is 5000",
                        "     -proxy will add headers to support running as reverse proxy"
                    );
                    return;
                }
                if (arg == "-port")
                {
                    if (i < args.Length)
                    {
                        string portstr = args[i++];
                        ListenPort = Int32.Parse(portstr);
                    }
                    continue;
                }
                webbuilder_args.Add(arg);
            }

            string docker_cert_path = Path.Combine("/https", "aspnetapp.pfx"); // "/https/aspnetapp.pfx";
            string docker_cert_password = Environment.GetEnvironmentVariable("ASPNETCORE_Kestrel__Certificates__Default__Password"); // CMSDB.Configuration.GetSection("Certificate")["Password"].ToString(); // "certificate_password";

            try
            {
                //if (USE_HTTPS)
                //{
                    // https://stackoverflow.com/a/46336873/706747
                    using (X509Store store = new X509Store(StoreName.My))
                    {
                        store.Open(OpenFlags.ReadOnly);
                        X509Certificate2Collection certs = store.Certificates.Find(X509FindType.FindBySubjectName, "localhost", false);

                    if (File.Exists(docker_cert_path))
                    {
                        Console.WriteLine("File exists.");
                        certs.Import(docker_cert_path, docker_cert_password, X509KeyStorageFlags.PersistKeySet);
                    }
                    //Console.WriteLine("Certificate Count: " + store.Certificates.Count);
                    //foreach (X509Certificate2 cert in store.Certificates)
                    //{
                    //    Console.WriteLine(JsonConvert.SerializeObject(cert).ToString());
                    //}
                    if (certs.Count > 0)
                            _certificate = certs[0];
                    }
                //}
            }
            catch (Exception)
            {
                Console.WriteLine("Could not load certificate.");
            }

            //BuildWebHost(webbuilder_args.ToArray()).Run();

            CreateHostBuilder(args).Build().Run();
        }

        public static void Banner(List<string> lines)
        {
            Console.WriteLine(" ");
            Console.WriteLine("########################################################################");
            Console.WriteLine("#");
            foreach (string line in lines)
            {
                Console.WriteLine("# " + line);
            }
            Console.WriteLine("#");
            Console.WriteLine("########################################################################");
            Console.WriteLine(" ");
        }

        public static void Banner(params string[] lines)
        {
            Console.WriteLine(" ");
            Console.WriteLine("########################################################################");
            Console.WriteLine("#");
            foreach (string line in lines)
            {
                Console.WriteLine("# " + line);
            }
            Console.WriteLine("#");
            Console.WriteLine("########################################################################");
            Console.WriteLine(" ");
        }




        //public static IHostBuilder CreateHostBuilder(string[] args) =>
        //    Host.CreateDefaultBuilder(args)
        //        .ConfigureWebHostDefaults(webBuilder =>
        //        {
        //            webBuilder.ConfigureKestrel(options =>
        //            {
        //                options.Listen(IPAddress.Any, ListenPort, listenOptions =>
        //                {
        //                    if (_certificate != null)
        //                        listenOptions.UseHttps(_certificate);
        //                });
        //            })
        //            .UseStartup<Startup>();
        //        });


        // This works if a certificate is provided in the directory and file name as defined below - would need to update the server to match.
        //public static IHostBuilder CreateHostBuilder(string[] args) =>
        //Host.CreateDefaultBuilder(args)
        //    .ConfigureWebHostDefaults(webBuilder =>
        //    {
        //    webBuilder.UseStartup<Startup>();
        //    webBuilder.UseKestrel(options =>
        //    {
        //        options.ListenAnyIP(80); // HTTP
        //        options.ListenAnyIP(443, listenOptions =>
        //        {
        //            listenOptions.UseHttps("/https/aspnetapp.pfx", "certificate_password"); // HTTPS
        //        });
        //    });
        //});


        public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureWebHostDefaults(webBuilder =>
        {
            webBuilder // .UseKestrel()
            .ConfigureKestrel(options =>
            {
                //options.ListenAnyIP(80); // HTTP
                options.ListenAnyIP(443, listenOptions =>
                {
                    if (_certificate != null)
                                listenOptions.UseHttps(_certificate);
                });
            })
            .UseStartup<Startup>();
        });
    }
}
