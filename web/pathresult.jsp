<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="algorithms.Edge" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.LigneDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="javafx.geometry.Pos" %>
<%@ page import="dao.BusDaoImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Itineraire</title>

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/messages.css"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/timeline.css"/>">
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
            margin-left: 10px;
            height: 550px;
            width: 550px;
            /*border: black solid 2px;*/
        }

    </style>


</head>
<body>


<%@ include file="WEB-INF/navbar.jsp" %>


<%
    ArrayList<Ligne> lignelist = (ArrayList<Ligne>) session.getAttribute("lignelist");

%>


<div class="container">
    <div class="row">

        <section class="content" style="margin-top: 40px">
            <div class="col-md-12">
                <div class="panel panel-default" style="width: 1050px; margin-left: -50px;">
                    <div class="panel-body">
                        <h2 class="text-center" style="margin-bottom: 20px">Itineraire</h2>

                        <div class="table-container" style="width: 1000px;">
                            <table class="table">

                                <tr>
                                    <td width="40%">
                                        <div class="container" style="width: 400px; margin-top: 50px">
                                            <ul class="timeline">

                                                <%
                                                    ArrayList<Edge> result = (ArrayList<Edge>) session.getAttribute("path");
                                                    for (int i = result.size() - 1; i >= 0; i--) {
                                                        Edge edge = result.get(i);
                                                %>
                                                <%--<%=edge.getFrom().getNom()%> -> <%=edge.getTo().getNom()%><br>--%>
                                                <%--Temps estimee : <%=(int)edge.getTime()%> Min<br>--%>
                                                <%--distance de trajet:<%=edge.getDistance()%> Km<br>--%>

                                                <%
                                                    LigneDaoImpl dao = new LigneDaoImpl();
                                                    Ligne ligne = dao.find(edge.getLigne());
                                                %>
                                                <%--ligne : <%=numero%><br>--%>


                                                <li>
                                                    <div class="timeline-badge"
                                                         style="background-color: <%=ligne.getCouleur()%>"></div>
                                                    <div class="timeline-panel">
                                                        <div class="timeline-heading">
                                                            <h4 class="timeline-title"><%=edge.getFrom().getNom()%> <i
                                                                    class="glyphicon glyphicon-arrow-right"
                                                                    style="margin-left: 15px; margin-right:15px;"></i> <%=edge.getTo().getNom()%>
                                                            </h4>
                                                            <p>
                                                                <small class="text-muted"><i
                                                                        class="glyphicon glyphicon-time"
                                                                        style="margin-left:10px"></i> <%=(int) edge.getTime()%>
                                                                    min
                                                                </small>
                                                                <small class="text-muted"><i
                                                                        class="glyphicon glyphicon-road"
                                                                        style="margin-left: 15px; margin-right:10px;"></i> <%=edge.getDistance()%>
                                                                    km
                                                                </small>

                                                                <small class="text-muted"><i
                                                                        class="fa fa-bus"
                                                                        style="margin-left: 15px; margin-right:10px;"></i> <%=ligne.getNumero()%>

                                                                </small>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </li>


                                                <%
                                                    }
                                                %>
                                                <%--<li>--%>
                                                <%--<div class="timeline-badge danger"></div>--%>
                                                <%--<div class="timeline-panel">--%>
                                                <%--<div class="timeline-heading">--%>
                                                <%--<h4 class="timeline-title">Mussum ipsum cacilds</h4>--%>
                                                <%--</div>--%>

                                                <%--</div>--%>
                                                <%--</li>--%>
                                                <%--<li>--%>
                                                <%--<div class="timeline-badge info"></div>--%>
                                                <%--<div class="timeline-panel">--%>
                                                <%--<div class="timeline-heading">--%>
                                                <%--<h4 class="timeline-title">Mussum ipsum cacilds</h4>--%>
                                                <%--</div>--%>
                                                <%--</div>--%>
                                                <%--</li>--%>


                                            </ul>
                                        </div>
                                    </td>

                                    <td  id="map" style="padding: 10px; border-left: #efefef solid 1.5px; ">
                                        <%--<div id="map" width="90%" height="90%"></div>--%>
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </section>

    </div>
</div>


<br/><br/>


