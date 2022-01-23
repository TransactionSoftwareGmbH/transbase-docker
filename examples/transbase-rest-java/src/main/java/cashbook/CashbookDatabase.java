package cashbook;

import java.sql.*;
import java.util.*;

public class CashbookDatabase
{
    private final String dburl;
    private final String uname;
    private final String pw;

    public CashbookDatabase()
    {
        this("jdbc:transbase://transbase.db:2024/sample", "tbadmin", "");
    }

    public CashbookDatabase(String url, String username, String password)
    {
        this.dburl = url;
        this.uname = username;
        this.pw = password;

        try
        {
            Class.forName("transbase.jdbc.Driver");
        }
        catch (ClassNotFoundException e) {}
    }

    public List<Cashbook> getAll()
    {
        try
        {
            Connection conn = DriverManager.getConnection(dburl, uname, pw);
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery("select * from cashbook");
            List<Cashbook> cashbooks = new ArrayList<>();
            while (rset.next())
            {
                cashbooks.add(
                    new Cashbook(rset.getString("nr"), rset.getString("amount"), rset.getString("date"),
                        rset.getString("comment")));
            }
            return cashbooks;
        }
        catch (SQLException e)
        {
            throw new RuntimeException(e);
        }
    }
}
