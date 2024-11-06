<%-- 
    Document   : main
    Created on : 28-oct-2024, 19:59:43
    Author     : fredi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" import="java.util.*" session="true"%>
<%@ include file="header.jsp" %>
<%-- Bloque JSP para preparar la lista de elementos --%>
<%
    // Simulando una lista de elementos en el servidor
    List<String> items = new ArrayList<>();
    items.add("Elemento 1");
    items.add("Elemento 2");

    int age = 10;
    request.setAttribute("age", age);

    // Guardando la lista en el objeto request para que sea accesible en JSP
    request.setAttribute("itemList", items);

// Crear una matriz bidimensional (array de arrays) en el lado del servidor
    String[][] matriz = {
        {"Nombre", "Edad", "Ciudad"},
        {"Juan", "25", "Madrid"},
        {"Ana", "30", "Barcelona"},
        {"Pedro", "35", "Valencia"}
    };

    // Pasar la matriz como un atributo de solicitud
    request.setAttribute("matrizDatos", matriz);
%>

<%
    List<String[]> celulares = (List<String[]>) session.getAttribute("celulares");
    Integer idCounter = (Integer) session.getAttribute("idCounter");

    if (celulares == null) {
        celulares = new ArrayList<>();
        session.setAttribute("celulares", celulares);
    }

    if (idCounter == null) {
        idCounter = 1; // Inicia el contador en 1 si aún no existe
        session.setAttribute("idCounter", idCounter);
    }
%>

<style>
    table {
        width: 50%;
        border-collapse: collapse;
    }
    table, th, td {
        border: 1px solid black;
    }
    th, td {
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
<body>
    <section>
        <h2>Listado de Elementos</h2>

        <c:choose>
            <c:when test="${empty itemList}">
                <p>No hay elementos disponibles en este momento.</p>
            </c:when>
            <c:otherwise>
                <ul>
                    <c:forEach var="item" items="${itemList}">
                        <li>${item}</li>
                        </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>

        <!-- Bloque condicional múltiple -->
        <c:choose>
            <c:when test="${age >= 18}">
                <p>Eres mayor de edad.</p>
            </c:when>
            <c:otherwise>
                <p>No eres mayor de edad.</p>
            </c:otherwise>
        </c:choose>

        <!-- Ciclo -->
        <c:forEach var="number" begin="1" end="5">
            <p>Número: ${number}</p>
        </c:forEach>

        <!-- Condición -->    
        <c:choose>
            <c:when test="${user.role == 'admin'}">
                <p>Bienvenido, Administrador.</p>
            </c:when>
            <c:when test="${user.role == 'user'}">
                <p>Bienvenido, Usuario.</p>
            </c:when>
            <c:otherwise>
                <p>Bienvenido, Invitado.</p>
            </c:otherwise>
        </c:choose>

        <h2>Tabla Generada desde una Matriz usando JSTL</h2>

        <!-- Generar la tabla usando JSTL -->
        <table>
            <c:forEach var="fila" items="${matrizDatos}">
                <tr>
                    <!-- Iterar sobre cada elemento de la fila -->
                    <c:forEach var="columna" items="${fila}">
                        <td>${columna}</td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>

        <!--muestra el valor de una variable o expresión. -->
        <c:out value="${user.name}" />

        <!--Divide una cadena en "tokens" con un delimitador específico y los itera. -->
        <c:forTokens items="apple,banana,grape" delims="," var="fruit">
            <p>${fruit}</p>
        </c:forTokens>

        <!--Asigna un valor a una variable en el ámbito especificado. -->
        <c:set var="userAge" value="25" scope="session" />

        <!--Elimina un atributo de un ámbito específico (por ejemplo, sesión, request, página -->
        <c:remove var="userAge" scope="session" />
        
        
        <h2>Formulario de Ingreso de Datos del Celular</h2>

        <%-- Formulario para ingresar datos del celular, sin el campo ID --%>
        <form action="main.jsp" method="post">
            Modelo de Celular: <input type="text" name="modelo" value="${param.modelo}"/><br/>
            Marca: <input type="text" name="marca" value="${param.marca}"/><br/>
            Peso (g): <input type="number" name="peso" value="${param.peso}"/><br/>
            Precio: <input type="number" step="0.01" name="precio" value="${param.precio}"/><br/>
            Fecha de Lanzamiento: <input type="date" name="fecha" value="${param.fecha}"/><br/>
            <button type="submit">Guardar Datos</button>
        </form>

        <%-- Validación de datos ingresados usando JSTL --%>
        <c:set var="modelo" value="${param.modelo}" />
        <c:set var="marca" value="${param.marca}" />
        <c:set var="peso" value="${param.peso}" />
        <c:set var="precio" value="${param.precio}" />
        <c:set var="fecha" value="${param.fecha}" />

        <c:choose>
            <c:when test="${empty modelo}">
                <p style="color: red;">El modelo es obligatorio.</p>
            </c:when>
        </c:choose>

        <c:choose>
            <c:when test="${empty marca}">
                <p style="color: red;">La marca es obligatoria.</p>
            </c:when>
        </c:choose>

        <c:choose>
            <c:when test="${empty peso}">
                <p style="color: red;">El peso es obligatorio.</p>
            </c:when>
        </c:choose>

        <c:choose>
            <c:when test="${empty precio}">
                <p style="color: red;">El precio es obligatorio.</p>
            </c:when>
        </c:choose>

        <c:choose>
            <c:when test="${empty fecha}">
                <p style="color: red;">La fecha de lanzamiento es obligatoria.</p>
            </c:when>
        </c:choose>

        <%-- Guardar datos en la lista si están completos y válidos, y autoincrementar el ID --%>
        <c:if test="${not empty modelo && not empty marca && not empty peso && not empty precio && not empty fecha}">
            <%
                String[] nuevoCelular = {idCounter.toString(), request.getParameter("modelo"), request.getParameter("marca"), request.getParameter("peso"), request.getParameter("precio"), request.getParameter("fecha")};
                celulares.add(nuevoCelular);
                idCounter++; // Incrementar el contador de ID
                session.setAttribute("idCounter", idCounter); // Actualizar el contador en sesión
            %>
            <p style="color: green;">Datos guardados correctamente.</p>
        </c:if>

        <%-- Tabla para mostrar los datos ingresados --%>
        <h2>Datos de Celulares Ingresados</h2>
        <table border="1" cellpadding="8" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Modelo</th>
                <th>Marca</th>
                <th>Peso (g)</th>
                <th>Precio</th>
                <th>Fecha de Lanzamiento</th>
            </tr>
            <c:forEach var="celular" items="${sessionScope.celulares}">
                <tr>
                    <td>${celular[0]}</td>
                    <td>${celular[1]}</td>
                    <td>${celular[2]}</td>
                    <td>${celular[3]}</td>
                    <td>${celular[4]}</td>
                    <td>${celular[5]}</td>
                </tr>
            </c:forEach>
        </table>

    </section>


</body>
<section>
</section>