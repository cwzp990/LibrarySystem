<%@ page contentType="text/html;charset=UTF-8" language="java"%> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>图书馆首页</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <script src="js/js.cookie.js"></script>
    <style>
      .login-container {
        width: 28%;
        margin: 5% auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 4px;
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
      }
      .login-title {
        text-align: center;
        color: white;
        font-family: "华文行楷";
        font-size: 500%;
        margin-bottom: 30px;
      }
      * {
        padding: 0;
        margin: 0;
      }
    </style>
  </head>
  <body
    background="img/timg.jpg"
    style="
      background-repeat: no-repeat;
      background-size: 100% 100%;
      background-attachment: fixed;
    "
  >
    <div id="app">
      <h2 class="login-title">图 书 馆</h2>

      <div class="login-container">
        <el-form :model="loginForm" :rules="rules" ref="loginForm">
          <h3 style="margin-bottom: 20px">请登录</h3>

          <el-form-item prop="id">
            <el-input
              v-model="loginForm.id"
              placeholder="请输入账号"
              @keyup.native="validateId"
            >
              <template slot="prepend">账号</template>
            </el-input>
          </el-form-item>

          <el-form-item prop="passwd">
            <el-input
              v-model="loginForm.passwd"
              type="password"
              placeholder="请输入密码"
            >
              <template slot="prepend">密码</template>
            </el-input>
          </el-form-item>

          <el-form-item>
            <el-checkbox v-model="loginForm.remember">记住密码</el-checkbox>
          </el-form-item>

          <el-form-item>
            <el-button
              type="primary"
              @click="handleLogin('loginForm')"
              style="width: 100%"
            >
              登录
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            loginForm: {
              id: "",
              passwd: "",
              remember: false,
            },
            rules: {
              id: [
                { required: true, message: "请输入账号", trigger: "blur" },
                { validator: this.validateNumber, trigger: "blur" },
              ],
              passwd: [
                { required: true, message: "请输入密码", trigger: "blur" },
              ],
            },
          };
        },
        created() {
          this.setLoginStatus();
        },
        methods: {
          validateNumber(rule, value, callback) {
            if (value && isNaN(value)) {
              callback(new Error("账号只能为数字"));
            } else {
              callback();
            }
          },
          validateId() {
            if (isNaN(this.loginForm.id)) {
              this.$message.warning("账号只能为数字");
            }
          },
          rememberLogin(username, password, checked) {
            Cookies.set(
              "loginStatus",
              {
                username: username,
                password: password,
                remember: checked,
              },
              { expires: 30, path: "" }
            );
          },
          setLoginStatus() {
            const loginStatusText = Cookies.get("loginStatus");
            if (loginStatusText) {
              try {
                const loginStatus = JSON.parse(loginStatusText);
                this.loginForm.id = loginStatus.username;
                this.loginForm.passwd = loginStatus.password;
                this.loginForm.remember = true;
              } catch (e) {}
            }
          },
          handleLogin(formName) {
            this.$refs[formName].validate((valid) => {
              if (valid) {
                const { id, passwd, remember } = this.loginForm;
                fetch("api/loginCheck", {
                  method: "POST",
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: JSON.stringify({ id, passwd }),
                })
                  .then((response) => response.json())
                  .then((data) => {
                    if (data.stateCode.trim() === "0") {
                      this.$message.error("账号或密码错误！");
                    } else if (data.stateCode.trim() === "1") {
                      this.$message.success("登录成功，跳转中...");
                      window.location.href = "admin_main.html";
                    } else if (data.stateCode.trim() === "2") {
                      if (remember) {
                        this.rememberLogin(id, passwd, remember);
                      } else {
                        Cookies.remove("loginStatus");
                      }
                      this.$message.success("登录成功，跳转中...");
                      window.location.href = "reader_main.html";
                    }
                  });
              } else {
                return false;
              }
            });
          },
        },
      });
    </script>
  </body>
</html>
