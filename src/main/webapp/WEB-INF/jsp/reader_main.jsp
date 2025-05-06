<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>${readercard.name}的主页</title>
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
      .feature-card {
        height: 100%;
      }
      .feature-icon {
        font-size: 24px;
        margin-bottom: 10px;
      }
    </style>
  </head>
  <body
    background="img/wolf.jpg"
    style="
      background-repeat: no-repeat;
      background-size: 100% 100%;
      background-attachment: fixed;
    "
  >
    <div id="header"></div>

    <div id="app">
      <div class="welcome-container">
        <h1 class="welcome-title">欢迎使用图书馆系统</h1>

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
          <div>请注意按时归还图书，避免超期。</div>
        </el-card>
      </div>

      <el-row :gutter="20" style="margin-top: 40px; padding: 0 40px">
        <el-col :span="8">
          <el-card shadow="hover" class="feature-card">
            <div slot="header">
              <i class="el-icon-reading feature-icon"></i>
              <span>图书查询</span>
            </div>
            <div>
              <p>查看馆内所有图书信息</p>
              <el-button
                type="text"
                @click="$router.push('/reader_books.html')"
              >
                立即查看
              </el-button>
            </div>
          </el-card>
        </el-col>

        <el-col :span="8">
          <el-card shadow="hover" class="feature-card">
            <div slot="header">
              <i class="el-icon-document feature-icon"></i>
              <span>借阅记录</span>
            </div>
            <div>
              <p>查看个人借阅历史记录</p>
              <el-button type="text" @click="$router.push('/mylend.html')">
                立即查看
              </el-button>
            </div>
          </el-card>
        </el-col>

        <el-col :span="8">
          <el-card shadow="hover" class="feature-card">
            <div slot="header">
              <i class="el-icon-user feature-icon"></i>
              <span>个人信息</span>
            </div>
            <div>
              <p>查看和修改个人信息</p>
              <el-button type="text" @click="$router.push('/reader_info.html')">
                立即查看
              </el-button>
            </div>
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
            fetch("reader_header.html")
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
