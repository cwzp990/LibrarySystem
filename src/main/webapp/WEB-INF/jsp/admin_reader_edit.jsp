<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>编辑读者信息</title>
    <link rel="stylesheet" href="css/element.min.css" />
    <script src="js/vue.min.js"></script>
    <script src="js/element.min.js"></script>
    <style>
      .form-container {
        width: 80%;
        margin: 20px auto;
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
      <el-card class="form-container">
        <div slot="header">
          <span>编辑读者信息 - {{ readerInfo.readerId }}</span>
        </div>

        <el-form
          :model="readerForm"
          :rules="rules"
          ref="readerForm"
          label-width="100px"
          v-loading="loading"
        >
          <el-form-item label="姓名" prop="name">
            <el-input v-model="readerForm.name" placeholder="请输入姓名">
            </el-input>
          </el-form-item>

          <el-form-item label="性别" prop="sex">
            <el-radio-group v-model="readerForm.sex">
              <el-radio label="男">男</el-radio>
              <el-radio label="女">女</el-radio>
            </el-radio-group>
          </el-form-item>

          <el-form-item label="生日" prop="birth">
            <el-date-picker
              v-model="readerForm.birth"
              type="date"
              placeholder="选择生日"
            >
            </el-date-picker>
          </el-form-item>

          <el-form-item label="地址" prop="address">
            <el-input v-model="readerForm.address" placeholder="请输入地址">
            </el-input>
          </el-form-item>

          <el-form-item label="电话" prop="phone">
            <el-input v-model="readerForm.phone" placeholder="请输入电话">
            </el-input>
          </el-form-item>

          <el-form-item>
            <el-button
              type="primary"
              @click="submitForm('readerForm')"
              :loading="loading"
            >
              保存
            </el-button>
            <el-button @click="goBack">返回</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <script>
      new Vue({
        el: "#app",
        data() {
          return {
            loading: false,
            readerInfo: "${readerInfo}",
            readerForm: {
              name: "",
              sex: "男",
              birth: "",
              address: "",
              phone: "",
            },
            rules: {
              name: [
                { required: true, message: "请输入姓名", trigger: "blur" },
              ],
              sex: [
                { required: true, message: "请选择性别", trigger: "change" },
              ],
              birth: [
                { required: true, message: "请选择生日", trigger: "change" },
              ],
              address: [
                { required: true, message: "请输入地址", trigger: "blur" },
              ],
              phone: [
                { required: true, message: "请输入电话", trigger: "blur" },
                {
                  pattern: /^1[3-9]\d{9}$/,
                  message: "请输入正确的手机号码",
                  trigger: "blur",
                },
              ],
            },
          };
        },
        mounted() {
          this.loadHeader();
          this.initForm();
        },
        methods: {
          loadHeader() {
            fetch("admin_header.html")
              .then((response) => response.text())
              .then((html) => {
                document.getElementById("header").innerHTML = html;
              });
          },
          initForm() {
            Object.keys(this.readerForm).forEach((key) => {
              if (key === "birth") {
                this.readerForm[key] = new Date(this.readerInfo[key]);
              } else {
                this.readerForm[key] = this.readerInfo[key];
              }
            });
          },
          submitForm(formName) {
            this.$refs[formName].validate((valid) => {
              if (valid) {
                this.loading = true;
                const formData = new FormData();
                Object.keys(this.readerForm).forEach((key) => {
                  let value = this.readerForm[key];
                  if (key === "birth") {
                    value = this.formatDate(value);
                  }
                  formData.append(key, value);
                });

                fetch(
                  `reader_edit_do.html?readerId=${this.readerInfo.readerId}`,
                  {
                    method: "POST",
                    body: formData,
                  }
                )
                  .then((response) => response.json())
                  .then((data) => {
                    this.loading = false;
                    if (data.success) {
                      this.$message.success("修改成功");
                      setTimeout(() => {
                        this.goBack();
                      }, 1500);
                    } else {
                      this.$message.error(data.message || "修改失败");
                    }
                  })
                  .catch(() => {
                    this.loading = false;
                    this.$message.error("系统错误，请稍后重试");
                  });
              }
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
          goBack() {
            window.history.back();
          },
        },
      });
    </script>
  </body>
</html>
