# 智慧超市电商系统

一个基于 Java Servlet + MySQL 的超市在线商城系统。

---

## 项目简介

这是个课程作业项目，做了一个简单的超市购物网站。用户登录后可以浏览商品、搜索商品、加入购物车、选择支付方式结算。

前后端没分开，页面直接跑在 Tomcat 上，数据库用的 MySQL，前端用了 Vue 3 + Element Plus 做交互。

## 快速开始

我没有改DBUtil，Loginservlet以及TestDB里的MySQL密码，使用的时候改成你自己的就行。

自己建的数据库命名为supermarket,数据应以这个格式写：INSERT INTO users (username, password, real_name) VALUES
还有这个：INSERT INTO products (name, category, price, stock, image_url, description) VALUES 

## 更新美化

交作业用的，很粗糙,如果你还想要美化，以下是文件树结构和文件树中各文件功能：

## 项目目录结构
```
supermarket_web/
│
├── pom.xml                                   # Maven 配置文件
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── supermarket/
│       │           │
│       │           ├── dao/                  # 数据访问层
│       │           │   ├── DBUtil.java       # 数据库连接工具类
│       │           │   └── ProductDAO.java   # 商品数据访问类
│       │           │
│       │           ├── model/                # 实体类
│       │           │   └── Product.java      # 商品实体类
│       │           │
│       │           └── servlet/              # 后端接口
│       │               ├── LoginServlet.java      # 登录接口
│       │               ├── ProductListServlet.java # 商品列表接口
│       │               └── TestDB.java            # 数据库测试接口
│       │
│       ├── resources/                         # 资源文件
│       │
│       └── webapp/                           # 前端目录
│           ├── index.html                    # 登录页面
│           ├── index.jsp                     # 商品商城页面
│           │
│           ├── pos/                          # POS 收银台（旧版，可删除）
│           │   └── index.html
│           │
│           └── WEB-INF/                      # Web 配置目录
│               ├── web.xml                   # Web 应用配置
│               └── lib/                      # 第三方 JAR 包
│                   └── mysql-connector-j-8.0.33.jar  # MySQL 驱动
│
├── .gitignore                                # Git 忽略文件
└── supermarket.sql                           # 数据库初始化脚本
```
