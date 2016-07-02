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
    <title>Registration</title>

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
            margin-left: 0px;
            height: 500px;
            width: 500px;
            border: black solid 2px;
        }

    </style>
</head>


<body>

<%@ include file="WEB-INF/navbar.jsp" %>


<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="tableaudebord">
                <div class="contact_container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <h2>Ajouter une ligne</h2> <br/><br/>
                            <div class="nb_com" style="display:none">9</div>
                        </div>
                    </div>
                </div>

                <div class='container'>
                    <div class='row'>


                        <form class="form-horizontal" role="form" action="#" method="post">
                            <div class='row'>

                                <div class="col-lg-6" style="margin-left: -80px">
                                    <!--<form class="form-horizontal" role="form">-->
                                    <div class="form-group">
                                        <label for="numero" class="col-sm-4 control-label">Numero Ligne </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="numero" id="numero">
                                        </div>
                                    </div>



                                    <div class="form-group">
                                        <div class="col-sm-9" id="map"></div>
                                    </div>


                                </div>

                                <div class="col-lg-6">


                                    <div class="form-group">
                                        <label for="couleur" class="col-sm-3 control-label">Couleur </label>
                                        <div class="col-sm-8">
                                            <select class="form-control" name="couleur" id="couleur">
                                                ${couleurs}
                                            </select>
                                        </div>
                                    </div>

                                    <div id="arrets" style="margin-left: 50px">

                                        <br/><br/><br/>

                                    </div>

                                </div>



                            </div>


                            <br/><br/>
                            <input type="hidden" name="nbr" id="nbr">

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="boutton">
                                        <div class="col-lg-5 col-md-7 hidden-md hidden-xs"></div>
                                        <div class="col-lg-1 col-md-1 col-xs-12">
                                            <input type="button" id="submit" value="Ajouter ligne"
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


<%
    List<Arret> arrets = (List<Arret>) request.getSession().getAttribute("arrets");

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
        for (Arret a : arrets) {
        %>


        var latLng = {lat: <%= a.getLatitude() %>, lng: <%= a.getLongitude() %>};
        var marker = new google.maps.Marker({
            position: latLng,
            map: map,
            title: "<%= a.getNom()%>",
            icon: "/transit/resources/icons/bus.png"
        });



        marker.addListener("click", function () {

            markers.push(marker);

            addArret(cnt,"<%=a.getNom()%>", "readonly");
            cnt++;
            document.getElementById("nbr").value = cnt;

        });

        <%
        }
        %>


//        document.getElementById("show").addEventListener("click", showInfo);
    }


    function placeMarker(latLng, map) {

        var marker = new google.maps.Marker({
            position: latLng,
            map: map,
            draggable: true,
            icon: "/transit/resources/icons/bus-1.png",
            title: "arret N " + (cnt+1)
        });

//        marker.addListener("click", function () {
//            map.setCenter(marker.getPosition());
//        });

        markers.push(marker);
        div = document.getElementById("arrets");

        addArret(cnt,"", "");


        cnt++;
        document.getElementById("nbr").value = cnt;


    }


</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkB3oJ1rKgHxV1vFa3vmOO1cTnNu_imgc &callback=initMap">
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<script>
    $(document).ready(function () {
        // click on button submit
        $("#submit").on('click', function () {
            // send ajax
            var data = [];
            nbr = $("#nbr").val();
            console.log(nbr);

            for (i = 0; i < markers.length; i++) {
                data.push({
                    nom: $("#" + i).val(),
                    latitude: markers[i].getPosition().lat(),
                    longitude: markers[i].getPosition().lng()
                });
            }

            col = $('#couleur').val();
            num = $('#numero').val();

            data = JSON.stringify(data);
            console.log(data);

            $.ajax({
                url: '/transit/addLigne', // url where to submit the request
                type: "POST", // type of action POST || GET
                dataType: 'json', // data type
                data: {data: data,
                    numero: num,
                    couleur: col
                }, // post data || get data
                success: function (result) {
                    console.log(result);
                    window.location="/transit/home";
                },
                error: function (e){
                    confirm("La ligne a ete ajouter avec succes")
                    window.location="/transit/home";
                }
            })
        });
    });


    function addArret(cnt, nom, readonly){
        olddiv = document.getElementById("arrets");

        var newdiv = "";

        newdiv += "<div class=\"form-group\">";
        newdiv += "<label for=\"" +cnt + "\" class=\"col-sm-3 control-label\">" + "Arret N " + (cnt + 1) + ": " + "</label>";
        newdiv += "<div class=\"col-sm-8\">";
        newdiv += "<input type=\"text\" class=\"form-control\" id=\"" + (cnt) + "\" name=\"" + (cnt) + "\" placeholder=\"name\" value=\""+ nom + "\"" +  readonly + ">";
        newdiv += "</div>";
        newdiv += "</div>";

        olddiv.innerHTML += newdiv;
    }

</script>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<%@ include file="WEB-INF/footer.jsp" %>

</body>
</html>

