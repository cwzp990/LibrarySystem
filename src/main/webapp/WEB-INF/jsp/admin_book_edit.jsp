<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>编辑图书信息</title>
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
          <span>编辑图书 - {{ bookInfo.name }}</span>
        </div>

        <el-form
          :model="bookForm"
          :rules="rules"
          ref="bookForm"
          label-width="100px"
          v-loading="loading"
        >
          <el-form-item label="书名" prop="name">
            <el-input
              v-model="bookForm.name"
              placeholder="请输入书名"
            ></el-input>
          </el-form-item>

          <el-form-item label="作者" prop="author">
            <el-input
              v-model="bookForm.author"
              placeholder="请输入作者"
            ></el-input>
          </el-form-item>

          <el-form-item label="出版社" prop="publish">
            <el-input
              v-model="bookForm.publish"
              placeholder="请输入出版社"
            ></el-input>
          </el-form-item>

          <el-form-item label="ISBN" prop="isbn">
            <el-input
              v-model="bookForm.isbn"
              placeholder="请输入ISBN"
            ></el-input>
          </el-form-item>

          <el-form-item label="简介" prop="introduction">
            <el-input
              type="textarea"
              v-model="bookForm.introduction"
              :rows="3"
              placeholder="请输入简介"
            >
            </el-input>
          </el-form-item>

          <el-form-item label="语言" prop="language">
            <el-input
              v-model="bookForm.language"
              placeholder="请输入语言"
            ></el-input>
          </el-form-item>

          <el-form-item label="价格" prop="price">
            <el-input-number
              v-model="bookForm.price"
              :precision="2"
              :step="0.1"
              :min="0"
            >
            </el-input-number>
          </el-form-item>

          <el-form-item label="出版日期" prop="pubdate">
            <el-date-picker
              v-model="bookForm.pubdate"
              type="date"
              placeholder="选择出版日期"
            >
            </el-date-picker>
          </el-form-item>

          <el-form-item label="分类号" prop="classId">
            <el-input
              v-model="bookForm.classId"
              placeholder="请输入分类号"
            ></el-input>
          </el-form-item>

          <el-form-item label="数量" prop="number">
            <el-input-number v-model="bookForm.number" :min="0" :step="1">
            </el-input-number>
          </el-form-item>

          <el-form-item>
            <el-button
              type="primary"
              @click="submitForm('bookForm')"
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
            bookInfo: "${detail}",
            bookForm: {
              name: "",
              author: "",
              publish: "",
              isbn: "",
              introduction: "",
              language: "",
              price: 0,
              pubdate: "",
              classId: "",
              number: 0,
            },
            rules: {
              name: [
                { required: true, message: "请输入书名", trigger: "blur" },
              ],
              author: [
                { required: true, message: "请输入作者", trigger: "blur" },
              ],
              publish: [
                { required: true, message: "请输入出版社", trigger: "blur" },
              ],
              isbn: [
                { required: true, message: "请输入ISBN", trigger: "blur" },
              ],
              introduction: [
                { required: true, message: "请输入简介", trigger: "blur" },
              ],
              language: [
                { required: true, message: "请输入语言", trigger: "blur" },
              ],
              price: [
                { required: true, message: "请输入价格", trigger: "blur" },
              ],
              pubdate: [
                {
                  required: true,
                  message: "请选择出版日期",
                  trigger: "change",
                },
              ],
              classId: [
                { required: true, message: "请输入分类号", trigger: "blur" },
              ],
              number: [
                { required: true, message: "请输入数量", trigger: "blur" },
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
            Object.keys(this.bookForm).forEach((key) => {
              if (key === "pubdate") {
                this.bookForm[key] = new Date(this.bookInfo[key]);
              } else {
                this.bookForm[key] = this.bookInfo[key];
              }
            });
          },
          submitForm(formName) {
            this.$refs[formName].validate((valid) => {
              if (valid) {
                this.loading = true;
                const formData = new FormData();
                Object.keys(this.bookForm).forEach((key) => {
                  let value = this.bookForm[key];
                  if (key === "pubdate") {
                    value = this.formatDate(value);
                  }
                  formData.append(key, value);
                });

                fetch(`book_edit_do.html?bookId=${this.bookInfo.bookId}`, {
                  method: "POST",
                  body: formData,
                })
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
