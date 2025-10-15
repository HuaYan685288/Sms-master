<template>
  <div class="cardStyle">
    <div v-if="level !== 2" class="table-container">
      <!-- <div style="margin-bottom: 15px">
        <el-button type="primary" size="small" @click="openAddPaperDialog">新增试卷</el-button>
        <el-button type="danger" size="small" @click="deleteSelectedPapers">批量删除</el-button>
      </div> -->
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
        <!-- 左侧新增和删除按钮 -->
        <div style="display: flex; gap: 10px;">
          <el-button type="primary" size="small" @click="openAddPaperDialog">新增试卷</el-button>
          <el-button type="danger" size="small" @click="deleteSelectedPapers">批量删除</el-button>
        </div>

        <!-- 右侧搜索框 -->
        <div style="display: flex; gap: 10px; align-items: center;">
          <!-- 搜索并框 -->
          <el-input v-model="papersy.paperId" placeholder="根据试卷ID查询"
            style="width: 200px; margin-right: 10px"></el-input>
          <el-input v-model="papersy.paperName" placeholder="根据试卷名称查询"
            style="width: 200px; margin-right: 10px"></el-input>
          <el-button type="primary" size="small" @click="handleSearch">搜索</el-button>
          <el-button type="info" plain size="small" @click="resetSearch">重置</el-button>
        </div>
      </div>
      <VmBaseTable :setTableHigh="true" @on-select-change="handleSelectionChange" ref="paper_table"
        :data="currentPapers" :columns="dataColumns" overflow @page-change="pageChange" showCheck showIndex
        :tableHigh="tableHigh">
      </VmBaseTable>
    </div>
    <div v-else class="paper-container student-view">
      <div class="paper-header" v-if="papers.length !== 0">
        <h2 class="page-title">选择考试试卷</h2>
        <p class="page-subtitle">请从下列试卷中选择一份开始答题</p>
      </div>
      <div class="paper-header" v-else>
        <h2 class="page-title">暂无可用试卷</h2>
        <p class="page-subtitle">
          当前没有可用的考试试卷，请稍后再试或联系管理员
        </p>
      </div>
      <div class="paper-grid">
        <div class="paper-card" v-for="paper in papers" :key="paper.paperId" @click="startExam(paper.paperId)">
          <div class="paper-card-content">
            <div class="paper-icon">
              <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none"
                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                <polyline points="14 2 14 8 20 8"></polyline>
                <line x1="16" y1="13" x2="8" y2="13"></line>
                <line x1="16" y1="17" x2="8" y2="17"></line>
                <polyline points="10 9 9 9 8 9"></polyline>
              </svg>
            </div>
            <h3 class="paper-name">{{ paper.paperName }}</h3>
            <div class="paper-meta">
              <span class="create-time">{{
                formatDate(paper.createTime)
              }}</span>
            </div>
            <button class="start-exam-btn" @click="showDialog = true">
              开始考试
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M5 12h14"></path>
                <path d="M12 5l7 7-7 7"></path>
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
    <div>
    <custom-el-dialog 
      :visible.sync="showDialog" 
      title="学生认证"
      @confirm="handleConfirm"
      @close="handleClose"
    />
  </div>
    <!-- 添加试卷对话框 -->
    <el-dialog :visible.sync="addPaperDialogVisible" title="添加试卷">
      <el-form :model="addPaperForm">
        <el-form-item label="试卷名称">
          <el-input v-model="addPaperForm.paperName"></el-input>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-date-picker v-model="addPaperForm.createTime" type="datetime" placeholder="选择日期时间"></el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addPaperDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitAddPaper">添加</el-button>
      </div>
    </el-dialog>

    <!-- 修改试卷对话框 -->
    <el-dialog :visible.sync="editPaperDialogVisible" title="修改试卷">
      <el-form :model="editPaperForm">
        <el-form-item label="试卷名称">
          <el-input v-model="editPaperForm.paperName"></el-input>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-date-picker v-model="editPaperForm.createTime" type="datetime" placeholder="选择日期时间"></el-date-picker>
        </el-form-item>
        <!-- 显示试卷题目列表 -->
        <el-form-item label="试卷题目">
          <div class="question-list-container">
            <div v-if="editPaperQuestions.length === 0" class="no-questions-tip">
              <p>该试卷暂无题目</p>
            </div>
            <!-- 使用 index 索引，index 从 0 开始，所以显示时用 index + 1 -->
            <div v-for="(question, index) in editPaperQuestions" :key="question.questionId" class="question-item">
              <!-- 显示编号 -->
              <span class="question-number">{{ index + 1 }}.</span>
              <div class="question-text">{{ question.questionText }}</div>
              <div class="delete-btn-container">
                <el-button type="danger" size="mini" @click="deleteQuestionInEdit(question.questionId)">删除</el-button>
              </div>
            </div>
          </div>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="editPaperDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitEditPaper">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import CustomElDialog from './Face.vue';
