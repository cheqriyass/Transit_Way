<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="javafx.geometry.Pos" %>
<%@ page import="org.omg.CORBA.RepositoryIdHelper" %>
<%@ page import="model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Carte</title>

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
            margin-top: 20px;
            margin-bottom: 50px;
            margin-left: 150px;
            height: 500px;
            width: 80%;
            border: black solid 2px;
        }

    </style>
</head>


<body>

<%@ include file="WEB-INF/navbar.jsp" %>

<%

    Ligne ligne = (Ligne) request.getSession().getAttribute("ligne");
    List<Arret> arrets = ligne.getArrets();

    List<Bus> buses = (List<Bus>) request.getSession().getAttribute("buses");
    List<Position> pos = (List<Position>) request.getSession().getAttribute("pos");

%>

<form class="form-horizontal" id="myForm" role="form" action="/transit/carte" method="get">

    <br/>
    <div class="container">
        <div class="row">

            <div class="col-sm-4"></div>
            <div class="col-sm-3" style="margin-left: 20px">
                <div class="form-group">
                    <select class="form-control" name="ligne" id="ligne"
                            onchange="submitForm()">
                        <option value="0"> --- Selectionner une ligne ---</option>
                        ${lignes}
                    </select>
                </div>
            </div>
        </div>


        <div class="row">

            <div class="col-sm-5"></div>
            <div class="col-sm-6">
                <h2>Ligne <%=ligne.getNumero()%>

            </div>


        </div>
    </div>

</form>


<div id="map"></div>

<script>

    function submitForm() {
        document.getElementById("myForm").submit();
    }


    var markers = [];
    var arr = [];
    var cnt = 0;
    var lat_lng = new Array();
    var buspos = new Array();
    function initMap() {


        latitude = 31.6345449;
        longitude = -8.0079382;
        var cord = {lat: latitude, lng: longitude};
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 13,
            center: cord
        });


        var markerImage = new google.maps.MarkerImage('/transit/resources/icons/buspos.png',
                new google.maps.Size(64, 64),
                new google.maps.Point(0, 0),
                new google.maps.Point(32, 32));


