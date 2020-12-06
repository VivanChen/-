using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Text;

/// <summary>
/// Summary description for WeatherApiUtility
/// </summary>
public class WeatherApiUtility
{
    public static JArray getJson(string uri)
    {
        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(uri); //request請求
        req.Timeout = 10000; //request逾時時間
        req.Method = "GET"; //request方式
        HttpWebResponse respone = (HttpWebResponse)req.GetResponse(); //接收respone
        StreamReader streamReader = new StreamReader(respone.GetResponseStream(), Encoding.UTF8); //讀取respone資料
        string result = streamReader.ReadToEnd(); //讀取到最後一行
        respone.Close();
        streamReader.Close();
        JObject jsondata = JsonConvert.DeserializeObject<JObject>(result); //將資料轉為json物件
        return (JArray)jsondata["records"]["location"]; //回傳json陣列

    }
}