<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>404 Not Found</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .error-container {
        max-width: 500px;
        margin: 10% auto;
        padding: 30px;
        text-align: center;
        background: #fff;
        border-radius: 4px;
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
      }
      .error-title {
        font-size: 72px;
        color: #303133;
        margin-bottom: 20px;
      }
      .error-face {
        color: #909399;
        font-size: 50px;
      }
      .error-desc {
        font-size: 16px;
        color: #606266;
        margin: 20px 0;
      }
      .countdown {
        color: #409eff;
        font-weight: bold;
      }
    </style>
  </head>
  <body style="background-color: #f0f0f0">
    <div id="app">
      <el-card class="error-container">
        <div class="error-title">
          404
          <span class="error-face">:(</span>
        </div>

        <el-result
          icon="error"
          title="页面不存在"
          sub-title="对不起，您访问的页面不存在"
        >
          <template slot="extra">
            <p class="error-desc">
              请输入正确的地址，
              <span class="countdown">{{ countdown }}</span>
              秒后自动返回上一页
            </p>
            <el-button type="primary" @click="goBack"> 立即返回 </el-button>
          </template>
        </el-result>
      </el-card>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            countdown: 3,
            timer: null,
          };
        },
        created() {
          this.startCountdown();
        },
        beforeDestroy() {
          if (this.timer) {
            clearInterval(this.timer);
          }
        },
        methods: {
          startCountdown() {
            this.timer = setInterval(() => {
              if (this.countdown > 0) {
                this.countdown--;
              } else {
                this.goBack();
              }
            }, 1000);
          },
          goBack() {
            if (this.timer) {
              clearInterval(this.timer);
            }
            window.history.back();
          },
        },
      });
    </script>
  </body>
</html>
