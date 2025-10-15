<template>
  <div class="exam-container">
    <h2>{{ examTitle }}</h2>
    <div v-if="loading">
      <p>加载中...</p>
    </div>
    <div v-else-if="error">
      <p>{{ error }}</p>
    </div>
    <div v-else class="exam-content">
      <div class="timer" v-if="examDuration">剩余时间: {{ formattedTime }}</div>
      <div v-for="(question, index) in questions" :key="index" class="question-card">
        <div class="question-header">
          <span class="question-number">题目 {{ index + 1 }}:</span>
          <span class="question-text">{{ question.questionText }}</span>
        </div>
        <div v-if="question.score" class="question-score">分值: {{ question.score }}分</div>
        <div v-if="question.optionA || question.optionB || question.optionC || question.optionD" class="options">
          <label v-if="question.optionA" class="option">
            <input type="radio" :name="'q' + index" value="A" @change="recordAnswer(index, 'A')" />
            A. {{ question.optionA }}
          </label>
          <label v-if="question.optionB" class="option">
            <input type="radio" :name="'q' + index" value="B" @change="recordAnswer(index, 'B')" />
            B. {{ question.optionB }}
          </label>
          <label v-if="question.optionC" class="option">
            <input type="radio" :name="'q' + index" value="C" @change="recordAnswer(index, 'C')" />
            C. {{ question.optionC }}
          </label>
          <label v-if="question.optionD" class="option">
            <input type="radio" :name="'q' + index" value="D" @change="recordAnswer(index, 'D')" />
            D. {{ question.optionD }}
          </label>
        </div>
      </div>
      <button @click="submitExam" class="submit-button">提交试卷</button>
    </div>
  </div>
</template>

<script>
import { getQuestionsByPaperId } from '@/api/question';
import { listPapers } from '@/api/paper';
import { submitScore } from '@/api/answerRecord';

export default {
  data() {
    return {
      questions: [],
      examTitle: '',
      paperId: '',
      loading: true,
      error: null,
      examDuration: 3600,
      timer: null,
      formattedTime: '00:00:00',
      userAnswers: [],
      totalScore: 0,
      studentId: ''
    };
  },
  created() {
    this.paperId = this.$route.params.paperId;
    this.fetchQuestions();
    this.fetchPaperTitle();
  },
  methods: {
    fetchPaperTitle() {
      listPapers()
        .then(response => {
          const papers = response.data;
          const targetPaper = papers.find(paper => String(paper.paperId) === this.paperId);
          if (targetPaper) {
            this.examTitle = targetPaper.paperName;
            console.log('试卷名称:', this.examTitle);
          }
        })
        .catch(error => {
          console.error('获取试卷列表失败:', error);
          this.error = '获取试卷列表失败，请重试！';
        });
    },
    fetchQuestions() {
      getQuestionsByPaperId(this.paperId)
        .then(response => {
          this.questions = response.data;
          this.loading = false;
          this.startTimer();
          console.log('题目列表:', response.data);
        })
        .catch(error => {
          console.error('获取题目失败:', error);
          this.error = '获取题目失败，请重试！';
        });
    },
    startTimer() {
      let remainingTime = this.examDuration;
      this.timer = setInterval(() => {
        if (remainingTime <= 0) {
          clearInterval(this.timer);
          this.submitExam();
        } else {
          remainingTime--;
          this.formattedTime = this.formatTime(remainingTime);
        }
      }, 1000);
    },
    formatTime(seconds) {
      const hours = Math.floor(seconds / 3600);
      const minutes = Math.floor((seconds % 3600) / 60);
      const secs = seconds % 60;
      return `${this.padZero(hours)}:${this.padZero(minutes)}:${this.padZero(secs)}`;
    },
    padZero(num) {
      return num < 10 ? `0${num}` : num;
    },
    recordAnswer(questionIndex, option) {
      this.userAnswers[questionIndex] = option;
    },
    async submitExam() {
      clearInterval(this.timer);
      if (this.userAnswers.length !== this.questions.length) {
        alert('请回答所有问题！');
        return;
      }
      this.totalScore = 0;
      for (let i = 0; i < this.questions.length; i++) {
        const userAnswer = this.userAnswers[i];
        const correctAnswer = this.questions[i].correctAnswer;
        if (userAnswer === correctAnswer) {
          this.totalScore += this.questions[i].score;
        }
      }
      const examData = {
        studentId: this.studentId,
        paperId: parseInt(this.paperId),
        score: this.totalScore
      };
      console.log('提交数据:', examData);

try {
  const response = await submitScore(examData);
  
  if (!response.data.success) {
    console.error('提交失败:', response.data.message);
    this.$message.error('提交失败: ' + (response.data.message || '请重试！'));
    return;
  }
  // 普通学生提交成功处理
  console.log('提交成功:', response.data);
  await this.$confirm(
    `试卷提交成功！你的总分是: ${this.totalScore}`,
    '提示',
    {
      confirmButtonText: '确定',
      showCancelButton: false,
      type: 'success'
    }
  );
  
  // 跳转到成绩页面
  this.$router.push('/QuestionList');

} catch (error) {
   // 管理员测试逻辑
   if (this.userInfo.level !== 2) {
    this.$notify({
      title: '测试成功',
      message: '你的身份是'+this.userInfo.realName,
      type: 'success'
    });
    this.$router.push('/QuestionList');
    return;
  }
  console.error('提交出错:', error);
  this.$message.error('提交过程中出错，请稍后重试！');
}
        
    }
  },  
  mounted() {
      this.userInfo = JSON.parse(localStorage.userInfo);
      this.studentId = Number(this.userInfo.id);
    },
  beforeDestroy() {
    clearInterval(this.timer);
  }
};
</script>
<style scoped>
.exam-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: 'Segoe UI', system-ui, sans-serif;
}

