<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>《${detail.name}》详情</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .detail-container {
        width: 80%;
        margin: 20px auto;
        padding: 20px;
      }
      .book-info {
        margin-top: 20px;
      }
      .operation-buttons {
        margin-top: 20px;
        text-align: center;
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
      <el-card class="detail-container">
        <div slot="header">
          <span>《${detail.name}》详情</span>
        </div>

        <el-descriptions class="book-info" :column="1" border>
          <el-descriptions-item label="书名">
            {{ bookInfo.name }}
          </el-descriptions-item>
          <el-descriptions-item label="作者">
            {{ bookInfo.author }}
          </el-descriptions-item>
          <el-descriptions-item label="出版社">
            {{ bookInfo.publish }}
          </el-descriptions-item>
          <el-descriptions-item label="ISBN">
            {{ bookInfo.isbn }}
          </el-descriptions-item>
          <el-descriptions-item label="简介">
            {{ bookInfo.introduction }}
          </el-descriptions-item>
          <el-descriptions-item label="语言">
            {{ bookInfo.language }}
          </el-descriptions-item>
          <el-descriptions-item label="价格">
            {{ bookInfo.price }}
          </el-descriptions-item>
          <el-descriptions-item label="出版日期">
            {{ bookInfo.pubdate }}
          </el-descriptions-item>
          <el-descriptions-item label="分类号">
            {{ bookInfo.classId }}
          </el-descriptions-item>
          <el-descriptions-item label="数量">
            {{ bookInfo.number }}
          </el-descriptions-item>
          <el-descriptions-item label="状态">
            <el-tag :type="bookInfo.number > 0 ? 'success' : 'danger'">
              {{ bookInfo.number > 0 ? "在馆" : "借出" }}
            </el-tag>
          </el-descriptions-item>
        </el-descriptions>

        <div class="operation-buttons">
          <el-button type="primary" @click="handleEdit"> 编辑 </el-button>
          <el-button @click="goBack"> 返回 </el-button>
        </div>
      </el-card>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            bookInfo: "${detail}",
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
          handleEdit() {
            window.location.href = `book_edit.html?bookId=${this.bookInfo.bookId}`;
          },
          goBack() {
            window.history.back();
          },
        },
      });
    </script>
  </body>
</html>
