using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
/// <summary>
/// Summary description for PartNumberUtility
/// </summary>
public class PartNumberUtility
{
    //得到全部partnumber
    public static List<PartNumber> GetAllPartNumber()
    {

        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM PartNO", Common.DBConnectionString);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new PartNumber()
                    {
                        id = (int)(row["id"]),
                        component = row["component"].ToString(),
                        vendor = row["vendor"].ToString(),
                        config = row["config"].ToString(),
                        description = row["description"] is DBNull ? "" : row["description"].ToString(),
                        drawing = row["drawing"] is DBNull ? "" : row["drawing"].ToString(),
                        qty = row["qty"] is DBNull ? 0 : (int)row["qty"],
                        theDate = Convert.ToDateTime(row["theDate"]),
                        qtydescription = row["qtydescription"] is DBNull ? "" : row["qtydescription"].ToString(),
                        qtyDateStr = row["qtyDate"] is DBNull ? "尚未紀錄修改時間" : row["qtyDate"].ToString()
                    };
        List<PartNumber> partNumbersList = query.ToList();
        return partNumbersList;
    }
    //找整組part by id
    public static PartNumber PartNumberById(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM PartNO where id=@id", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@id", id);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];
        PartNumber pn = new PartNumber()
        {
            id = (int)(row["id"]),
            component = row["component"].ToString(),
            vendor = row["vendor"].ToString(),
            config = row["config"].ToString(),
            description = row["description"] is DBNull ? "" : row["description"].ToString(),
            drawing = row["drawing"] is DBNull ? "" : row["drawing"].ToString(),
            theDate = Convert.ToDateTime(row["theDate"]),
            qty = row["qty"] is DBNull ? 0 : (int)row["qty"],
            qtydescription = row["qtydescription"] is DBNull ? "" : row["qtydescription"].ToString(),
            qtyDateStr = row["qtyDate"] is DBNull ? "尚未紀錄修改時間" : row["qtyDate"].ToString()
            //theDate = Convert.ToDateTime(row["theDate"])
        };
        return pn;
    }
    //新增PartNumber
    public static void InserPartNumber(PartNumber p)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("INSERT INTO PartNO (component,vendor,config,description,drawing,qty,theDate) VALUES (@component,@vendor,@config,@description,@drawing,@qty,@theDate)", cn);
        cmd.Parameters.AddWithValue("@component", p.component);
        cmd.Parameters.AddWithValue("@vendor", p.vendor);
        cmd.Parameters.AddWithValue("@config", p.config);
        cmd.Parameters.AddWithValue("@description", p.description);
        cmd.Parameters.AddWithValue("@drawing", p.drawing);
        cmd.Parameters.AddWithValue("@qty", p.qty);
        cmd.Parameters.AddWithValue("@theDate", p.theDate);
        //連線執行關閉
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }
    //用全部輸入符合找PartNumber
    public static PartNumber PartNumberByAllFindPartNO(PartNumber PartP)
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM PartNO where component=@component AND vendor=@vendor AND config=@config AND description=@description AND drawing=@drawing AND theDate=@theDate", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@component", PartP.component);
        da.SelectCommand.Parameters.AddWithValue("@vendor", PartP.vendor);
        da.SelectCommand.Parameters.AddWithValue("@config", PartP.config);
        da.SelectCommand.Parameters.AddWithValue("@description", PartP.description);
        da.SelectCommand.Parameters.AddWithValue("@drawing", PartP.drawing);
        //da.SelectCommand.Parameters.AddWithValue("@qty", PartP.qty);
        da.SelectCommand.Parameters.AddWithValue("@theDate", PartP.theDate);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];
        PartNumber pn = new PartNumber()
        {
            id = (int)(row["id"]),
            component = row["component"].ToString(),
            vendor = row["vendor"].ToString(),
            config = row["config"].ToString(),
            description = row["description"] is DBNull ? "" : row["description"].ToString(),
            drawing = row["drawing"] is DBNull ? "" : row["drawing"].ToString(),
            //qty =row["qty"] is DBNull?0: (int)row["qty"],
            theDate = Convert.ToDateTime(row["theDate"])

        };
        return pn;
    }
    //刪除PartNumber by id
    public static void DeletePartNumber(int id)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("Delete from PartNO where id=@id", cn);
        cmd.Parameters.AddWithValue("@id", id);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    //上傳檔案 料件用
    public static void UpdatePartNumber(PartNumber p)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("UPDATE PartNO SET component=@component,vendor=@vendor,config=@config,description=@description,drawing=@drawing,theDate=@theDate WHERE id=@id", cn);
        cmd.Parameters.AddWithValue("@id", p.id);
        cmd.Parameters.AddWithValue("@component", p.component);
        cmd.Parameters.AddWithValue("@vendor", p.vendor);
        cmd.Parameters.AddWithValue("@config", p.config);
        cmd.Parameters.AddWithValue("@description", p.description);
        cmd.Parameters.AddWithValue("@drawing", p.drawing);
        cmd.Parameters.AddWithValue("@theDate", p.theDate);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }


    //上傳檔案 庫存用
    public static void UpdatePartNumberQty(PartNumber p)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("UPDATE PartNO SET component=@component,vendor=@vendor,config=@config,qty=@qty,qtydescription=@qtydescription,qtyDate=@qtyDate WHERE id=@id", cn);
        cmd.Parameters.AddWithValue("@id", p.id);
        cmd.Parameters.AddWithValue("@component", p.component);
        cmd.Parameters.AddWithValue("@vendor", p.vendor);
        cmd.Parameters.AddWithValue("@config", p.config);
        cmd.Parameters.AddWithValue("@qty", p.qty);
        cmd.Parameters.AddWithValue("@qtydescription", p.qtydescription);
        cmd.Parameters.AddWithValue("@qtyDate", p.qtyDateStr);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    //找整組part by component
    public static List<PartNumber> PartNumberByComponent(string component)
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM PartNO where component=@component", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@component", component);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new PartNumber()
                    {


                        id = (int)(row["id"]),
                        component = row["component"].ToString(),
                        vendor = row["vendor"].ToString(),
                        config = row["config"].ToString(),
                        description = row["description"] is DBNull ? "" : row["description"].ToString(),
                        drawing = row["drawing"] is DBNull ? "" : row["drawing"].ToString(),
                        qty = row["qty"] is DBNull ? 0 : (int)row["qty"],
                        theDate = Convert.ToDateTime(row["theDate"]),
                        qtydescription = row["qtydescription"] is DBNull ? "" : row["qtydescription"].ToString(),
                        qtyDateStr = row["qtyDate"] is DBNull ? "尚未紀錄修改時間" : row["qtyDate"].ToString()
                    };
        List<PartNumber> partNumbersList = query.ToList();
        return partNumbersList;
    }
    //找整組part by vendor
    public static List<PartNumber> PartNumberByVendor(string vendor)
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM PartNO where vendor=@vendor", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@vendor", vendor);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new PartNumber()
                    {


                        id = (int)(row["id"]),
                        component = row["component"].ToString(),
                        vendor = row["vendor"].ToString(),
                        config = row["config"].ToString(),
                        description = row["description"] is DBNull ? "" : row["description"].ToString(),
                        drawing = row["drawing"] is DBNull ? "" : row["drawing"].ToString(),
                        qty = row["qty"] is DBNull ? 0 : (int)row["qty"],
                        theDate = Convert.ToDateTime(row["theDate"]),
                        qtydescription = row["qtydescription"] is DBNull ? "" : row["qtydescription"].ToString(),
                        qtyDateStr = row["qtyDate"] is DBNull ? "尚未紀錄修改時間" : row["qtyDate"].ToString()
                    };
        List<PartNumber> partNumbersList = query.ToList();
        return partNumbersList;
    }

    //purch insertgetid
    //public static int InsertPurchGetId()


    //下拉選單一  拿supplierID and CompanyName
    public static List<supplierAndComponent> drop1()
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM supplier ", Common.DBConnectionString);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new supplierAndComponent()
                    {
                        supplierID = (int)row["supplierID"],
                        CompanyName = row["CompanyName"].ToString(),
                    };
        List<supplierAndComponent> supcomname = query.ToList();
        return supcomname;
    }
    //下拉選單2  拿supplierID and Component
    public static List<supplierAndComponent> drop2(int supplierID)
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT supplierID,Component FROM supComponent WHERE supplierID=@supplierID", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@supplierID", supplierID);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new supplierAndComponent()
                    {
                        supplierID =(int)row["supplierID"],
                        Component = row["Component"] is DBNull?"NODATA" :row["Component"].ToString()
                    };
        List<supplierAndComponent> ComponentList = query.ToList();
        return ComponentList;
    }
    //purching 用supplierid下拉選單找supplier all
    public static supplierAndComponent supIdGetSupAll(int supplierID)
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT supplierID,CompanyName,Contact,DirectTelephone,Email FROM supplier WHERE supplierID=@supplierID", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@supplierID", supplierID);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];
        supplierAndComponent supall = new supplierAndComponent() {
            supplierID=(int)row["supplierID"],
            CompanyName=row["CompanyName"].ToString(),
            Contact=row["Contact"].ToString(),
            DirectTelephone=row["DirectTelephone"].ToString(),
            Email=row["Email"].ToString()

        };
        return supall;
    }
}