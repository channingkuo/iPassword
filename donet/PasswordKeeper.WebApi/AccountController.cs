#region 类文件描述
/*********************************************************
Copyright @ 苏州瑞泰信息技术有限公司 All rights reserved. 
创建人   : Chad Chen
创建时间 : 2015-02-05
说明     : 提供 会员 逻辑的 WebAPI
********************************************************/
#endregion

using System.Web.Http;
using RekTec.Xrm.Data.Models;
using RekTec.Xrm.WebApi;

namespace PasswordKeeper.WebApi
{
    /// <summary>
    /// 提供 会员 逻辑的 WebAPI
    /// </summary>
    public class AccountController : EntityBaseController<account, AccountService>
    {
        /// <summary>
        /// 获取会员的所有的属性的定义
        /// </summary>
        /// <returns></returns>
        [HttpGet, BasicAuthentication]
        public AccountFilterModel GetAccountEnityAttributes()
        {
            return new AccountFilterService().GetAccountEnityAttributes();
        }

        /// <summary>
        /// 获取会员过滤的sql
        /// </summary>
        /// <returns></returns>
        [HttpPost, BasicAuthentication]
        public string GetAccountFilterSql(AccountFilterModel model)
        {
            var sql = new AccountFilterService().GetAccountFilterSql(model);
            return sql;
        }

        /// <summary>
        /// 获取会员的数据
        /// </summary>
        /// <returns></returns>
        [HttpPost, BasicAuthentication]
        public DataListModel<account> GetAccountFilterData(AccountFilterModel model)
        {
            return new AccountFilterService().GetAccountFilterData(model);
        }
    }
}
