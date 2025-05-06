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
      .table-container {
        margin-top: 20px;
      }
    </style>
  </head>
  <body
    background="img/book1.jpg"
    style="
      background-repeat: no-repeat;
      background-size: 100% 100%;
      background-attachment: fixed;
    "
  >
    <div id="header"></div>

    <div id="app">
      <!-- 搜索框 -->
      <div class="search-container">
        <el-input
          placeholder="请输入图书名称"
          v-model="searchQuery"
          class="input-with-select"
        >
          <el-button
            slot="append"
            icon="el-icon-search"
            @click="handleSearch"
          ></el-button>
        </el-input>
      </div>

      <!-- 消息提示 -->
      <el-alert
        v-if="message.show"
        :title="message.content"
        :type="message.type"
        show-icon
        @close="message.show = false"
      >
      </el-alert>

      <!-- 图书列表 -->
      <div class="book-container">
        <el-card>
          <div slot="header">
            <span>全部图书</span>
            <el-button
              style="float: right; padding: 3px 0"
              type="text"
              @click="$router.push('/book_add.html')"
            >
              添加图书
            </el-button>
          </div>

          <el-table :data="books" style="width: 100%" v-loading="loading">
            <el-table-column prop="name" label="书名"></el-table-column>
            <el-table-column prop="author" label="作者"></el-table-column>
            <el-table-column prop="publish" label="出版社"></el-table-column>
            <el-table-column prop="isbn" label="ISBN"></el-table-column>
            <el-table-column prop="price" label="价格"></el-table-column>
            <el-table-column prop="number" label="剩余数量"></el-table-column>
            <el-table-column label="操作" width="200">
              <template slot-scope="scope">
                <el-button size="mini" @click="handleDetail(scope.row)">
                  详情
                </el-button>
                <el-button
                  size="mini"
                  type="primary"
                  @click="handleEdit(scope.row)"
                >
                  编辑
                </el-button>
                <el-button
                  size="mini"
                  type="danger"
                  @click="handleDelete(scope.row)"
                >
                  删除
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </div>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            books: [],
            loading: false,
            searchQuery: "",
            message: {
              show: false,
              content: "",
              type: "success",
            },
          };
        },
        mounted() {
          this.loadHeader();
          this.loadBooks();
          this.checkMessage();
        },
        methods: {
          loadHeader() {
            fetch("admin_header.html")
              .then((response) => response.text())
              .then((html) => {
                document.getElementById("header").innerHTML = html;
              });
          },
          loadBooks() {
            this.loading = true;
            fetch("books_data.json")
              .then((response) => response.json())
              .then((data) => {
                this.books = data;
                this.loading = false;
              })
              .catch(() => {
                this.loading = false;
                this.showMessage("加载图书数据失败", "error");
              });
          },
          handleSearch() {
            if (!this.searchQuery.trim()) {
              this.$message.warning("请输入搜索关键词");
              return;
            }
            this.loading = true;
            fetch(`querybook.html?searchWord=${this.searchQuery}`)
              .then((response) => response.json())
              .then((data) => {
                this.books = data;
                this.loading = false;
              });
          },
          handleDetail(row) {
            window.location.href = `admin_book_detail.html?bookId=${row.bookId}`;
          },
          handleEdit(row) {
            window.location.href = `updatebook.html?bookId=${row.bookId}`;
          },
          handleDelete(row) {
            this.$confirm("确认删除该图书?", "提示", {
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              type: "warning",
            }).then(() => {
              fetch(`deletebook.html?bookId=${row.bookId}`)
                .then((response) => response.json())
                .then((data) => {
                  if (data.success) {
                    this.showMessage("删除成功", "success");
                    this.loadBooks();
                  } else {
                    this.showMessage(data.message || "删除失败", "error");
                  }
                });
            });
          },
          showMessage(content, type = "success") {
            this.message = {
              show: true,
              content,
              type,
            };
          },
          checkMessage() {
            const succ = "${succ}";
            const error = "${error}";
            if (succ) this.showMessage(succ);
            if (error) this.showMessage(error, "error");
          },
        },
      });
    </script>
  </body>
</html>
