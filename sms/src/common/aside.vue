<template>
  <div>
    <el-menu :collapse="collapse" class="aside" router>
      <el-menu-item index="dashboard" :class="{ active: $route.name === '主页' }">
        <i class="el-icon-s-home"></i>
        <span slot="title">&#12288主页</span>
      </el-menu-item>

      <el-menu-item index="timetable" :class="{ active: $route.name === '课程表' }">
        <i class="el-icon-s-grid"></i> &#12288课程表
      </el-menu-item>

      <el-menu-item index="score" :class="{ active: $route.name === '成绩查询' }">
        <i class="el-icon-s-unfold"></i>
        <span slot="title">&#12288成绩查询</span>
      </el-menu-item>

      <el-menu-item index="analysis" :class="{ active: $route.name === '成绩详情' }">
        <i class="el-icon-s-data"></i>
        <span slot="title">&#12288成绩详情</span>
      </el-menu-item>
      <el-menu-item index="intellectual" v-if="level !== 2"  :class="{ active: $route.name === '智能对话' }">
        <i class="el-icon-s-comment"></i>
        <span slot="title">&#12288智能对话</span>
      </el-menu-item>
      <el-menu-item index="automated" v-if="level !== 2"  :class="{ active: $route.name === '智能批改' }">
        <i class="el-icon-s-platform"></i>
        <span slot="title">&#12288智能批改</span>
      </el-menu-item>
      <el-menu-item index="course" v-if="level === 0" :class="{ active: $route.name === '课程录入' }">
        <i class="el-icon-s-promotion"></i>
        <span slot="title">&#12288课程录入</span>
      </el-menu-item>

      <el-submenu index="setting" v-if="level === 0">
        <template slot="title">
          <i class="el-icon-user-solid"></i>
          <span>&#12288用户管理</span>
        </template>
        <el-menu-item-group>
          <el-menu-item index="student" :class="{ active: $route.name === '学生用户' }">
            <span slot="title">学生用户</span>
          </el-menu-item>
        </el-menu-item-group>
        <el-menu-item-group>
          <el-menu-item index="teacher" :class="{ active: $route.name === '教师用户' }">
            <span slot="title">教师用户</span>
          </el-menu-item>
        </el-menu-item-group>
        <el-menu-item-group>
          <el-menu-item index="admin" :class="{ active: $route.name === '管理员用户' }">
            <span slot="title">管理员用户</span>
          </el-menu-item>
        </el-menu-item-group>
      </el-submenu>

      <el-menu-item index="account" v-if="level === 0" :class="{ active: $route.name === '账号管理' }">
        <i class="el-icon-s-tools"></i>
        <span slot="title">&#12288账号管理</span>
      </el-menu-item>
    
      <el-submenu index="questions">
        <template slot="title">
          <i class="el-icon-s-claim"></i>
          <span>&#12288答题管理</span>
        </template>
        <el-menu-item-group>
          <el-menu-item index="QuestionList" :class="{ active: $route.name === '试卷列表' }">
            <span slot="title">试卷列表</span>
          </el-menu-item>
          <el-menu-item v-if="level !== 2" index="QuestionForm" :class="{ active: $route.name === '试卷管理' }">
            <span slot="title">试卷管理</span>
          </el-menu-item>
          <el-menu-item v-if="level !== 2" index="ScoreBoard" :class="{ active: $route.name === '考试成绩' }">
            <span slot="title">学员考试成绩</span>
          </el-menu-item>
        </el-menu-item-group>
      </el-submenu>
    </el-menu>
  </div>
</template>

<script>
export default {
  name: "Aside",
  data() {
    return {
      collapse: false,
      level: -1,
    }
  },
  methods: {
    isCollapse() {
      this.collapse = !this.collapse;
      this.$emit('collapse', this.collapse);
    }
  },
  mounted() {
    this.userInfo = JSON.parse(localStorage.userInfo);
    this.level = this.userInfo.level;
  }
}
</script>
<style scoped>
.el-submenu .el-menu-item {
  margin-left: 61px;
}

/*子导航栏时的样式*/
/deep/ .el-submenu .el-menu-item {
  min-width: 80px !important;
  width: 164px;
  height: 40px;
  margin-bottom: 5px !important;
  margin-left: 40px !important;
  line-height: 40px;
  text-align: center;
  border-radius: 55px;
}

/*/deep/ .el-menu-item.is-active {*/
/*background-color: #409EFF;*/
/*color: white;*/
/*}*/
/deep/ .el-menu-item-group__title {
  padding: 0;
}

.el-menu {
  border: 0;
  /*background-image: linear-gradient(#4777e7, rgba(90,139,255,0.68));*/
}

.active {
  color: #76a3ec;
  background-color: #ecf5ff;
}
</style>