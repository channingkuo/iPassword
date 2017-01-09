#region 类文件描述
/*********************************************************
Copyright @ 苏州瑞泰信息技术有限公司 All rights reserved. 
创建人   : Channing Kuo
创建时间 : 2017-01-09
说明     : 后门程序的 Command
********************************************************/
#endregion

using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Newtonsoft.Json;

namespace PasswordKeeper
{
    public class BackDoorCommand
    {
        public List<DataInfo> GetDataInfosFromFile()
        {
            StreamReader sr = new StreamReader("E:\\Git Source\\PasswordKeeper-swift\\donet\\DataInfoFile.txt", Encoding.Default);
            String line;
            while ((line = sr.ReadLine()) != null)
            {
                Console.WriteLine(line);
            }
            return new List<DataInfo>();
        }
    }

    public class DataInfo
    {
        [JsonProperty("caption")]
        public string Caption { get; set; }

        [JsonProperty("account")]
        public string Account { get; set; }

        [JsonProperty("password")]
        public string Password { get; set; }

        [JsonProperty("lconName")]
        public string IconName { get; set; }

        [JsonProperty("lastEditTime")]
        public DateTime LastEditTime { get; set; }

        [JsonProperty("remark")]
        public string Remark { get; set; }

        [JsonProperty("key")]
        public string Key { get; set; }

        [JsonProperty("indexKey")]
        public int IndexKey { get; set; }
    }
}
