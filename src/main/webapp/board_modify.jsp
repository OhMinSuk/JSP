<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
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
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용 가능합니다.')");
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
		}
	%>
	<div id="wrap">
	<jsp:include page="nav.jsp" />
        <div id="contents">
            <div class="wrap">
                <div id="boardWrite">
                    <form action="modifyOk.jsp?board_no=<%= board_no %>" method="post" class="boardWriteForm" encType="multipart/form-data">
                        <div class="boardWriteHead">
                            <div class="boardWriteIndex">
                                <select name="board_index" required>
                                    <option value="">말머리 선택</option>
                                    <option value="삽니다">삽니다</option>
                                    <option value="팝니다">팝니다</option>
                                    <option value="거래완료">거래완료</option>
                                </select>
                            </div>
                            <div class="boardWriteTitle">
                                <label for="board_title">제목:</label>
                                <input type="text" name="board_title" id="board_title" value="<%=board.getBoard_title() %>" required>
                            </div>
                            <div class="boardWriteType">
                                <select name="board_type" required>
                                    <option value="">카테고리 선택</option>
                                    <option value="racket">테니스 라켓</option>
                                    <option value="etc">테니스 용품</option>
                                    <option value="cloth">테니스 의류</option>
                                </select>
                            </div>
                        </div>
                        <div class="boardWriteBody">
                            <div class="boardWriteFile">
                                <label>이미지 파일:</label>
                                <input type="file" name="file_name" accept="image/jpeg"/><%=board.getFile_name() %>
                           </div>
                            <div class="boardWriteContents">
                                <label for="board_contents">내용:</label>
                                <textarea name="board_contents" id="board_contents" rows="20" required><%=board.getBoard_contents() %></textarea>
                            </div>
                        </div>
                        <div class="boardWriteFooter">
                            <div class="boardWriteButton">
                                <button type="submit">수정</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>