package com.supermarket.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/testdb")
public class TestDB extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><body style='font-family: monospace; padding: 20px;'>");
        out.println("<h2>🔧 数据库连接测试</h2>");
        out.println("<hr>");

        // ===== 1. 测试驱动加载 =====
        try {
            out.println("<p>✅ 1. 正在加载 MySQL 驱动...</p>");
            Class.forName("com.mysql.cj.jdbc.Driver");
            out.println("<p style='color:green;'>✅ MySQL 驱动加载成功！</p>");
        } catch (ClassNotFoundException e) {
            out.println("<p style='color:red;'>❌ MySQL 驱动加载失败！</p>");
            out.println("<p>错误信息: " + e.getMessage() + "</p>");
            out.println("</body></html>");
            return;
        }

        // ===== 2. 测试数据库连接 =====
        String url = "jdbc:mysql://localhost:3306/supermarket?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "root123";  // ← 你的密码

        out.println("<p>📌 数据库地址: " + url + "</p>");
        out.println("<p>📌 用户名: " + user + "</p>");
        out.println("<p>📌 密码: " + password + "</p>");

        try {
            out.println("<p>✅ 2. 正在连接数据库...</p>");
            Connection conn = DriverManager.getConnection(url, user, password);
            out.println("<p style='color:green;'>✅ 数据库连接成功！</p>");

            // ===== 3. 测试查询 =====
            out.println("<p>✅ 3. 正在查询用户表...</p>");
            String sql = "SELECT * FROM users";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            out.println("<table border='1' cellpadding='5' style='border-collapse: collapse;'>");
            out.println("<tr><th>ID</th><th>用户名</th><th>密码</th><th>真实姓名</th></tr>");

            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>" + rs.getString("password") + "</td>");
                out.println("<td>" + rs.getString("real_name") + "</td>");
                out.println("</tr>");
            }

            if (!hasData) {
                out.println("<tr><td colspan='4' style='color:orange;'>⚠️ 用户表为空，请插入测试数据</td></tr>");
            }

            out.println("</table>");

            rs.close();
            stmt.close();
            conn.close();
            out.println("<p style='color:green;'>✅ 测试完成！</p>");

        } catch (SQLException e) {
            out.println("<p style='color:red;'>❌ 数据库连接失败！</p>");
            out.println("<p>错误码: " + e.getErrorCode() + "</p>");
            out.println("<p>错误信息: " + e.getMessage() + "</p>");
            out.println("<p>SQL状态: " + e.getSQLState() + "</p>");
        }

        out.println("<hr>");
        out.println("<p>💡 如果看到错误，请检查：</p>");
        out.println("<ul>");
        out.println("<li>1. MySQL 服务是否启动</li>");
        out.println("<li>2. 数据库密码是否正确（当前设置: root123）</li>");
        out.println("<li>3. 数据库 supermarket 是否存在</li>");
        out.println("<li>4. users 表是否存在</li>");
        out.println("</ul>");
        out.println("</body></html>");
    }
}
