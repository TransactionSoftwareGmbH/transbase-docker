package cashbook;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.fasterxml.jackson.databind.ObjectMapper;
 
@WebServlet(urlPatterns = {"/*"}, loadOnStartup = 1)
public class CashbookServlet extends HttpServlet 
{
    private ObjectMapper mapper = new ObjectMapper();

    @Override 
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        res.getOutputStream().print(
            mapper.writeValueAsString(
                new CashbookDatabase().getAll()));
    }
}