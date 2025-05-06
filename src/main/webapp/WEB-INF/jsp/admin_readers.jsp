<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>全部读者</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .reader-container {
        width: 90%;
        margin: 20px auto;
        padding: 20px;
      }
    </style>
  </head>
  <body
    background="img/u1.jpg"
    style="
      background-repeat: no-repeat;
      background-size: 100% 100%;
      background-attachment: fixed;
    "
  >
    <div id="header"></div>

    <div id="app">
      <el-card class="reader-container">
        <div slot="header">
          <span>全部读者</span>
          <el-button
            style="float: right; padding: 3px 0"
            type="text"
            @click="$router.push('/reader_add.html')"
          >
            添加读者
          </el-button>
        </div>

        <el-table :data="readers" v-loading="loading" style="width: 100%">
          <el-table-column prop="readerId" label="读者号"></el-table-column>
          <el-table-column prop="name" label="姓名"></el-table-column>
          <el-table-column prop="sex" label="性别"></el-table-column>
          <el-table-column prop="birth" label="生日">
            <template slot-scope="scope">
              {{ formatDate(scope.row.birth) }}
            </template>
          </el-table-column>
          <el-table-column prop="address" label="地址"></el-table-column>
          <el-table-column prop="phone" label="电话"></el-table-column>
          <el-table-column label="操作" width="200">
            <template slot-scope="scope">
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

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            readers: "${readers}",
            loading: false,
          };
        },
        mounted() {
          this.loadHeader();
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
          formatDate(date) {
            if (!date) return "";
            const d = new Date(date);
            return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(
              2,
              "0"
            )}-${String(d.getDate()).padStart(2, "0")}`;
          },
          handleEdit(row) {
            window.location.href = `reader_edit.html?readerId=${row.readerId}`;
          },
          handleDelete(row) {
            this.$confirm("确认删除该读者?", "提示", {
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              type: "warning",
            }).then(() => {
              fetch(`reader_delete.html?readerId=${row.readerId}`)
                .then((response) => response.json())
                .then((data) => {
                  if (data.success) {
                    this.$message.success("删除成功");
                    this.readers = this.readers.filter(
                      (reader) => reader.readerId !== row.readerId
                    );
                  } else {
                    this.$message.error(data.message || "删除失败");
                  }
                })
                .catch(() => {
                  this.$message.error("系统错误，请稍后重试");
                });
            });
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
