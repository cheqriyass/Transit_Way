<%@ page import="model.User" %>
<%@ page import="dao.UserDaoImpl" %>
<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/transit/home">Transit Way</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="/transit/home">Home</a></li>
            <li><a href="/transit/carte">Carte</a></li>
            <li><a href="/transit/contact.jsp">Contact Us</a></li>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <%

                UserDaoImpl userdao = new UserDaoImpl();

                Cookie[] cookies = request.getCookies();
                String username = null;
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("username")) {
                            username = cookie.getValue();
                        }
                    }
                }


                if (username ==null || username.equals("")) {
            %>
            <li><a href="/transit/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
            <%
            } else {



            %>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="glyphicon glyphicon-menu-hamburger"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="/transit/addLigne">Ajouter une ligne</a></li>
                    <li><a href="/transit/addBus">Ajouter un bus</a></li>
                    <li><a href="/transit/suppligne">Supprimer une ligne</a></li>
                    <li><a href="/transit/supparret">Supprimer un Arret</a></li>
                    <li><a href="/transit/message">Messages</a></li>
                    <li><a href="/transit/signout">Sign Out</a></li>
                </ul>
            </li>
            <%}%>
        </ul>
    </div>
</nav>