<%

    List<List<Position>> listofpos = (List<List<Position>>) request.getSession().getAttribute("listofpos");
    List<List<Bus>> listofbus = (List<List<Bus>>) request.getSession().getAttribute("listofbus");


%>

<script>

    function initMap(){

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


    }


    <%--var markers = [];--%>
    <%--var arr = [];--%>
    <%--var cnt = 0;--%>
    <%--var buspos = new Array();--%>
    <%--function initMap() {--%>


        <%--var mark = {--%>
            <%--path: google.maps.SymbolPath.CIRCLE,--%>
            <%--fillOpacity: 0.7,--%>
            <%--fillColor: '',--%>
            <%--strokeOpacity: 1.0,--%>
            <%--strokeColor: 'white',--%>
            <%--strokeWeight: 3.0,--%>
            <%--scale: 10 //pixels--%>
        <%--};--%>


        <%--latitude = 31.6345449;--%>
        <%--longitude = -8.0079382;--%>
        <%--var cord = {lat: latitude, lng: longitude};--%>
        <%--var map = new google.maps.Map(document.getElementById('map'), {--%>
            <%--zoom: 13,--%>
            <%--center: cord--%>
        <%--});--%>


        <%--<%--%>
        <%--int ii=0;--%>
        <%--for (Ligne l : lignelist) {--%>
        <%--ii++;--%>
        <%--%>--%>

        <%--var lat_lng = new Array();--%>


        <%--<%--%>
        <%--for (Arret a : l.getArrets()) {--%>
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
        <%--var path<%=ii%> = new google.maps.MVCArray();--%>

        <%--//Initialize the Direction Service--%>
        <%--var service = new google.maps.DirectionsService();--%>

        <%--//Set the Path Stroke Color--%>
        <%--var poly<%=ii%> = new google.maps.Polyline({map: map, strokeColor: '<%=l.getCouleur()%>'});--%>

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
                        <%--path<%=ii%>.push(result.routes[0].overview_path[i]);--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>

        <%--}--%>

        <%--poly<%=ii%>.setPath(path<%=ii%>);--%>

        <%--<%--%>
        <%--}--%>
        <%--%>--%>



        <%--<%--%>

<%--BusDaoImpl bdao = new BusDaoImpl();--%>


<%--for(int i = 0; i <listofpos.size() ; i++) {--%>
    <%--List<Position> lp = listofpos.get(i);--%>
    <%--List<Bus> lb = listofbus.get(i);--%>
    <%--Ligne ligne = bdao.findByIp(lb.get(0).getName()).getLigne();--%>
  <%--for(int j = 0; j <lp.size() ; j++) {--%>
        <%--Position p = lp.get(j);--%>
        <%--Bus b = lb.get(j);--%>

        <%--%>--%>


        <%--var mark = {--%>
            <%--path: google.maps.SymbolPath.CIRCLE,--%>
            <%--fillOpacity: 0.7,--%>
            <%--fillColor: '<%=ligne.getCouleur()%>',--%>
            <%--strokeOpacity: 1.0,--%>
            <%--strokeColor: 'white',--%>
            <%--strokeWeight: 3.0,--%>
            <%--scale: 10 //pixels--%>
        <%--};--%>

        <%--var myLatlng = new google.maps.LatLng(<%=p.getLat()%>, <%=p.getLon()%>);--%>

        <%--var marker = new google.maps.Marker({--%>
            <%--position: myLatlng,--%>
            <%--map: map,--%>
            <%--title: "<%=b.getName()%>",--%>
            <%--icon: mark,--%>
            <%--zIndex: 1200,--%>
        <%--});--%>
        <%--marker.setZIndex(google.maps.Marker.MAX_ZINDEX + 1);--%>
        <%--marker.info = new google.maps.InfoWindow({--%>
            <%--content: '<%= b.getName()%>'--%>
        <%--});--%>

        <%--marker.addListener('click', function() {--%>
            <%--this.info.open(map, this);--%>
        <%--});--%>

        <%--<%--%>
          <%--}--%>
        <%--}--%>
        <%--%>--%>

    <%--}--%>


</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkB3oJ1rKgHxV1vFa3vmOO1cTnNu_imgc &callback=initMap">
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<%@ include file="WEB-INF/footer.jsp" %>


</body>
</html>
