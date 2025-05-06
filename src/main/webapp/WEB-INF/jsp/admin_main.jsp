<%@ page contentType="text/html;charset=UTF-8" %> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>管理主页</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .welcome-container {
        text-align: center;
        padding: 40px;
        margin-top: 60px;
      }
      .welcome-title {
        font-size: 36px;
        color: #fff;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
      }
    </style>
  </head>
  <body
    background="img/book2.jpg"
    style="
      background-repeat: no-repeat;
      background-size: 100% 100%;
      background-attachment: fixed;
    "
  >
    <div id="header"></div>

    <div id="app">
      <div class="welcome-container">
        <h1 class="welcome-title">欢迎使用图书管理系统</h1>

        <el-card v-if="showTip" style="max-width: 500px; margin: 0 auto">
          <div slot="header">
            <span>温馨提示</span>
            <el-button
              style="float: right; padding: 3px 0"
              type="text"
              @click="closeTip"
            >
              知道了
            </el-button>
          </div>
          <div>使用结束后请安全退出。</div>
        </el-card>
      </div>

      <el-row :gutter="20" style="margin-top: 40px; padding: 0 40px">
        <el-col :span="8">
          <el-card shadow="hover">
            <div slot="header">
              <span>图书管理</span>
            </div>
            <el-button type="text" @click="$router.push('/admin_books.html')">
              查看全部图书
            </el-button>
          </el-card>
        </el-col>

        <el-col :span="8">
          <el-card shadow="hover">
            <div slot="header">
              <span>读者管理</span>
            </div>
            <el-button type="text" @click="$router.push('/allreaders.html')">
              查看全部读者
            </el-button>
          </el-card>
        </el-col>

        <el-col :span="8">
          <el-card shadow="hover">
            <div slot="header">
              <span>借还管理</span>
            </div>
            <el-button type="text" @click="$router.push('/lendlist.html')">
              查看借还日志
            </el-button>
          </el-card>
        </el-col>
      </el-row>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            showTip: "${!empty login}",
          };
        },
        mounted() {
          this.loadHeader();
        },
        methods: {
          loadHeader() {
            fetch("admin_header.html")
              .then((response) => response.text())
              .then((html) => {
                document.getElementById("header").innerHTML = html;
              });
          },
          closeTip() {
            this.showTip = false;
          },
        },
      });
    </script>
  </body>
</html>
