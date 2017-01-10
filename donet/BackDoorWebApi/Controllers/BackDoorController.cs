#region 类文件描述
/*********************************************************
Copyright @ 苏州瑞泰信息技术有限公司 All rights reserved. 
创建人   : Channing Kuo
创建时间 : 2017-01-09
说明     : 后门程序的 WebApi
********************************************************/
#endregion

using System.Collections.Generic;
using System.Web.Http;

namespace BackDoorWebApi
{
    public class BackDoorController : ApiController
    {
        [HttpGet]
        public List<DataInfo> OpenBackDoor()
        {
            return new BackDoorCommand().GetDataInfosFromFile();
        }
    }
}