//        var mark = "/transit/resources/icons/bus.png";

        var mark = {
            path: google.maps.SymbolPath.CIRCLE,
            fillOpacity: 0.7,
            fillColor: '<%=ligne.getCouleur()%>',
            strokeOpacity: 1.0,
            strokeColor: 'white',
            strokeWeight: 3.0,
            scale: 10 //pixels
        };

        (function () {


            $.ajax({
                url: '/transit/refresh', // url where to submit the request
                type: "GET", // type of action POST || GET
                dataType: 'text', // data type
                data: {
                    ligne: <%=ligne.getNumero()%>
                }, // post data || get data
                success: function (result) {

                    console.log(result);


                    var obj = jQuery.parseJSON(result);

                    if (buspos.length == 0) {
                        for (var i = 0; i < obj.length; i++) {

                            var myLatlng = new google.maps.LatLng(obj[i].latitude, obj[i].longitude);

                            var marker = new google.maps.Marker({
                                position: myLatlng,
                                map: map,
                                title: obj[i].busname,
                                icon: mark,
                                zIndex: 1200,
                            });

                            var x = obj[i].busname;
                            marker.info = new google.maps.InfoWindow({
                                content: x
                            });

                            marker.addListener('click', function() {
                                this.info.open(map, this);
                            });
                            marker.setZIndex(google.maps.Marker.MAX_ZINDEX + 1);
                            buspos.push(marker);
                        }
                    } else {
                        for (var i = 0; i < obj.length; i++) {

                            var myLatlng = new google.maps.LatLng(obj[i].latitude, obj[i].longitude);

                            buspos[i].setPosition(myLatlng);
                        }
                    }


                },
                error: function (e) {
                    console.log("err" + e);
                }
            })
            setTimeout(arguments.callee, 2000);
        })();


        <%--<%--%>
        <%--for (Arret a : arrets) {--%>
        <%--%>--%>


        <%--var myLatlng = new google.maps.LatLng(<%= a.getLatitude() %>, <%= a.getLongitude() %>);--%>
        <%--lat_lng.push(myLatlng);--%>

        <%--var marker = new google.maps.Marker({--%>
        <%--position: myLatlng,--%>
        <%--map: map,--%>
        <%--title: "<%= a.getNom()%>",--%>
        <%--icon: "/transit/resources/icons/bus.png"--%>
        <%--});--%>

        <%--marker.info = new google.maps.InfoWindow({--%>
        <%--content: '<%= a.getNom()%>'--%>
        <%--});--%>

        <%--marker.addListener('click', function() {--%>
        <%--this.info.open(map, this);--%>
        <%--});--%>


        <%--<%--%>
        <%--}--%>
        <%--%>--%>


        <%--//Initialize the Path Array--%>
        <%--var path = new google.maps.MVCArray();--%>


        <%--var directionsDisplay = new google.maps.DirectionsRenderer;--%>


        <%--//Initialize the Direction Service--%>
        <%--var service = new google.maps.DirectionsService();--%>

        <%--//Set the Path Stroke Color--%>
        <%--var poly = new google.maps.Polyline({map: map ,strokeColor: '<%=ligne.getCouleur()%>'});--%>

        <%--//Loop and Draw Path Route between the Points on MAP--%>
        <%--for (var i = 0; i < lat_lng.length - 1; i++) {--%>
        <%--var src = lat_lng[i];--%>
        <%--var des = lat_lng[i + 1];--%>
        <%--//            path.push(src);--%>
        <%--service.route({--%>
        <%--origin: src,--%>
        <%--destination: des,--%>
        <%--travelMode: google.maps.DirectionsTravelMode.DRIVING--%>
        <%--}, function (result, status) {--%>
        <%--if (status == google.maps.DirectionsStatus.OK) {--%>
        <%--for (var i = 0, len = result.routes[0].overview_path.length; i < len; i++) {--%>
        <%--path.push(result.routes[0].overview_path[i]);--%>
        <%--}--%>
        <%--}--%>
        <%--});--%>

        <%--}--%>

        <%--poly.setPath(path);--%>


        var directionsService = new google.maps.DirectionsService;


        var waypts = [];
        var directionsDisplay = new google.maps.DirectionsRenderer({
            suppressMarkers: true,
            polylineOptions: {
                strokeColor: "<%=ligne.getCouleur()%>"
            }
        });

        directionsDisplay.setMap(map);


        var or = new google.maps.LatLng(<%= arrets.get(0).getLatitude() %>, <%= arrets.get(0).getLongitude() %>);


        var marker = new google.maps.Marker({
            position: or,
            map: map,
            title: "<%= arrets.get(0).getNom()%>",
            icon: "/transit/resources/icons/bus.png"
        });

        marker.info = new google.maps.InfoWindow({
            content: '<%= arrets.get(0).getNom()%>'
        });

        marker.addListener('click', function() {
            this.info.open(map, this);
        });

        <%

        for (int i = 1; i<arrets.size()-1; i++) {
        %>


        var myLatlng = new google.maps.LatLng(<%= arrets.get(i).getLatitude() %>, <%= arrets.get(i).getLongitude() %>);

        waypts.push({
            location: myLatlng,
            stopover: true
        });

        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: "<%= arrets.get(i).getNom()%>",
            icon: "/transit/resources/icons/bus.png"
        });

        marker.info = new google.maps.InfoWindow({
            content: '<%= arrets.get(i).getNom()%>'
        });

        marker.addListener('click', function() {
            this.info.open(map, this);
        });
        <%
        }
        %>


        var des = new google.maps.LatLng(<%= arrets.get(arrets.size()-1).getLatitude() %>, <%= arrets.get(arrets.size()-1).getLongitude() %>);


        var marker = new google.maps.Marker({
            position: des,
            map: map,
            title: "<%= arrets.get(arrets.size()-1).getNom()%>",
            icon: "/transit/resources/icons/bus.png"
        });

        marker.info = new google.maps.InfoWindow({
            content: '<%= arrets.get(arrets.size()-1).getNom()%>'
        });

        marker.addListener('click', function() {
            this.info.open(map, this);
        });


        directionsService.route({
            origin: or,
            destination: des,
            waypoints: waypts,
            optimizeWaypoints: true,
            travelMode: google.maps.TravelMode.DRIVING
        }, function (response, status) {
            if (status === google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);

            } else {
                window.alert('Directions request failed due to ' + status);
            }
        });


    }


</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkB3oJ1rKgHxV1vFa3vmOO1cTnNu_imgc &callback=initMap">
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>


<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<%@ include file="WEB-INF/footer.jsp" %>

</body>
</html>

