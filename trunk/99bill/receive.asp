<!--#include file="../common.asp"-->
<!--#include file="../big_md5.asp"-->
<%
'''''''''
 ' @Description: ��Ǯ���ؽӿڷ���
 ' @Copyright (c) �Ϻ���Ǯ��Ϣ�������޹�˾
 ' @version 2.0
'''''''''
	merchant_key =db_getvalue("setup_name='bill99_userkey'","sys_setup","setup_value")		'''�̻���Կ

	merchant_id = request("merchant_id")			'''��ȡ�̻����
	orderid =  request("orderid")		'''��ȡ�������
	amount =  request("amount")	'''��ȡ�������
	dealdate =  request("date")		'''��ȡ��������
	succeed =  request("succeed")	'''��ȡ���׽��,Y�ɹ�,Nʧ��
	mac =  request("mac")		'''��ȡ��ȫ���ܴ�
	merchant_param =  request("merchant_param")		'''��ȡ�̻�˽�в���

	couponid = request("couponid")		'''��ȡ�Ż�ȯ����
	couponvalue = request("couponvalue") 		'''��ȡ�Ż�ȯ���

	'''���ɼ��ܴ�,ע��˳��
	ScrtStr = "merchant_id=" & merchant_id & "&orderid=" & orderid & "&amount=" & amount & "&date=" & dealdate & "&succeed=" & succeed & "&merchant_key=" & merchant_key
	mymac=md5(ScrtStr) 
		

	 v_result="ʧ��"
	if ucase(mac)=ucase(mymac)   then 
			
			if succeed="Y"   then		'''֧���ɹ�
				
				v_result="�ɹ�"
				'''
				'''#�̻���վ�߼�����#
				'''  
				'��鶨��״̬ 
				order_no=orderid
				sql="update po_basic set po_status=2 where PO_NO='"&trim(order_no)&"'"
				conn.execute sql
				
			else		'''֧��ʧ��  
				response.write "<a href='" & url_path & "po_view.asp?id=" & orderid & "'>֧�����ɹ�!�뷵��!</a>"
				response.end
			end if

	else		'''ǩ������

	end if
	

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