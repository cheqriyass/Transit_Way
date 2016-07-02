<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="javafx.geometry.Pos" %>
<%@ page import="org.omg.CORBA.RepositoryIdHelper" %>
<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.BusDaoImpl" %>
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
            margin-left: 100px;
            height: 700px;
            width: 1200px;
            border: black solid 2px;
        }

    </style>
</head>


<body>

<%@ include file="WEB-INF/navbar.jsp" %>

<%
    List<Ligne> lignelist = (List<Ligne>) session.getAttribute("lignelist");

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

            <div class="col-sm-4"></div>
            <div class="col-sm-6">
                <h2 style="margin-left: 35px">Toutes les Lignes</h2>

            </div>


        </div>
    </div>

</form>


<div id="map"></div>

<script>

    function submitForm() {
        document.getElementById("myForm").submit();
    }


    <%

        List<List<Position>> listofpos = (List<List<Position>>) request.getSession().getAttribute("listofpos");
        List<List<Bus>> listofbus = (List<List<Bus>>) request.getSession().getAttribute("listofbus");


    %>



//    function initMap2() {
//        var directionsService = new google.maps.DirectionsService;
//        directionsDisplay = new google.maps.DirectionsRenderer({
//            polylineOptions: {
//                strokeColor: "red"
//            }
//        });
//        latitude = 31.6345449;
//        longitude = -8.0079382;
//        var cord = {lat: latitude, lng: longitude};
//        var map = new google.maps.Map(document.getElementById('map'), {
//            zoom: 6,
//            center: cord
//        });
//        directionsDisplay.setMap(map);
//
//        calculateAndDisplayRoute(directionsService, directionsDisplay);
//    }
//
//    function calculateAndDisplayRoute(directionsService, directionsDisplay) {
//        var waypts = [];
//
//        waypts.push({
//            location: new google.maps.LatLng(31.6548426356952, -8.019791543483734),
//            stopover: true
//        });
//
//        waypts.push({
//            location: new google.maps.LatLng(31.65275580096455, -8.019719123840332),
//            stopover: true
//        });
//
//
//
//
//        directionsService.route({
//            origin: new google.maps.LatLng(31.657011615565295, -8.022213578224182),
//            destination: new google.maps.LatLng(31.647860459914572, -8.020185828208923),
//            waypoints: waypts,
//            optimizeWaypoints: true,
//            travelMode: google.maps.TravelMode.DRIVING
//        }, function(response, status) {
//            if (status === google.maps.DirectionsStatus.OK) {
//                directionsDisplay.setDirections(response);
//
//            } else {
//                window.alert('Directions request failed due to ' + status);
//            }
//        });
//    }





    function initMap() {


        var mark = {
            path: google.maps.SymbolPath.CIRCLE,
            fillOpacity: 0.7,
            fillColor: '',
            strokeOpacity: 1.0,
            strokeColor: 'white',
            strokeWeight: 3.0,
            scale: 10 //pixels
        };


        latitude = 31.6345449;
        longitude = -8.0079382;
        var cord = {lat: latitude, lng: longitude};
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 13,
            center: cord
        });



        var directionsService = new google.maps.DirectionsService;



        <%
        int ii=0;
        for (Ligne l : lignelist) {
        ii++;
        %>

        var waypts<%=ii%> = [];
        var directionsDisplay<%=ii%> = new google.maps.DirectionsRenderer({
            suppressMarkers: true,
            polylineOptions: {
                strokeColor: "<%=l.getCouleur()%>"
            }
        });

        directionsDisplay<%=ii%>.setMap(map);

        <%

        List<Arret> arr = l.getArrets();
        %>



        var or = new google.maps.LatLng(<%= arr.get(0).getLatitude() %>, <%= arr.get(0).getLongitude() %>);



        var marker = new google.maps.Marker({
            position: or,
            map: map,
            title: "<%= arr.get(0).getNom()%>",
            icon: "/transit/resources/icons/bus.png"
        });


        marker.info = new google.maps.InfoWindow({
            content: '<%= arr.get(0).getNom()%>'
        });

        marker.addListener('click', function() {
            this.info.open(map, this);
        });


        <%

        for (int i = 1; i<arr.size()-1; i++) {
        %>


        var myLatlng = new google.maps.LatLng(<%= arr.get(i).getLatitude() %>, <%= arr.get(i).getLongitude() %>);

        waypts<%=ii%>.push({
            location: myLatlng,
            stopover: true
        });

        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: "<%= arr.get(i).getNom()%>",
            icon: "/transit/resources/icons/bus.png"
        });

        marker.info = new google.maps.InfoWindow({
            content: '<%= arr.get(i).getNom()%>'
        });

        marker.addListener('click', function() {
            this.info.open(map, this);
        });

        <%
        }
        %>


        var des = new google.maps.LatLng(<%= arr.get(arr.size()-1).getLatitude() %>, <%= arr.get(arr.size()-1).getLongitude() %>);


        var marker = new google.maps.Marker({
            position: des,
            map: map,
            title: "<%= arr.get(arr.size()-1).getNom()%>",
            icon: "/transit/resources/icons/bus.png"
        });

        marker.info = new google.maps.InfoWindow({
            content: '<%= arr.get(arr.size()-1).getNom()%>'
        });

        marker.addListener('click', function() {
            this.info.open(map, this);
        });

        directionsService.route({
            origin: or,
            destination: des,
            waypoints: waypts<%=ii%>,
            optimizeWaypoints: true,
            travelMode: google.maps.TravelMode.DRIVING
        }, function(response, status) {
            if (status === google.maps.DirectionsStatus.OK) {
                directionsDisplay<%=ii%>.setDirections(response);

            } else {
                window.alert('Directions request failed due to ' + status);
            }
        });


        <%
        }
        %>



        <%

BusDaoImpl bdao = new BusDaoImpl();


for(int i = 0; i <listofpos.size() ; i++) {
    List<Position> lp = listofpos.get(i);
    List<Bus> lb = listofbus.get(i);
  for(int j = 0; j <lp.size() ; j++) {
         Ligne ligne = bdao.findByIp(lb.get(0).getName()).getLigne();

        Position p = lp.get(j);
        Bus b = lb.get(j);

        %>


        var mark = {
            path: google.maps.SymbolPath.CIRCLE,
            fillOpacity: 0.7,
            fillColor: '<%=ligne.getCouleur()%>',
            strokeOpacity: 1.0,
            strokeColor: 'white',
            strokeWeight: 3.0,
            scale: 10 //pixels
        };

        var myLatlng = new google.maps.LatLng(<%=p.getLat()%>, <%=p.getLon()%>);

        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: "<%=b.getName()%>",
            icon: mark,
            zIndex: 1200,
        });
        marker.setZIndex(google.maps.Marker.MAX_ZINDEX + 1);

        marker.info = new google.maps.InfoWindow({
            content: '<%= b.getName()%>'
        });

        marker.addListener('click', function () {
            this.info.open(map, this);
        });

        <%
          }
        }
        %>


        map.setZoom(16);


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

