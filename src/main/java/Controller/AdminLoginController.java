package Controller;

import Dao.AdminDao;
import Entities.Admins;
import MyHelper.MyHelper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/admin_login")
public class AdminLoginController extends HttpServlet {

	private AdminDao adminDAO;

	@Override
	public void init() throws ServletException {
		try {
			Connection conn = MyHelper.getConnection();
			if (conn == null) {
				throw new ServletException("Unable to establish database connection.");
			}
			adminDAO = new AdminDao(conn);
		} catch (Exception e) {
			throw new ServletException("DB connection error", e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
			request.setAttribute("errorMessage", "Username and Password must not be empty.");
			request.getRequestDispatcher("admin_login.jsp").forward(request, response);
			return;
		}

		try {
			Admins admin = adminDAO.validateAdmin(username, password);
			if (admin != null) {
				HttpSession session = request.getSession();
				session.setAttribute("adminUser", admin);
				response.sendRedirect("admin_dashboard.jsp");
			} else {
				request.setAttribute("errorMessage", "Invalid username or password.");
				request.getRequestDispatcher("admin_login.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			throw new ServletException("Database error during admin login", e);
		}
	}
}
