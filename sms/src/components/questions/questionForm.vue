<template>
  <div class="cardStyle">
    <div class="table-container">
     <div class="search-container">
        <div class="button-group">
          <el-button type="primary" size="small" @click="openAddDialog">新增</el-button>
          <el-button type="success" size="small" @click="openAddToPaperDialog">添加到试卷</el-button>
        </div>
        <div class="search-group">
          <el-input v-model="search.questionText" placeholder="根据题目查询"
            style="width: 200px; margin-right: 10px"></el-input>
          <el-input v-model="search.score" placeholder="根据分值查询" style="width: 200px; margin-right: 10px"></el-input>
          <el-button type="primary" size="small" @click="searchQuestions">查询</el-button>
          <el-button type="info" plain size="small" @click="resetSearch">重置</el-button>
        </div>
      </div>
      <VmBaseTable
        :setTableHigh="true"
        @on-select-change="handleSelectionChange"
        ref="question_table"
        :data="currentQuestions"
        :columns="dataColumns"
        overflow
        @page-change="pageChange"
        showCheck
        showIndexaa
        :tableHigh="tableHigh"
      >
      </VmBaseTable>
    </div>

    <!-- 添加/修改题目对话框 -->
    <el-dialog
      :visible.sync="dialogVisible"
      :title="form.questionId ? '修改题目' : '添加题目'"
    >
      <el-form :model="form" label-width="100px">
        <el-form-item label="题目内容">
          <el-input
            v-model="form.questionText"
            type="textarea"
            :rows="3"
          ></el-input>
        </el-form-item>
        <el-form-item label="选项A">
          <el-input v-model="form.optionA"></el-input>
        </el-form-item>
        <el-form-item label="选项B">
          <el-input v-model="form.optionB"></el-input>
        </el-form-item>
        <el-form-item label="选项C">
          <el-input v-model="form.optionC"></el-input>
        </el-form-item>
        <el-form-item label="选项D">
          <el-input v-model="form.optionD"></el-input>
        </el-form-item>
        <el-form-item label="正确答案">
          <el-select v-model="form.correctAnswer" placeholder="请选择正确答案">
            <el-option label="A" value="A"></el-option>
            <el-option label="B" value="B"></el-option>
            <el-option label="C" value="C"></el-option>
            <el-option label="D" value="D"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="分值">
          <el-input-number v-model="form.score" :min="0"></el-input-number>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">提交</el-button>
      </div>
    </el-dialog>

    <!-- 添加到试卷对话框 -->
    <el-dialog :visible.sync="addPaperDialogVisible" title="添加到试卷">
      <el-form :model="addPaperForm">
        <el-form-item label="选择试卷">
          <el-select v-model="addPaperForm.paperId" placeholder="请选择试卷">
            <el-option
              v-for="paper in papers"
              :key="paper.paperId"
              :label="paper.paperName"
              :value="paper.paperId"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addPaperDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="addToPaper">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listQuestions,
  addQuestion,
  updateQuestion,
  deleteQuestion,

} from "@/api/question";
import { listPapers, addQuestionsToPaper } from "@/api/paper";
import VmBaseTable from "../../base/base-table";

