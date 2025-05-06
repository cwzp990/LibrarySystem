<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="header">
  <el-menu
    :default-active="activeIndex"
    mode="horizontal"
    background-color="#25c6fc"
    text-color="#fff"
    active-text-color="#ffd04b"
    style="position: fixed; z-index: 999; width: 100%"
  >
    <el-menu-item index="0">
      <span style="font-family: 华文行楷; font-size: 250%">图书管理系统</span>
    </el-menu-item>

    <el-submenu index="1">
      <template slot="title">图书管理</template>
      <el-menu-item index="1-1" @click="$router.push('/admin_books.html')">
        全部图书
      </el-menu-item>
      <el-menu-item index="1-2" @click="$router.push('/book_add.html')">
        增加图书
      </el-menu-item>
    </el-submenu>

    <el-submenu index="2">
      <template slot="title">读者管理</template>
      <el-menu-item index="2-1" @click="$router.push('/allreaders.html')">
        全部读者
      </el-menu-item>
      <el-menu-item index="2-2" @click="$router.push('/reader_add.html')">
        增加读者
      </el-menu-item>
    </el-submenu>

    <el-submenu index="3">
      <template slot="title">借还管理</template>
      <el-menu-item index="3-1" @click="$router.push('/lendlist.html')">
        借还日志
      </el-menu-item>
    </el-submenu>

    <el-menu-item index="4" @click="$router.push('/admin_repasswd.html')">
      密码修改
    </el-menu-item>

    <div style="float: right; padding-right: 20px">
      <el-dropdown @command="handleCommand">
        <span class="el-dropdown-link" style="color: white">
          ${admin.username}, 已登录<i
            class="el-icon-arrow-down el-icon--right"
          ></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="logout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </el-menu>
</div>

<script>
  new Vue({
    el: "#header",
    data() {
      return {
        activeIndex: "0",
      };
    },
    methods: {
      handleCommand(command) {
        if (command === "logout") {
          window.location.href = "logout.html";
        }
      },
    },
  });
</script>
