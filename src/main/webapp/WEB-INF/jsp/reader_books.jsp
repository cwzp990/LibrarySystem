<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>全部图书信息</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .book-container {
        padding: 20px;
        margin: 20px;
      }
      .search-container {
        max-width: 500px;
        margin: 20px auto;
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
      <div class="search-container">
        <el-input
          v-model="searchQuery"
          placeholder="请输入图书名称"
          @keyup.enter.native="handleSearch"
        >
          <el-button slot="append" icon="el-icon-search" @click="handleSearch">
            搜索
          </el-button>
        </el-input>
      </div>

      <el-card class="book-container">
        <div slot="header">
          <span>全部图书</span>
        </div>

        <el-table :data="books" v-loading="loading" style="width: 100%">
          <el-table-column prop="name" label="书名"></el-table-column>
          <el-table-column prop="author" label="作者"></el-table-column>
          <el-table-column prop="publish" label="出版社"></el-table-column>
          <el-table-column prop="isbn" label="ISBN"></el-table-column>
          <el-table-column prop="price" label="价格"></el-table-column>
          <el-table-column prop="number" label="剩余数量"></el-table-column>
          <el-table-column label="操作" width="200">
            <template slot-scope="scope">
              <el-button
                v-if="isBookBorrowed(scope.row.bookId)"
                type="danger"
                size="mini"
                @click="handleReturn(scope.row)"
              >
                归还
              </el-button>
              <el-button
                v-else-if="scope.row.number > 0"
                type="primary"
                size="mini"
                @click="handleBorrow(scope.row)"
              >
                借阅
              </el-button>
              <el-button v-else type="info" size="mini" disabled>
                已空
              </el-button>
              <el-button
                type="text"
                size="mini"
                @click="handleDetail(scope.row)"
              >
                详情
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            books: [],
            loading: false,
            searchQuery: "",
            myLendList: "${myLendList}",
          };
        },
        mounted() {
          this.loadHeader();
          this.loadBooks();
        },
        methods: {
          loadHeader() {
            fetch("reader_header.html")
              .then((response) => response.text())
              .then((html) => {
                document.getElementById("header").innerHTML = html;
              });
          },
          loadBooks() {
            this.loading = true;
            fetch("reader_books_data.json")
              .then((response) => response.json())
              .then((data) => {
                this.books = data;
                this.loading = false;
              })
              .catch(() => {
                this.loading = false;
                this.$message.error("加载图书数据失败");
              });
          },
          handleSearch() {
            if (!this.searchQuery.trim()) {
              this.$message.warning("请输入搜索关键词");
              return;
            }
            this.loading = true;
            fetch(`reader_querybook_do.html?searchWord=${this.searchQuery}`)
              .then((response) => response.json())
              .then((data) => {
                this.books = data;
                this.loading = false;
              });
          },
          isBookBorrowed(bookId) {
            return this.myLendList.includes(bookId);
          },
          handleBorrow(book) {
            this.$confirm("确认借阅这本书?", "提示", {
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              type: "info",
            }).then(() => {
              window.location.href = `lendbook.html?bookId=${book.bookId}`;
            });
          },
          handleReturn(book) {
            this.$confirm("确认归还这本书?", "提示", {
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              type: "info",
            }).then(() => {
              window.location.href = `returnbook.html?bookId=${book.bookId}`;
            });
          },
          handleDetail(book) {
            window.location.href = `reader_book_detail.html?bookId=${book.bookId}`;
          },
        },
      });
    </script>
  </body>
</html>
