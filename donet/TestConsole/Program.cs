using System;
using System.IO;
using System.Text;

namespace TestConsole
{
    public class Program
    {
        public static void Main(string[] args)
        {
            StreamReader sr = new StreamReader("E:\\Git Source\\PasswordKeeper-swift\\donet\\DataInfoFile.txt", Encoding.Default);
            String line;
            while ((line = sr.ReadLine()) != null)
            {
                Console.WriteLine(line);
            }
            Console.ReadLine();
        }
    }
}
