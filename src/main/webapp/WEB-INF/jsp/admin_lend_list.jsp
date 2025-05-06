<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>借还日志</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .log-container {
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
    background="img/u5.jpeg"
    style="
      background-repeat: no-repeat;
      background-size: 100% 100%;
      background-attachment: fixed;
    "
  >
    <div id="header"></div>

    <div id="app">
      <el-card class="log-container">
        <div slot="header">
          <span>借还日志</span>
        </div>

        <el-table :data="lendLogs" v-loading="loading" style="width: 100%">
          <el-table-column prop="ser_num" label="流水号"></el-table-column>
          <el-table-column prop="bookId" label="图书号"></el-table-column>
          <el-table-column prop="readerId" label="读者证号"></el-table-column>
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
            </template>
          </el-table-column>
          <el-table-column label="操作" width="120">
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="danger"
                :disabled="!scope.row.backDate"
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
            fetch("admin_header.html")
              .then((response) => response.text())
              .then((html) => {
                document.getElementById("header").innerHTML = html;
              });
          },
          getStatusType(row) {
            if (!row.backDate) {
              return "warning";
            }
            return "success";
          },
          getStatusText(row) {
            if (!row.backDate) {
              return "未还";
            }
            return "已还";
          },
          handleDelete(row) {
            this.$confirm("确认删除该记录?", "提示", {
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              type: "warning",
            }).then(() => {
              this.loading = true;
              fetch(`deletelend.html?serNum=${row.ser_num}`)
                .then((response) => response.json())
                .then((data) => {
                  this.loading = false;
                  if (data.success) {
                    this.$message.success("删除成功");
                    this.lendLogs = this.lendLogs.filter(
                      (log) => log.ser_num !== row.ser_num
                    );
                  } else {
                    this.$message.error(data.message || "删除失败");
                  }
                })
                .catch(() => {
                  this.loading = false;
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