import {
listPapers,addPaper,deletePaper as apiDeletePaper,updatePaper as apiUpdatePaper, getPaper,
} from "@/api/paper";
import VmBaseTable from "../../base/base-table";
import { getQuestionsByPaperId, deletepaperQuestion } from "@/api/question";
export default {
  name: "paperList",
  components: {
    VmBaseTable,
    CustomElDialog
  },
  data() {
    return {
      showDialog: false,
      paperid:null,
      papersy: {
        paperId: "",
        paperName: ""
      },
      tableHigh: "66vh",
      level: -1,
      papers: [],
      dataColumns: [
        {
          label: "试卷ID",
          prop: "paperId",
          style: "center",
          minWidth: "100",
        },
        {
          label: "试卷名称",
          prop: "paperName",
          style: "center",
          minWidth: "200",
          showOverflowTooltip: true,
        },
        {
          label: "创建时间",
          prop: "createTime",
          style: "center",
          minWidth: "180",
        },
        {
          label: "操作",
          style: "center",
          prop: "id",
          minWidth: "200",
          render: (h, params) => {
            let btns = [];
            btns.push(
              this.getOpBtn(h, "开始考试", "primary", () => {
                this.startExam(params.row.paperId);
              })
            );

            if (this.level !== 2) {
              btns.push(
                this.getOpBtn(h, "编辑", "success", () => {
                  this.updatePaper(params.row.paperId);
                })
              );
              btns.push(
                this.getOpBtn(h, "删除", "danger", () => {
                  this.deletePaper(params.row.paperId);
                })
              );
            }

            return h("div", btns);
          },
        },
      ],
      currentPage: 1,
      pageSize: 10,
      addPaperDialogVisible: false,
      editPaperDialogVisible: false,
      addPaperForm: {
        paperName: "",
      },
      editPaperForm: {
        paperId: "",
        paperName: "",
        createTime: "",
      },
      table: null,
      currentPapers: [],
      selectedPapers: [],
      editPaperQuestions: []
    };
  },
  created() {
    this.userInfo = JSON.parse(localStorage.userInfo);
    this.level = this.userInfo.level;
    console.log(this.userInfo);
    this.fetchPapers();
  },
  methods: {
      handleConfirm(formData) {
      console.log('确认提交', formData);
      this.showDialog=false;
      this.$notify({
      title: '验证成功',
      message: '你的身份是'+this.userInfo.realName,
      type: 'success'
    });
      this.$router.push(`/ExamPage/${this.paperid}`);
    },
    handleClose() {
      console.log('弹窗关闭');
    },
      deleteQuestionInEdit(questionId) {
      this.$confirm("确定要删除这道题目吗?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      }).then(() => {
        // 使用 deletepaperQuestion 接口删除题目
        deletepaperQuestion(questionId)
          .then(() => {
            // 删除成功后重新获取题目列表
            this.getEditPaperQuestions(this.editPaperForm.paperId);
          })
          .catch((error) => {
            console.error("Error deleting question:", error);
          });
      });
    },
    handleSearch() {
      const searchParams = {};
      if (this.papersy.paperId) {
        searchParams.paperId = this.papersy.paperId;
      }
      if (this.papersy.paperName) {
        searchParams.paperName = this.papersy.paperName;
      }
      this.currentPage = 1;
      this.searchPapers(searchParams);
    },
    searchPapers(searchParams = {}) {
      // 调用后端模糊查询接口
      listPapers(searchParams)
        .then((response) => {
          this.papers = response.data;
          this.totalRecords = this.papers.length; // 更新记录总数
          this.updateCurrentPapers();
        })
        .catch((error) => {
          console.error("Error searching papers:", error);
        });
    },
    resetSearch() {
      this.papersy.paperId = '';
      this.papersy.paperName = '';
      this.searchPapers();
    },
    formatDate(dateString) {
      const options = { year: "numeric", month: "long", day: "numeric" };
      return new Date(dateString).toLocaleDateString("zh-CN", options);
    },
    getOpBtn(h, text, type, clickHandler) {
      return h(
        "el-button",
        {
          props: {
            type: type,
            size: "mini",
            plain: true,
          },
          on: {
            click: clickHandler,
          },
          style: {
            marginRight: "5px",
          },
        },
        text
      );
    },
    fetchPapers() {
      if (this.level !== 2) {
        listPapers()
          .then((response) => {
            this.papers = response.data;
            this.table.total = this.papers.length;
            this.updateCurrentPapers();
          })
          .catch((error) => {
            console.error("Error fetching papers:", error);
          });
      } else {
        getPaper(this.userInfo.id)
          .then((response) => {
            this.papers = response.data;
            if (this.papers.length == 0) {
              return;
            }
            this.updateCurrentPapers();
          })
          .catch((error) => {
            console.error("Error fetching papers:", error);
          });
      }
    },
    updateCurrentPapers() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.currentPapers = this.papers.slice(start, end);
    },
    startExam(paperId) {
      this.paperid=paperId
    },
    pageChange(page) {
      this.currentPage = page.offset / 10 + 1;
      this.updateCurrentPapers();
    },
    handleSelectionChange(selectedRows) {
      this.selectedPapers = selectedRows.map((row) => row.paperId);
    },
    openAddPaperDialog() {
      this.addPaperForm = {
        paperName: "",
      };
      this.addPaperDialogVisible = true;
    },
    submitAddPaper() {
      addPaper(this.addPaperForm)
        .then(() => {
          this.addPaperDialogVisible = false;
          this.fetchPapers();
        })
        .catch((error) => {
          console.error("Error adding paper:", error);
        });
    },
    updatePaper(paperId) {
      const paper = this.papers.find((p) => p.paperId === paperId);
      if (paper) {
        this.editPaperForm = { ...paper };
        this.editPaperDialogVisible = true;
        // 加载试卷题目列表
        this.getEditPaperQuestions(paperId); 
      } else {
        console.error('未找到对应的试卷信息', paperId);
      }
    },
    // 定义 getEditPaperQuestions 方法，使用 getQuestionsByPaperId 接口
    getEditPaperQuestions(paperId) {
      getQuestionsByPaperId(paperId)
        .then((response) => {
          // 假设接口返回的数据结构中题目列表在 data 字段
          this.editPaperQuestions = response.data; 
        })
        .catch((error) => {
          console.error('Error fetching paper questions:', error);
        });
    },
    submitEditPaper() {
      apiUpdatePaper(this.editPaperForm)
        .then(() => {
          this.editPaperDialogVisible = false;
          this.fetchPapers();
        })
        .catch((error) => {
          console.error("Error editing paper:", error);
        });
    },
    deletePaper(paperId) {
      this.$confirm("确定要删除这份试卷吗?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      }).then(() => {
        apiDeletePaper(paperId)
          .then(() => {
            this.fetchPapers();
          })
          .catch((error) => {
            console.error("Error deleting paper:", error);
          });
      });
    },
    deleteSelectedPapers() {
      if (this.selectedPapers.length === 0) {
        this.$message({
          type: "info",
          message: "请至少选择一份试卷",
        });
        return;
      }

      this.$confirm(
        `确定要删除选中的 ${this.selectedPapers.length} 份试卷吗?`,
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        }
      ).then(() => {
        Promise.all(this.selectedPapers.map((id) => apiDeletePaper(id)))
          .then(() => {
            this.selectedPapers = [];
            this.fetchPapers();
          })
          .catch((error) => {
            console.error("Error deleting papers:", error);
          });
      });
    },
  },
  mounted() {
    this.table = this.$refs["paper_table"];
  },
};
</script>