export default {
  name: "questionForm",
  components: {
    VmBaseTable,
  },
  data() {
    return {
       search: {
        questionId: '',
        questionText: '',
        score: '',
      },
      tableHigh: "66vh",
      allQuestions: [],
      dataColumns: [
        {
          label: "题目ID",
          prop: "questionId",
          style: "center",
          minWidth: "100",
        },
        {
          label: "题目内容",
          prop: "questionText",
          style: "center",
          minWidth: "200",
          showOverflowTooltip: true,
        },
        {
          label: "选项A",
          prop: "optionA",
          style: "center",
          minWidth: "100",
        },
        {
          label: "选项B",
          prop: "optionB",
          align: "center",
          minWidth: "100",
        },
        {
          label: "选项C",
          prop: "optionC",
          style: "center",
          minWidth: "100",
        },
        {
          label: "选项D",
          prop: "optionD",
          style: "center",
          minWidth: "100",
        },
        {
          label: "正确答案",
          prop: "correctAnswer",
          style: "center",
          minWidth: "100",
        },
        {
          label: "分值",
          prop: "score",
          style: "center",
          minWidth: "80",
        },
        {
          label: "操作",
          style: "center",
          prop: "id",
          minWidth: "120",
          render: (h, params) => {
            let btns = [];
            btns.push(
              this.getOpBtn(h, "编辑", "primary", () => {
                this.openEditDialog(params.row);
              })
            );
            btns.push(
              this.getOpBtn(h, "删除", "danger", () => {
                this.deleteQuestion(params.row);
              })
            );
            return h("div", btns);
          },
        },
      ],
      table: null,
      currentPage: 1,
      pageSize: 10,
      dialogVisible: false,
      addPaperDialogVisible: false,
      form: {
        questionText: "",
        optionA: "",
        optionB: "",
        optionC: "",
        optionD: "",
        correctAnswer: "",
        score: 0,
        questionId: null,
      },
      currentQuestions: [],
      selectedQuestions: [],
      papers: [],
      addPaperForm: {
        paperId: "",
      },
    };
  },
  created() {
    this.fetchAllQuestions();
    this.fetchPapers();
  },
  methods: {
    fetchAllQuestions() {
      listQuestions()
        .then((response) => {
          this.allQuestions = response.data;
          this.table.total = this.allQuestions.length;
          this.updateCurrentQuestions();
        })
        .catch((error) => {
          console.error("获取题目列表失败:", error);
          this.$message.error("获取题目列表失败");
        });
    },
      // 重置
    resetSearch() {
      this.search.questionId = '';
      this.search.score = '';
      this.search.questionText = '';
      this.fetchAllQuestions();
    },
     // 模糊查询
    searchQuestions() {
      const searchParams = {};
      if (this.search.questionId) {
        searchParams.questionId = this.search.questionId;
      }
      if (this.search.questionText) {
        searchParams.questionText = this.search.questionText;
      }
      if (this.search.score) {
        searchParams.score = this.search.score;
      }
      console.log("Search Params:", searchParams);
      this.currentPage = 1;
      this.fetchAllQuestions(searchParams);
    },
        fetchAllQuestions(searchParams = {}) {
      const params = {
        ...searchParams,
        page: this.currentPage,
        pageSize: this.pageSize
      };
      console.log("Fetching questions with params:", params);
      listQuestions(params)
        .then(response => {
          console.log("Received data:", response);
         
          if (Array.isArray(response.data)) {
            this.allQuestions = response.data;
             this.table.total = this.allQuestions.length;
          } else {
            this.allQuestions = [];
            this.total = 0;
            console.error('Response data is not a valid array.');
          }
          this.updateCurrentQuestions();
        })
        .catch(error => {
          console.error("获取题目列表失败:", error);
          this.$message.error("获取题目列表失败");
        });
    },
    fetchPapers() {
      listPapers()
        .then((response) => {
          this.papers = response.data;
          console.log("试卷列表:", this.papers);
        })
        .catch((error) => {
          console.error("获取试卷列表失败:", error);
          this.$message.error("获取试卷列表失败");
        });
    },
    updateCurrentQuestions() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.currentQuestions = this.allQuestions.slice(start, end);
      console.log("当前页题目列表:", this.currentQuestions);
    },
    pageChange(page) {
      this.currentPage = page.offset / 10 + 1;
      this.updateCurrentQuestions();
    },
    openAddDialog() {
      this.form = {
        questionText: "",
        optionA: "",
        optionB: "",
        optionC: "",
        optionD: "",
        correctAnswer: "",
        score: 0,
        questionId: null,
      };
      this.dialogVisible = true;
    },
    openEditDialog(row) {
      this.form = {
        questionText: row.questionText,
        optionA: row.optionA,
        optionB: row.optionB,
        optionC: row.optionC,
        optionD: row.optionD,
        correctAnswer: row.correctAnswer,
        score: row.score,
        questionId: row.questionId,
      };
      this.dialogVisible = true;
    },
    submitForm() {
      if (this.form.questionId) {
        updateQuestion(this.form)
          .then(() => {
            this.dialogVisible = false;
            this.fetchAllQuestions();
            this.$message.success("题目修改成功");
          })
          .catch((error) => {
            console.error("修改题目失败:", error);
            this.$message.error("修改题目失败");
          });
      } else {
        addQuestion(this.form)
          .then(() => {
            this.dialogVisible = false;
            this.fetchAllQuestions();
            this.$message.success("题目添加成功");
          })
          .catch((error) => {
            console.error("添加题目失败:", error);
            this.$message.error("添加题目失败");
          });
      }
    },
    deleteQuestion(questionId) {
      this.$confirm("此操作将永久删除该题目, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          deleteQuestion(questionId)
            .then(() => {
              this.fetchAllQuestions();
              this.$message.success("题目删除成功");
            })
            .catch((error) => {
              console.error("删除题目失败:", error);
              this.$message.error("删除题目失败");
            });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },
    handleSelectionChange(selectedRows) {
      this.selectedQuestions = selectedRows;
    },
    openAddToPaperDialog() {
      if (this.selectedQuestions.length === 0) {
        this.$message({
          type: "info",
          message: "请先选择题目",
        });
        return;
      }
      this.addPaperDialogVisible = true;
    },
    addToPaper() {
      if (!this.addPaperForm.paperId) {
        this.$message({
          type: "info",
          message: "请选择试卷",
        });
        return;
      }
      const questionIds = this.selectedQuestions.map(
        (question) => question.questionId
      );
      addQuestionsToPaper(this.addPaperForm.paperId, questionIds)
        .then(() => {
          this.addPaperDialogVisible = false;
          this.fetchAllQuestions();
          this.$message.success("题目添加到试卷成功");
        })
        .catch((error) => {
          console.error("添加题目到试卷失败:", error);
          this.$message.error("添加题目到试卷失败");
        });
    },
  },
  mounted() {
    this.table = this.$refs["question_table"];
  },
};
</script>

<style scoped>
.cardStyle {
  height: 78vh;
  margin: 10px;
  padding: 15px 10px 10px 10px;
}

.table-container {
  background-color: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.search-container {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}

.button-group {
  display: flex;
}

.search-group {
  display: flex;
  align-items: center;
}

.dialog-footer {
  text-align: right;
}

.el-button {
  margin-right: 10px;
}

.el-button--mini {
  padding: 5px 10px;
}

.el-button--primary.plain {
  background-color: #fff;
  border-color: #409eff;
  color: #409eff;
}

.el-button--primary.plain:hover {
  background-color: #f0f7ff;
}

.el-button--danger {
  background-color: #f56c6c;
  border-color: #f56c6c;
  color: #fff;
}

.el-button--danger:hover {
  background-color: #e64242;
}
</style>