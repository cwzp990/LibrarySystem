<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>修改密码</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .password-container {
        width: 500px;
        margin: 50px auto;
        padding: 20px;
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
      <el-card class="password-container">
        <div slot="header">
          <span>密码修改</span>
        </div>

        <el-form
          :model="passwordForm"
          :rules="rules"
          ref="passwordForm"
          label-width="100px"
          v-loading="loading"
        >
          <el-form-item label="旧密码" prop="oldPasswd">
            <el-input
              v-model="passwordForm.oldPasswd"
              type="password"
              show-password
              placeholder="请输入旧密码"
            >
            </el-input>
          </el-form-item>

          <el-form-item label="新密码" prop="newPasswd">
            <el-input
              v-model="passwordForm.newPasswd"
              type="password"
              show-password
              placeholder="请输入新密码"
            >
            </el-input>
          </el-form-item>

          <el-form-item label="确认密码" prop="reNewPasswd">
            <el-input
              v-model="passwordForm.reNewPasswd"
              type="password"
              show-password
              placeholder="请再次输入新密码"
            >
            </el-input>
          </el-form-item>

          <el-form-item>
            <el-button
              type="primary"
              @click="submitForm('passwordForm')"
              :loading="loading"
            >
              提交修改
            </el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          const validatePass2 = (rule, value, callback) => {
            if (value !== this.passwordForm.newPasswd) {
              callback(new Error("两次输入的密码不一致!"));
            } else {
              callback();
            }
          };
          return {
            loading: false,
            passwordForm: {
              oldPasswd: "",
              newPasswd: "",
              reNewPasswd: "",
            },
            rules: {
              oldPasswd: [
                { required: true, message: "请输入旧密码", trigger: "blur" },
              ],
              newPasswd: [
                { required: true, message: "请输入新密码", trigger: "blur" },
                { min: 6, message: "密码长度不能小于6个字符", trigger: "blur" },
              ],
              reNewPasswd: [
                {
                  required: true,
                  message: "请再次输入新密码",
                  trigger: "blur",
                },
                { validator: validatePass2, trigger: "blur" },
              ],
            },
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
          submitForm(formName) {
            this.$refs[formName].validate((valid) => {
              if (valid) {
                this.loading = true;
                const formData = new FormData();
                Object.keys(this.passwordForm).forEach((key) => {
                  formData.append(key, this.passwordForm[key]);
                });

                fetch("admin_repasswd_do", {
                  method: "POST",
                  body: formData,
                })
                  .then((response) => response.json())
                  .then((data) => {
                    this.loading = false;
                    if (data.success) {
                      this.$message.success("密码修改成功");
                      this.$refs[formName].resetFields();
                    } else {
                      this.$message.error(data.message || "密码修改失败");
                    }
                  })
                  .catch(() => {
                    this.loading = false;
                    this.$message.error("系统错误，请稍后重试");
                  });
              }
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
