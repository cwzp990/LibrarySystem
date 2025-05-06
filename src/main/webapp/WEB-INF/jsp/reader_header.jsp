<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="reader-header">
  <el-menu
    :default-active="activeIndex"
    mode="horizontal"
    background-color="#409EFF"
    text-color="#fff"
    active-text-color="#ffd04b"
    style="position: fixed; z-index: 999; width: 100%"
  >
    <el-menu-item index="0">
      <span style="font-family: 华文行楷; font-size: 250%">图书馆</span>
    </el-menu-item>

    <el-menu-item index="1" @click="$router.push('/reader_books.html')">
      图书查询
    </el-menu-item>

    <el-menu-item index="2" @click="$router.push('/reader_info.html')">
      个人信息
    </el-menu-item>

    <el-menu-item index="3" @click="$router.push('/mylend.html')">
      我的借还
    </el-menu-item>

    <el-menu-item index="4" @click="$router.push('/reader_repasswd.html')">
      密码修改
    </el-menu-item>

    <div style="float: right; padding-right: 20px">
      <el-dropdown @command="handleCommand">
        <span class="el-dropdown-link" style="color: white">
          ${readercard.name}, 已登录<i
            class="el-icon-arrow-down el-icon--right"
          ></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="info">个人信息</el-dropdown-item>
          <el-dropdown-item command="logout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </el-menu>
</div>

<script>
  new Vue({
    el: "#reader-header",
    data() {
      return {
        activeIndex: "0",
      };
    },
    mounted() {
      this.setActiveMenu();
    },
    methods: {
      handleCommand(command) {
        if (command === "logout") {
          window.location.href = "login.html";
        } else if (command === "info") {
          window.location.href = "reader_info.html";
        }
      },
      setActiveMenu() {
        const path = window.location.pathname;
        if (path.includes("books")) {
          this.activeIndex = "1";
        } else if (path.includes("info")) {
          this.activeIndex = "2";
        } else if (path.includes("lend")) {
          this.activeIndex = "3";
        } else if (path.includes("repasswd")) {
          this.activeIndex = "4";
        }
      },
    },
  });
</script>
