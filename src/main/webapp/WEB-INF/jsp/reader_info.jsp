<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>${readercard.name}的主页</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .info-container {
        width: 80%;
        margin: 20px auto;
        padding: 20px;
      }
      .info-header {
        margin-bottom: 20px;
      }
      .operation-buttons {
        margin-top: 20px;
        text-align: center;
      }
    </style>
  </head>
  <body
    background="img/lizhi.jpg"
    style="
      background-repeat: no-repeat;
      background-size: 100% 100%;
      background-attachment: fixed;
    "
  >
    <div id="header"></div>

    <div id="app">
      <el-card class="info-container">
        <div slot="header" class="info-header">
          <span>个人信息</span>
        </div>

        <el-descriptions :column="1" border>
          <el-descriptions-item label="读者证号">
            {{ readerInfo.readerId }}
          </el-descriptions-item>
          <el-descriptions-item label="姓名">
            {{ readerInfo.name }}
          </el-descriptions-item>
          <el-descriptions-item label="性别">
            {{ readerInfo.sex }}
          </el-descriptions-item>
          <el-descriptions-item label="生日">
            {{ formatDate(readerInfo.birth) }}
          </el-descriptions-item>
          <el-descriptions-item label="地址">
            {{ readerInfo.address }}
          </el-descriptions-item>
          <el-descriptions-item label="电话">
            {{ readerInfo.phone }}
          </el-descriptions-item>
        </el-descriptions>

        <div class="operation-buttons">
          <el-button type="primary" @click="handleEdit"> 修改信息 </el-button>
        </div>
      </el-card>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            readerInfo: "${readerinfo}",
          };
        },
        mounted() {
          this.loadHeader();
          this.checkMessage();
        },
        methods: {
          loadHeader() {
            fetch("reader_header.html")
              .then((response) => response.text())
              .then((html) => {
                document.getElementById("header").innerHTML = html;
              });
          },
          formatDate(date) {
            if (!date) return "";
            const d = new Date(date);
            return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(
              2,
              "0"
            )}-${String(d.getDate()).padStart(2, "0")}`;
          },
          handleEdit() {
            window.location.href = "reader_info_edit.html";
          },
          checkMessage() {
            const succ = "${succ}";
            const error = "${error}";
            if (succ) this.$message.success(succ);
            if (error) this.$message.error(error);
          },
        },
      });
    </script>
  </body>
</html>
