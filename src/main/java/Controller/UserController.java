package Controller;

import Dao.UserDao;
import Entities.User;
import Entities.Note;
import java.util.List;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private UserDao dao;

	@Override
	public void init() {
		dao = new UserDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		HttpSession session = request.getSession();

		if ("register".equals(action)) {
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("confirm_password");

			if (!password.equals(confirmPassword)) {
				response.sendRedirect("register.jsp?error=Passwords do not match");
				return;
			}
			String hashedPassword = password; // TODO: hash password properly

			User user = new User();
			user.setUsername(username);
			user.setEmail(email);
			user.setPasswordHash(hashedPassword);
			user.setUserType("user");
			user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
			user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

			boolean isRegistered = dao.registerUser(user);

			if (isRegistered) {
				response.sendRedirect("dashboard.jsp?success=registered");
			} else {
				response.sendRedirect("register.jsp?error=Registration failed");
			}

		} else if ("login".equals(action)) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");

			String hashedPassword = password; // TODO: hash password properly

			User user = dao.loginUser(email, hashedPassword);
			if (user != null) {
				session.setAttribute("user", user);
				session.setAttribute("message", "Login successful!");
				response.sendRedirect("dashboard.jsp");
			} else {
				session.setAttribute("message", "Invalid email or password.");
				response.sendRedirect("login.jsp");
			}

		}// Inside your UserController servlet's doPost or service method
		else if ("addnote".equals(action)) {
		    try {
		        int userId = Integer.parseInt(request.getParameter("user_id"));  // ✅ FIXED

		        String title = request.getParameter("title");
		        String content = request.getParameter("content");
		        String category = request.getParameter("category");

		        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

		        Note note = new Note();
		        note.setUserId(userId);
		        note.setTitle(title);
		        note.setContent(content);
		        note.setCategory(category);
		        note.setCreatedAt(currentTimestamp);
		        note.setUpdatedAt(currentTimestamp);

		        boolean isAdded = dao.addNote(note);
		        System.out.println("Is note added? " + isAdded);

		        if (isAdded) {
		            response.sendRedirect(request.getContextPath() + "/dashboard.jsp?message=Note+added+successfully");
		        } else {
		            request.setAttribute("errorMessage", "Failed to add note. Please try again.");
		            request.getRequestDispatcher("add_note.jsp").forward(request, response);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        request.setAttribute("errorMessage", "An error occurred while adding note.");
		        request.getRequestDispatcher("add_note.jsp").forward(request, response);
		    }
		}

else if ("updateNote".equals(action)) {
			try {

				int noteId = Integer.parseInt(request.getParameter("noteId"));
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String category = request.getParameter("category");

				Note note = dao.getNoteById(noteId);
				if (note == null) {
					request.setAttribute("errorMessage", "Note not found.");
					request.getRequestDispatcher("edit_note.jsp").forward(request, response);
					return;
				}

				note.setTitle(title);
				note.setContent(content);
				note.setCategory(category);
				note.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

				boolean updated = dao.updateNote(note);
				if (updated) {
					response.sendRedirect("dashboard.jsp?message=Note+updated+successfully");
				} else {
					request.setAttribute("errorMessage", "Failed to update note.");
					request.getRequestDispatcher("edit_note.jsp").forward(request, response);
				}

			} catch (NumberFormatException e) {
				request.setAttribute("errorMessage", "Invalid note ID.");
				request.getRequestDispatcher("edit_note.jsp").forward(request, response);
			}

		} else {
			response.sendRedirect("dashboard.jsp");
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		HttpSession session = request.getSession(false);

		User user = (User) session.getAttribute("user");

		if (action == null || action.equals("viewAll")) {
			// View all notes belonging to this user
			List<Note> notes = dao.getNotesByUserId(user.getUserId());
			request.setAttribute("notes", notes);
			request.setAttribute("userName", user.getUsername());
			request.getRequestDispatcher("dashboard.jsp").forward(request, response);

		} else if ("adminViewAllNotes".equals(action)) {
			// View all notes from all users
			List<Note> allNotes = dao.getAllNotes(); 
			request.setAttribute("notes", allNotes);
			request.setAttribute("userName", user.getUsername());
			request.getRequestDispatcher("admin_notes.jsp").forward(request, response);

		} else if ("getNote".equals(action)) {
			//  View single note
			String noteIdStr = request.getParameter("noteId");
			try {
				int noteId = Integer.parseInt(noteIdStr);
				Note note = dao.getNoteById(noteId);

				if (note != null) {
					request.setAttribute("note", note);
					request.getRequestDispatcher("view_note.jsp").forward(request, response);
				} else {
					response.sendRedirect("dashboard.jsp?error=Note+not+found");
				}
			} catch (NumberFormatException e) {
				response.sendRedirect("dashboard.jsp?error=Invalid+note+ID");
			}

		} else if ("deleteNote".equals(action)) {
			// Delete note
			String noteIdStr = request.getParameter("noteId");
			try {
				int noteId = Integer.parseInt(noteIdStr);
				boolean deleted = dao.deleteNoteById(noteId);

				if (deleted) {
					response.sendRedirect("admin_users.jsp?message=Note+deleted+successfully");
				} else {
					response.sendRedirect("dashboard.jsp?error=Failed+to+delete+note");
				}
			} catch (NumberFormatException e) {
				response.sendRedirect("dashboard.jsp?error=Invalid+note+ID");
			}

		} else if ("adminViewAllNotes".equals(action)) {
			List<Note> notes = dao.getAllNotes();
			request.setAttribute("notes", notes);
			request.getRequestDispatcher("admin_notes.jsp").forward(request, response);
		}

		else {
			response.sendRedirect("dashboard.jsp");
		}
	}

}