h2 {
  color: #2c3e50;
  font-size: 2.2rem;
  text-align: center;
  margin-bottom: 2rem;
  position: relative;
  padding-bottom: 0.5rem;
}

h2::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 120px;
  height: 3px;
  background: linear-gradient(90deg, #4CAF50 0%, #2196F3 100%);
  border-radius: 2px;
}

.timer {
  position: fixed;
  top: 120px;
  right: 30px;
  background: linear-gradient(135deg, #2196F3 0%, #4CAF50 100%);
  color: white;
  padding: 12px 20px;
  border-radius: 10px;
  font-size: 1.1rem;
  box-shadow: 0 4px 15px rgba(33, 150, 243, 0.3);
  animation: pulse 1.5s infinite;
}

@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

.question-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 25px;
  box-shadow: 0 3px 20px rgba(0, 0, 0, 0.08);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.question-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
}

.question-header {
  display: flex;
  align-items: baseline;
  margin-bottom: 15px;
}

.question-number {
  font-weight: 600;
  color: #2196F3;
  font-size: 1.1rem;
  min-width: 80px;
}

.question-text {
  color: #34495e;
  font-size: 1.05rem;
  line-height: 1.5;
}

.question-score {
  display: inline-block;
  background: #f8f9fa;
  padding: 5px 12px;
  border-radius: 15px;
  font-size: 0.9rem;
  color: #6c757d;
  margin-bottom: 15px;
  border: 1px solid #e9ecef;
}

.options {
  display: grid;
  gap: 12px;
}

.option {
  display: flex;
  align-items: center;
  padding: 14px 20px;
  border: 2px solid #e9ecef;
  border-radius: 8px;
  background: white;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
}

.option:hover {
  border-color: #2196F3;
  background: #f8f9ff;
  transform: translateX(5px);
}

.option input[type="radio"] {
  margin-right: 12px;
  width: 18px;
  height: 18px;
}

.submit-button {
  background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
  color: white;
  border: none;
  padding: 16px 40px;
  font-size: 1.1rem;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: block;
  margin: 40px auto 0;
  box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
}

.submit-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
}

/* 加载和错误状态样式优化 */
.loading,
.error {
  text-align: center;
  padding: 50px 0;
  font-size: 1.2rem;
}

.loading {
  color: #2196F3;
}

.error {
  color: #e74c3c;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .timer {
    position: static;
    margin: 0 auto 30px;
    width: fit-content;
  }
  
  .question-header {
    flex-direction: column;
    gap: 8px;
  }
  
  .question-number {
    min-width: auto;
  }
}
</style>