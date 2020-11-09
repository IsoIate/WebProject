package demo;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MyController")
public class MyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("passwd");
		
		Database db = new Database();
		String retVal = null;
		String nextPage = null;
		
		DTOUser user = db.findId(id);
		if(user.getPasswd() != null) {
			if(user.getPasswd().equals(pw)) {
				request.setAttribute("name", user.getName());
				nextPage = "index.jsp";
			}
			else {
				nextPage = "pass_error.jsp";
			}
		}
		else {
			nextPage = "id_error.jsp";
		}
		RequestDispatcher disp = request.getRequestDispatcher(nextPage);
		disp.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
