using PasswordKeeper;
using RekTec.Corelib.Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace TestConsole
{
    public class Program
    {
        public static void Main(string[] args)
        {
            StreamReader sr = new StreamReader("DataInfoFile.txt", Encoding.Default);
            string line;
            var dataInfo = new List<DataInfo>();
            while ((line = sr.ReadLine()) != null)
            {
                var info = JsonUtils.DeserializeObject<DataInfo>(line);
                Console.WriteLine(line);
            }
            Console.ReadLine();
        }
    }
}
