<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to My JSP Site</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
            color: #333;
        }
        header {
            background-color: #2c3e50;
            color: white;
            padding: 2rem 1rem;
            text-align: center;
        }
        .container {
            width: 80%;
            margin: 2rem auto;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .dynamic-box {
            background-color: #e8f4fd;
            border-left: 5px solid #3498db;
            padding: 1rem;
            margin: 1rem 0;
        }
        footer {
            text-align: center;
            font-size: 0.9rem;
            color: #777;
            margin-top: 3rem;
        }
        .btn {
            display: inline-block;
            background: #3498db;
            color: white;
            padding: 0.8rem 1.5rem;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>

    <header>
        <h1>Java Server Pages (JSP) Landing Page</h1>
        <p>Dynamic Content, Simplified.</p>
    </header>

    <div class="container">
        <h2>Hello, Visitor!</h2>
        <p>This page is being served by a Java application server. Below is an example of dynamic content generated at the moment you requested this page:</p>

        <div class="dynamic-box">
            <strong>Server Time:</strong> 
            <%-- This is a JSP Scriptlet to show the current date --%>
            <%= new java.util.Date() %>
        </div>

        <h3>Why use JSP?</h3>
        <ul>
            <li>Integrates seamlessly with Java servlets.</li>
            <li>Allows for reusable components (tags and beans).</li>
            <li>Perfect for enterprise-level web applications.</li>
        </ul>

        <a href="#" class="btn">Explore More</a>
    </div>

    <footer>
        &copy; <%= new java.util.Calendar().get(java.util.Calendar.YEAR) %> My JSP Demo. Built with caffeine and code.
    </footer>

</body>
</html>
