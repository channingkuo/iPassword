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
using Newtonsoft.Json.Serialization;

namespace BackDoorWebApi
{
    public class BackDoorCommand
    {
        public List<DataInfo> GetDataInfosFromFile()
        {
            string line;
            var dataInfo = new List<DataInfo>();
            var sr = new StreamReader(AppDomain.CurrentDomain.BaseDirectory + "DataInfoFile.txt", Encoding.Default);
            while ((line = sr.ReadLine()) != null)
            {
                var settings = new JsonSerializerSettings {
                    ContractResolver = new DefaultContractResolver()
                };
                dataInfo.Add(JsonConvert.DeserializeObject<DataInfo>(line, settings));
            }
            return dataInfo;
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

        [JsonProperty("iconName")]
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
