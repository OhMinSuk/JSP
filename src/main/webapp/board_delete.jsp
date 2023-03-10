<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp" />
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int board_no = 0;
		if (request.getParameter("board_no") != null){
			board_no = Integer.parseInt(request.getParameter("board_no"));
		}
		if (board_no == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
		Board board = new BoardDAO().getBoard(board_no);
		if (!userID.equals(board.getUser_id())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href = './'");
			script.println("</script>");
		} else{
			BoardDAO boardDAO = new BoardDAO();
			int result = boardDAO.delete(board_no);
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글삭제 에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>"); 
			script.println("alert('삭제 성공')");
			script.println("location.href= 'index.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>