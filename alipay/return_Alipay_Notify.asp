<!--#include file="../big_md5.asp"-->

<%
'Add by sunzhizhi 2006-5-10
Dim key
'Partner 和 交易安全校验码
partner=""   'partner合作伙伴id
key =  ""  '安全校验码
'*****************************************************************
'ATN 校验地址 （两种方案可以选择使用https.http）
alipayNotifyURL = "https://www.alipay.com/cooperate/gateway.do?"
alipayNotifyURL	= alipayNotifyURL & "service=notify_verify&partner=" & partner & "&notify_id=" & Request.QueryString("notify_id")
'如果你的服务器不支持https访问的话，可以使用http查询地址,具体如下：
'alipayNotifyURL = "http://notify.alipay.com/trade/notify_query.do?"
'alipayNotifyURL = alipayNotifyURL &"partner=" & partner & "&notify_id=" & request.QueryString("notify_id")

Set Retrieval = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
Retrieval.setOption 2, 13056 
Retrieval.open "GET", alipayNotifyURL, False, "", "" 
Retrieval.send()
ResponseTxt = Retrieval.ResponseText
Set Retrieval = Nothing
'*******************************************************************
'获得 支付宝get过来的通知消息 
For Each varItem in Request.QueryString 
mystr=varItem&"="&Request.QueryString(varItem)&"^"&mystr
Next 
If mystr<>"" Then 
mystr=Left(mystr,Len(mystr)-1)
End If
'*******************************************************************
'对参数排序
mystr = SPLIT(mystr, "^")
Count=ubound(mystr)
For i = Count TO 0 Step -1
    minmax = mystr( 0 )
    minmaxSlot = 0
    For j = 1 To i
            mark = (mystr( j ) > minmax)
        If mark Then 
            minmax = mystr( j )
            minmaxSlot = j
        End If
    Next
    
    If minmaxSlot <> i Then 
        
        temp = mystr( minmaxSlot )
        mystr( minmaxSlot ) = mystr( i )
        mystr( i ) = temp
    End If
 Next
	
 
 '构造md5摘要字符串
  For j = 0 To Count Step 1
  value = SPLIT(mystr( j ), "=")

  If  value(0)<>"sign" And value(0)<>"sign_type"  then
       If j=Count Then
       md5str= md5str&mystr( j )
	   Else 
       md5str= md5str&mystr( j )&"&"
	   End If 
  End If 
  Next

 md5str=md5str&key
 '生成md5摘要
 mysign=md5(md5str)

'*******************************************************************  
'验证消息的可靠性，并且处理自己的业务动作，然后反回给支付宝成功消息
If mysign=Request.QueryString("sign") And ResponseTxt="true"  Then 	

     '判断支付状态，（文档中有支付枚举表，可供参考）
	 If  Request.QueryString("trade_status")="TRADE_FINISHED" Then 
     '支付宝收到买家付款，请卖家发货 ,修改订单状态，发货等
   


					
response.write "success"
End if

Else
response.write "fail"
End If 

'*******************************************************************
 '写文本，纪录支付宝返回消息，比对md5计算结果（如网站不支持写txt文件，可改成写数据库）
TOEXCELLR=TOEXCELLR&md5str&"MD5结果:"&mysign&"="&request.Form("sign")&"--ResponseTxt:"&ResponseTxt
set fs= createobject("scripting.filesystemobject") 
set ts=fs.createtextfile(server.MapPath("Notify_DATA/"&replace(now(),":","")&".txt"),true)
ts.writeline(TOEXCELLR)
ts.close
set ts=Nothing
set fs=Nothing

%>