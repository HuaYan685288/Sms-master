<template>
  <div class="score-board-container">
    <div class="table-container">
      <div class="search-container">
        <div class="button-group">
          <!-- 按钮组放在这里 -->
        </div>
        <div class="search-group">
          <el-input v-model="student.studentName" placeholder="姓名" style="width: 200px; margin-right: 10px"></el-input>
          <el-input v-model="student.paperName" placeholder="试卷名称" style="width: 200px; margin-right: 10px"></el-input>
          <el-input v-model="student.score" placeholder="成绩" style="width: 200px; margin-right: 10px"></el-input>
          <el-button type="primary" @click="studentQuestions">查询</el-button>
          <el-button type="info" plain @click="resetStudent">重置</el-button>
        </div>
      </div>
      <VmBaseTable :setTableHigh="true" @on-select-change="handleSelectionChange" ref="ScoreBoard"
        :data="currentQuestions" :columns="dataColumns" overflow @page-change="pageChange" showCheck showIndex
        :tableHigh="tableHigh">
      </VmBaseTable>
    </div>
  </div>
</template>

<script>
import { listScore } from '@/api/answerRecord';
import VmBaseTable from '../../base/base-table';
export default {
  name: "ScoreBoard",
  components: {
    VmBaseTable
  },
  data() {
    return {
      student: {
        paperName: '',
        studentName: '',
        score: '',
      },
      scores: [],
      tableHigh: '66vh',
      table: null,
      currentPage: 1,
      pageSize: 10,
      allQuestions: [],
      currentQuestions: [],
      dataColumns: [
        {
          label: '学生ID',
          prop: 'studentId',
          style: 'center',
          minWidth: '100',
        },
        {
          label: '学生姓名',
          prop: 'studentName',
          style: 'center',
          minWidth: '100',
        },
        {
          label: '试卷名称',
          prop: 'paperName',
          style: 'center',
          minWidth: '100',
        },
        {
          label: '成绩',
          prop: 'score',
          style: 'center',
          minWidth: '100',
        },
      ],
      loading: true,
      error: null,
      selectedRows: [], // 用于存储选中的行
    };
  },
  created() {
    this.fetchScores();
  },
  methods: {
    // 模糊查询
    studentQuestions() {
      const searchParams = {};
      if (this.student.studentName) {
        searchParams.studentName = this.student.studentName;
      }
      if (this.student.paperName) {
        searchParams.paperName = this.student.paperName;
      }
      if (this.student.score) {
        searchParams.score = this.student.score;
      }
      console.log('Search Params:', searchParams);
      this.fetchScores(searchParams);
    },
    // 重置
    resetStudent() {
      this.student.paperName = '';
      this.student.studentName = '';
      this.student.score = '';
      this.fetchScores();
    },
    // 获取成绩列表
    fetchScores(searchParams = {}) {
      this.loading = true;
      listScore(searchParams)
        .then(response => {
          this.scores = response.data;
          this.table.total = this.scores.length;
          this.updateCurrentQuestions();
          this.loading = false;
        })
        .catch(error => {
          console.error('获取成绩列表失败:', error);
          this.error = '获取成绩列表失败';
          this.loading = false;
        });
    },
    // 分页改变时更新当前页数据
    pageChange(page) {
      this.currentPage = page.offset / 10 + 1;
      this.updateCurrentQuestions();
    },
    // 更新当前页显示的数据
    updateCurrentQuestions() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.currentQuestions = this.scores.slice(start, end);
      console.log('当前页题目列表:', this.currentQuestions);
    },
    // 选中行改变时触发
    handleSelectionChange(selectedRows) {
      this.selectedRows = selectedRows;
      console.log('选中的行:', this.selectedRows);
    },
  },
  mounted() {
    this.table = this.$refs['ScoreBoard'];
  }
};
</script>

<style scoped>
.score-board-container {
  padding: 20px;
  border-radius: 4px;
}

.table-container {
  background-color: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.search-container {
  display: flex;
  justify-content: flex-end; /* 内容对齐到右侧 */
  margin-bottom: 15px;
}

.search-group {
  display: flex;
  align-items: center;
}

.el-table {
  border: 1px solid #ebeef5;
  border-radius: 4px;
}

.el-table th {
  background-color: #f5f7fa;
  color: #333;
  font-weight: bold;
  border-bottom: 2px solid #ebeef5;
}

.el-table td {
  padding: 12px 0;
  border-bottom: 1px solid #ebeef5;
}

.el-table--enable-row-hover .el-table__body tr:hover>td {
  background-color: #f5f7fa;
}
</style>