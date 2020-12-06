using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Common 的摘要描述
/// </summary>
public class Common
{
   public static string DBConnectionString
    {
        get
        {
            return System.Web.Configuration.WebConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        }
    }
    public static T FindControl<T>(Control startingControl, string id) where T : Control
    {
        // 取得 T 的預設值，通常是 null
        T found = default(T);

        int controlCount = startingControl.Controls.Count;

        if (controlCount > 0)
        {
            for (int i = 0; i < controlCount; i++)
            {
                Control activeControl = startingControl.Controls[i];
                if (activeControl is T)
                {
                    found = startingControl.Controls[i] as T;
                    if (string.Compare(id, found.ID, true) == 0) break;
                    else found = null;
                }
                else
                {
                    found = FindControl<T>(activeControl, id);
                    if (found != null) break;
                }
            }
        }
        return found;
    }
}