<style scoped>
.paper-container.student-view {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.paper-header {
  text-align: center;
  margin-bottom: 40px;
}

.page-title {
  font-size: 2.2rem;
  color: #2c3e50;
  margin-bottom: 10px;
  font-weight: 600;
}

.page-subtitle {
  font-size: 1.1rem;
  color: #7f8c8d;
  margin-bottom: 30px;
}

.paper-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 25px;
  padding: 0 15px;
}

.paper-card {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  cursor: pointer;
  border: 1px solid #e0e0e0;
}

.paper-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
}

.paper-card-content {
  padding: 25px;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.paper-icon {
  margin-bottom: 20px;
  color: #3498db;
}

.paper-name {
  font-size: 1.3rem;
  color: #2c3e50;
  margin: 0 0 15px;
  font-weight: 600;
  line-height: 1.4;
}

.paper-meta {
  margin-bottom: 20px;
}

.create-time {
  font-size: 0.9rem;
  color: #95a5a6;
  display: flex;
  align-items: center;
}

.create-time::before {
  content: "📅";
  margin-right: 5px;
}

.start-exam-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  padding: 12px 20px;
  background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.start-exam-btn svg {
  margin-left: 8px;
  transition: transform 0.3s ease;
}

.paper-card:hover .start-exam-btn {
  background: linear-gradient(135deg, #2980b9 0%, #3498db 100%);
}

.paper-card:hover .start-exam-btn svg {
  transform: translateX(3px);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .paper-grid {
    grid-template-columns: 1fr;
    padding: 0;
  }

  .paper-header {
    margin-bottom: 30px;
  }

  .page-title {
    font-size: 1.8rem;
  }

  .page-subtitle {
    font-size: 1rem;
  }

  .paper-card {
    margin-bottom: 20px;
  }
}

@media (max-width: 480px) {
  .paper-container.student-view {
    padding: 15px 10px;
  }

  .paper-card-content {
    padding: 20px;
  }
}

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
.no-questions-tip {
  padding: 10px;
  background-color: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 4px;
  color: #6c757d;
  text-align: center;
}

.question-list {
  max-height: 200px;
  overflow-y: auto;
  border: 1px solid #e9ecef;
  border-radius: 4px;

}

.question-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  border-bottom: 1px solid #e9ecef;
  transition: background-color 0.3s;
}

.question-item:last-child {
  border-bottom: none;
}

.question-item:hover {
  background-color: #f8f9fa;
}

.el-form-item__label {
  font-size: 12px;
  /* 调整表单标签字体大小 */
}

.no-questions-tip p {
  font-size: 12px;
  /* 调整暂无题目提示文字大小 */
}
.question-list-container {
 height: 300px; /* 根据需要调整高度 */
  overflow-y: auto; /* 如果内容超出容器高度，则显示滚动条 */
  border: 1px solid #ebeef5; /* 可选：添加边框以区分区域 */
  padding: 10px; /* 可选：添加内边距以增加空间感 */
}
.question-number {
  margin-right: 8px;
  font-weight: bold;
  color: #666;
  font-size: 12px;
  /* 调整编号字体大小 */
}

.question-text {
  flex: 1;
  margin-right: 15px;
  line-height: 1.5;
  color: #333;
  font-size: 12px;
  /* 调整题目文字大小 */
}
</style>