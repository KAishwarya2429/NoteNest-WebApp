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

@WebServlet("/admin_settings")
public class AdminSettingsController extends HttpServlet {

	private AdminDao adminDao;

	@Override
	public void init() throws ServletException {
		try {
			Connection conn = MyHelper.getConnection();
			adminDao = new AdminDao(conn);
		} catch (Exception e) {
			throw new ServletException("Database connection error", e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Admins currentAdmin = (Admins) session.getAttribute("adminUser");

		if (currentAdmin == null) {
			response.sendRedirect("admin_login.jsp");
			return;
		}

		String newUsername = request.getParameter("username");
		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");

		try {
			// Check if current password is correct
			if (!currentAdmin.getPassword().equals(currentPassword)) {
				request.setAttribute("message", "❌ Current password is incorrect.");
				request.getRequestDispatcher("admin_settings.jsp").forward(request, response);
				return;
			}

			// If new password is provided, validate and set it
			if (newPassword != null && !newPassword.isEmpty()) {
				if (!newPassword.equals(confirmPassword)) {
					request.setAttribute("message", "❌ New passwords do not match.");
					request.getRequestDispatcher("admin_settings.jsp").forward(request, response);
					return;
				}
				currentAdmin.setPassword(newPassword);
			}

			// Update username
			currentAdmin.setUsername(newUsername);

			boolean updated = adminDao.updateAdmin(currentAdmin);
			if (updated) {
				session.setAttribute("adminUser", currentAdmin);
				request.setAttribute("message", "✅ Settings updated successfully.");
			} else {
				request.setAttribute("message", "❌ Update failed.");
			}

			request.getRequestDispatcher("admin_settings.jsp").forward(request, response);

		} catch (SQLException e) {
			throw new ServletException("Database error while updating settings", e);
		}
	}
}
