<!--#include file="../common.asp"-->
<!--#include file="md5.asp"-->
<%
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from po_basic where PO_NO='" & request("id") & "'"
	if request("action")="success" then
				'��鶨��״̬ 
				order_no=orderid
				sql="update po_basic set po_status=2 where PO_NO='"&trim(order_no)&"'"
				conn.execute sql

	else		'''ǩ������
			response.write "<a href='" & url_path & "po_view.asp?id=" & orderid & "'>֧�����ɹ�!�뷵��!</a>"
				response.end
	end if
	orderid=rs("po_no")
	amount=rs("po_price")+rs("po_freight")
	v_result=request("action")
%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
	<head>
		<title>��Ǯ99bill</title>
		<meta http-equiv="content-type" content="text/html; charset=gb2312" />
	</head>
	
	<body>
		
		<div align="center">
		<table width="259" border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" >
			<tr bgcolor="#FFFFFF">
				<td width="68">�������:</td>
			  <td width="182"><%=orderid%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>�������:</td>
			  <td><%=amount%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>֧�����:</td>
			  <td><%=v_result%></td>
			</tr>
	  </table>
	</div>

	</body>
</html>