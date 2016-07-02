<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Arret" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Supprimer un arret</title>

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/ListAds.css"/>">
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
            background-color: #fefefe;
            font-family: montserrat, arial, verdana;
        }

        #map {
            margin-top: 50px;
            margin-left: 50px;
            height: 500px;
            width: 500px;
            border: black solid 2px;
        }

    </style>
</head>


<body>

<%@ include file="WEB-INF/navbar.jsp" %>

<br/>
<br/>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="tableaudebord">
                <div class="contact_container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <h2>Supprimer un arret</h2> <br/><br/>
                            <div class="nb_com" style="display:none">9</div>
                        </div>
                    </div>
                </div>

                <div class='container'>
                    <div class='row'>


                        <form class="form-horizontal" role="form" action="/transit/deleteArret" method="get">
                            <div class='row'>

                                <div class="col-lg-2">
                                </div>


                                <div class="col-lg-6">
                                    <!--<form class="form-horizontal" role="form">-->


                                    <div class="form-group">
                                        <label for="arret" class="col-sm-4 control-label">Nom arret </label>
                                        <div class="col-sm-8">
                                            <select class="form-control" name="arret" id="arret" required="required">
                                                <option value="0">  ---  Select arret  ---  </option>
                                                ${arrets}
                                            </select>
                                        </div>
                                    </div>


                                    <div class="boutton">
                                        <div class="col-lg-5 col-md-7 hidden-md hidden-xs"></div>
                                        <div class="col-lg-1 col-md-1 col-xs-12">
                                            <input type="submit" id="submit" value="Supprimer"
                                                   class="btn btn-primary">
                                        </div>

                                    </div>

                                </div>


                            </div>


                        </form>

                        <br/><br/>
                        <br/><br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<br/><br/><br/><br/>
<br/>
<br/>
<br/>
<br/>
<br/>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<%@ include file="WEB-INF/footer.jsp" %>

</body>
</html>

