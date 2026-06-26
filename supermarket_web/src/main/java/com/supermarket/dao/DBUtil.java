package com.supermarket.dao;

import java.sql.*;

public class DBUtil {
    private static final String PASSWORD = "root123";
    private static final String URL = "jdbc:mysql://localhost:3306/supermarket?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String USER = "root";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ MySQL 驱动加载成功");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL 驱动加载失败: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        System.out.println("🔗 正在连接数据库...");
        System.out.println("   URL: " + URL);
        System.out.println("   USER: " + USER);
        System.out.println("   PASSWORD: " + PASSWORD);
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("✅ 数据库连接成功！");
        return conn;
    }

    public static void close(ResultSet rs, Statement stmt, Connection conn) {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }

    // 添加 main 方法直接测试
    public static void main(String[] args) {
        System.out.println("========== 测试数据库连接 ==========");
        try {
            Connection conn = getConnection();
            System.out.println("✅ 连接成功！");
            conn.close();
        } catch (Exception e) {
            System.out.println("❌ 连接失败: " + e.getMessage());
            e.printStackTrace();
        }
    }
}