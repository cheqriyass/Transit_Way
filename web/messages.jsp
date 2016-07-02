<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="algorithms.Edge" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.LigneDaoImpl" %>
<%@ page import="model.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Messages</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/ListAds.css"/>">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/messages.css"/>">

    <style type="text/css">
        /*custom font*/
        @import url(http://fonts.googleapis.com/css?family=Montserrat);

        /*basic reset*/
        * {
            margin: 0;
            padding: 0;
        }

        html {
            height: 100%;
            /*background-color: #edeff2;*/

        }

        body {
            font-family: montserrat, arial, verdana;
        }

    </style>


</head>
<body>


<jsp:include page="WEB-INF/navbar.jsp"></jsp:include>

<br/>
<br/>

<div class="container">
    <div class="row">

        <section class="content">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h2 class="text-center" style="margin-bottom: 20px">Messages</h2>

                        <div class="table-container">
                            <table class="table">

                                <%
                                    List<Message> list = (List<Message>) request.getSession().getAttribute("messages");

                                    for (Message m : list) {
                                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy ' à ' hh:mm:ss");
                                        String date = sdf.format(m.getTimestamp());
                                %>


                                <tr>

                                    <td width="100%">
                                        <div class="media">
                                            <div class="media-body">
                                                <span class="media-meta pull-right"><%=date%></span>
                                                <h3 class="summary" style="color: blue;">
                                                    <%=m.getName()%>
                                                </h3>
                                                <p class="summary"><%=m.getMessage()%></p>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }

                                %>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </section>

    </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<%@ include file="WEB-INF/footer.jsp" %>

</body>
</html>
