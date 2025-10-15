<template>
  <div class="box">
    <div class="content_a">
      <!-- 标题部分 -->
      <div class="top">
        <h1 style="
            display: inline-block;
            font-size: 16px;
            font-weight: 600;
            line-height: 16px;
            margin-left: 20px;">
          铁小科
        </h1>
        <span class="number">1.0</span>
      </div>

      <!-- 聊天内容 -->
      <div class="text">
        <ul class="answer2">
          <li v-for="(item, index) in information" :key="index">
            <i class="Ai"></i>
            <span class="ans2" v-html="item"></span>
          </li>
        </ul>
      </div>

      <!-- 输入区域 -->
      <div class="inputContainer">
        <div class="chatInput">
          <div class="disabled2 operateBtn" @click="submitt()">
            <span>点击提交文件</span>
            <i class="el-icon-s-promotion"></i>
          </div>
        </div>
      </div>

      <!-- 文件上传对话框 -->
      <transition name="fade">
        <div class="files" v-show="uploadDialog">
          <input type="file" ref="file"/>
          <div class="yes2" @click="doUpload()">确认</div>
        </div>
      </transition>

      <!-- 加载动画 -->
          <transition name="fade">
        <div v-if="isLoading" class="loading-overlay">
          <div class="loading-spinner"></div>
          <span class="loading-text">正在分析中...</span>
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      sub: '',
      uploadDialog: false,
      isLoading: false,
      information: ["我是铁小科，在这里我可以帮大家进行一些文件的初次批改及建议"]
    }
  },
  methods: {
    submitt() {
      this.uploadDialog = true;
    },
   doUpload() {
  this.uploadDialog = false;
  if (this.$refs.file.files.length) {
    let doc = this.$refs.file.files[0];
    const formData = new FormData();
    formData.append('file', doc);

    // 开始加载动画
    this.isLoading = true;

    axios.post('/api/chatapi/upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    }).then(resp => {
      console.log('服务器响应:', resp);
      if (resp.data.output.choices[0].message.content.length > 0) {
          this.information.push(resp.data.output.choices[0].message.content);
      } else {
        this.information.push('服务器响应格式不正确');
      }
    }).catch(err => {
      console.error('请求出错:', err);
      this.information.push('发生错误，请稍后再试。');
    }).finally(() => {
      // 请求完成，关闭加载动画并重置文件上传对话框
      this.uploadDialog = false;
      this.isLoading = false;
    });
  } else {
    this.uploadDialog = false;
  }
}
  }
}
</script>

<style scoped>
/* 过渡动画样式 */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.4s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

.loading {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 20px;
  border-radius: 5px;
  z-index: 999;
}

.files{
  position: fixed;
  top: 50%;
  left: 60%;
  transform: translate(-50%, -50%);
  width: 500px;
  height: 60px;
  background-color: rgba(1, 1, 1, 0.4);
  color: aliceblue;
  border-radius: 5px;
}
.files input{
  width: 300px;
  height: 30px;
}
.yes2 {
  height: 26px;
  text-align: center;
  color: antiquewhite;
  border-radius: 0 0 5px 5px;
}
.Ai{
  width: 60px;
  height: 60px;
  background-image: url('../../assets/ai.jpg');
  background-size: 100% 100%;
}
.text{
  height: 80%;
}
.answer2{
  position: relative;
  top: 20px;
  width: 100%;
  height: 90%;
  overflow: auto;
}
.answer2 li{
  width: 90%;
  margin: 10px auto;
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
}
.answer2 li span  {
  background-color: hsl(240, 51%, 88%);
  border-radius: 12px;
  line-height: 35px;
  max-width: 100%;
  padding: 12px 16px;
  font-size: 20px;
  white-space: pre-wrap;
}
.answer2 li .ans2{
  background: #fff;
  border: 1px solid transparent;
  border-radius: 12px;
  display: flex;
  min-height: 30px;
  overflow: hidden;
  padding: 16px 20px;
  position: relative;
  width: 90%;
}
ul {
  margin: 0;
  padding: 0;
}
li {
  list-style: none;
  color: aliceblue;
  line-height: 60px;
  font-size: 25px;
  width: 100%;
  color: #000;
}
.disabled2{
  align-items: center;
  background: var(--TY-Bg-2);
  border-radius: 20px;
  color: #fff;
  cursor: pointer;
  display: flex;
  flex-shrink: 0;
  height: 60px;
  justify-content: center;
  width: 99%;
}
.box {
  width: 100%;
  height: 94.5%;
}
.top {
  width: 100%;
  height: 40px;
}
.number {
  color: #8f91a8;
  font-weight: 400;
  margin-left: 4px;
}
.content_a {
  width: 95%;
  height: 94%;
  margin: 0 0 0px 50px;
  overflow: hidden;
  position: relative;
  top: 20px;
  border-radius: 15px;
  background-color: #f6f7fb;
}
.box{
  background: linear-gradient(to right,  #558eec , #c0d5f8)!important;
}
.inputContainer{
  align-items: center;
  background: #fff;
  border: 1px solid var(--TY-Line-1);
  border-radius: 20px;
  box-shadow: 0 12px 24px -16px rgba(54, 54, 73, .04), 0 12px 40px 0 rgba(51, 51, 71, .08), 0 0 1px 0 rgba(44, 44, 54, .02);
  display: flex;
  flex-direction: column;
  transition: border .4s ease;
  height: 80px;
  margin: 0 30px;
}
.chatInput{
  align-items: flex-end;
  display: flex;
  flex: 1;
  margin: 0 auto;
  padding: 8px 8px 8px 16px;
  position: relative;
  width: 95%;
  z-index: 2;
}
/* 加载状态 */
.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.8);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
}
.loading-spinner {
  width: 40px;
  height: 40px;
  border: 3px solid #f3f3f3;
  border-top: 3px solid #409eff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.loading-text {
  color: #606266;
  font-size: 14px;
}
/* 动画效果 */
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
