<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>我的借还</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .lend-container {
        width: 90%;
        margin: 20px auto;
        padding: 20px;
      }
      .status-tag {
        margin-right: 5px;
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
      <el-card class="lend-container">
        <div slot="header">
          <span>我的借还记录</span>
        </div>

        <el-table :data="lendLogs" v-loading="loading" style="width: 100%">
          <el-table-column prop="bookId" label="图书号"></el-table-column>
          <el-table-column prop="lendDate" label="借出日期"></el-table-column>
          <el-table-column prop="backDate" label="归还日期"></el-table-column>
          <el-table-column label="状态">
            <template slot-scope="scope">
              <el-tag
                :type="getStatusType(scope.row)"
                size="small"
                class="status-tag"
              >
                {{ getStatusText(scope.row) }}
              </el-tag>
              <el-tag
                v-if="isOverdue(scope.row)"
                type="danger"
                size="small"
                class="status-tag"
              >
                超期
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="120">
            <template slot-scope="scope">
              <el-button
                v-if="!scope.row.backDate"
                size="mini"
                type="primary"
                @click="handleReturn(scope.row)"
              >
                归还
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
            lendLogs: "${list}",
            loading: false,
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
          getStatusType(row) {
            if (!row.backDate) {
              return this.isOverdue(row) ? "danger" : "warning";
            }
            return "success";
          },
          getStatusText(row) {
            if (!row.backDate) {
              return "未还";
            }
            return "已还";
          },
          isOverdue(row) {
            if (!row.backDate) {
              const lendDate = new Date(row.lendDate);
              const now = new Date();
              // 假设借期为30天
              return (now - lendDate) / (1000 * 60 * 60 * 24) > 30;
            }
            return false;
          },
          handleReturn(row) {
            this.$confirm("确认归还这本书?", "提示", {
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              type: "warning",
            }).then(() => {
              window.location.href = `returnbook.html?bookId=${row.bookId}`;
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
