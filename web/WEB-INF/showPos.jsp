<%@ page import="java.util.Map" %>
<%@ page import="model.Arret" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Position" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration</title>

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">


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

<%@ include file="navbar.jsp" %>


<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="tableaudebord">
                <div class="contact_container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <h2>Positions</h2> <br/><br/>
                            <div class="nb_com" style="display:none">9</div>
                        </div>
                    </div>
                </div>

                <div class='container'>
                    <div class='row'>


                            <div class='row'>

                                <div class="col-lg-6">




                                    <div class="form-group">
                                        <div class="col-sm-9" id="map"></div>
                                    </div>


                                </div>





                            </div>


                            <br/><br/>



                        <br/><br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%
    List<Position> positions = (List<Position>) request.getSession().getAttribute("positions");

%>
<script>
    var markers = [];
    var arr = [];
    var cnt = 0;
    function initMap() {


        latitude = 31.6345449;
        longitude = -8.0079382;
        var cord = {lat: latitude, lng: longitude};
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 14,
            center: cord
        });

        map.addListener('click', function (e) {
            placeMarker(e.latLng, map);
        });

        <%
        for (Position p : positions) {
        %>


        var latLng = {lat: <%= p.getLatitude() %>, lng: <%= p.getLongitude() %>};
        var marker = new google.maps.Marker({
            position: latLng,
            map: map,
//            icon: "/transit/resources/icons/bus.png"
        });



        <%
        }
        %>


    }



</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkB3oJ1rKgHxV1vFa3vmOO1cTnNu_imgc &callback=initMap">
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>





<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


</body>
</html>

