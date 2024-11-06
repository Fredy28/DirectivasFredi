<%-- 
    Document   : cosas
    Created on : 28-oct-2024, 20:00:16
    Author     : fredi
--%>

<%@ page language="java" contentType="text/html;charset=UTF-8" import="java.util.*" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>

<%
    // Inicializar la lista en la sesión si es la primera vez
    ArrayList<String> elementos = (ArrayList<String>) session.getAttribute("elementos");

    if (elementos == null) {
        elementos = new ArrayList<>();
        session.setAttribute("elementos", elementos);
    }

    // Verificar si se ha enviado un nuevo elemento desde el formulario
    String nuevoElemento = request.getParameter("elemento");

    if (nuevoElemento != null && !nuevoElemento.isEmpty()) {
        // Agregar el nuevo elemento a la lista de la sesión
        elementos.add(nuevoElemento);
        session.setAttribute("elementos", elementos);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Agregar y Mostrar Elementos en una Tabla</title>
        <style>
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>

        <h2>Ingresar un nuevo elemento</h2>

        <form method="POST">
            <label for="elemento">Elemento:</label>
            <input type="text" id="elemento" name="elemento" required>
            <input type="submit" value="Agregar">
        </form>

        <h2>Lista de elementos</h2>

        <table>
            <tr>
                <th>#</th>
                <th>Elemento</th>
            </tr>

            <!-- Usamos JSTL para mostrar la tabla -->
            <c:forEach var="elemento" items="${sessionScope.elementos}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td> <!-- Índice del elemento -->
                    <td>${elemento}</td>          <!-- Contenido del elemento -->
                </tr>
            </c:forEach>

            <c:if test="${empty sessionScope.elementos}">
                <tr>
                    <td colspan="2">No se han agregado elementos todavía.</td>
                </tr>
            </c:if>
        </table>

    </body>
</html>
