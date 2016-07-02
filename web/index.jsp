<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/ListAds.css"/>">

    <style type="text/css">
        /*custom font*/
        @import url(http://fonts.googleapis.com/css?family=Montserrat);

        /*basic reset*/
        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: montserrat, arial, verdana;
            background: url("resources/jumbo.jpg");
            background-size: 100%;
            background-repeat: no-repeat;

        }


        input select{
            height: 100px;
        }

        select.transparent-input{
            background-color: rgba(255, 255, 255, 0.6);
            border:none;
        }
    </style>
</head>


<body>

<%@ include file="/WEB-INF/navbar.jsp" %>


<form class="form-horizontal" id="myform" role="form" action="/transit/path" method="post">

    <div class="form-group" style="padding-top: 250px;">
        <div class="col-md-12">
            <div class="form-group row">
                <div class="col-md-2"></div>
                <div class="col-md-3">
                    <select class="form-control input-lg transparent-input" id="from" name="from">
                        <option value="0">  ----------    depart    ---------- </option>
                        ${arrets}
                    </select>
                </div>

                <div class="col-md-3">
                    <select class="form-control input-lg transparent-input" id="to" name="to">
                        <option value="0">  ----------    arrivee    ---------- </option>
                        ${arrets}
                    </select>
                </div>

                <div class="col-md-2">
                    <input type="button" class="btn btn-block btn-primary btn-lg" value="Recherche" onclick="verify()">

                </div>
            </div>
        </div>
    </div>
</form>



<%--<%@ include file="/WEB-INF/footer.jsp" %>--%>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script>
    function verify()
    {
        if(document.getElementById("from").value==document.getElementById("to").value)
        {
            alert("your destination can't be your departure.");
        }
        else
        {
            document.getElementById("myform").submit();
        }

    }
</script>

</body>
</html>