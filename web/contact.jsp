<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">


    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/ListAds.css"/>">

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/contact.css"/>">

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">

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

<div class="jumbotron jumbotron-sm" style="margin-top: -20px; ">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 col-lg-12">
                <h2 class="h1"> Feel free to contact us
                    <%--<small>Feel free to contact us</small>--%>
                </h2>
            </div>
        </div>
    </div>
</div>


<div class="container" style="margin-top: 90px; ">
    <div class="row">

        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="well well-sm">
                <form action="/transit/message" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group"><label for="name"> Name</label> <input type="text"
                                                                                           class="form-control"
                                                                                           id="name"
                                                                                           name="name"
                                                                                           placeholder="Enter name"
                                                                                           required="required"/></div>
                            <div class="form-group"><label for="email"> Email Address</label>
                                <div class="input-group"><span class="input-group-addon"><span
                                        class="glyphicon glyphicon-envelope"></span> </span> <input type="email"
                                                                                                    class="form-control"
                                                                                                    id="email"
                                                                                                    name="email"
                                                                                                    placeholder="Enter email"
                                                                                                    required="required"/>
                                </div>
                            </div>
                            <div class="form-group"><label for="subject"> Subject</label> <input type="subject"
                                                                                                 class="form-control"
                                                                                                 id="subject"
                                                                                                 name="subject"
                                                                                                 placeholder="Enter subject"
                                                                                                 required="required"/></div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group"><label for="name"> Message</label> <textarea name="message"
                                                                                                 id="message"
                                                                                                 name="message"
                                                                                                 class="form-control"
                                                                                                 rows="9" cols="25"
                                                                                                 required="required"
                                                                                                 placeholder="Message"></textarea>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <button type="submit" class="btn btn-primary pull-right" id="btnContactUs"> Send Message
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<%@ include file="WEB-INF/footer.jsp" %>

</body>
</html>
