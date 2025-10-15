<template>
    <el-dialog
      :visible.sync="innerVisible"
      :title="title"
      width="25%"
      @close="handleClose"
    >
      <el-form :model="formData" label-width="100px">
        <!-- 学号输入框 -->
        <el-form-item 
          label="学号" 
          prop="studentId"
          :rules="[
            { required: true, message: '请输入学号', trigger: 'blur' },
            { pattern: /^\d+$/, message: '学号必须为数字', trigger: 'blur' }
          ]"
        >
          <el-input v-model="formData.studentId" placeholder="请输入学号"></el-input>
        </el-form-item>
        
        <!-- 人脸识别区域 -->
        <el-form-item label="人脸识别">
          <div class="login-mid">
            <div class="login-mid-top">
              <div class="shadow-top-left"></div>
              <div class="shadow-top-right"></div>
            </div>
            <div class="login-mid-mid" ref="effet"></div>
            <div class="login-mid-bot">
              <div class="shadow-bot-left"></div>
              <div class="shadow-bot-right"></div>
            </div>
          </div>
        </el-form-item>
      </el-form>
      
      <span slot="footer" class="dialog-footer">
        <el-button @click="handleCancel">取 消</el-button>
        <el-button 
          type="primary" 
          @click="handleSubmit" 
          :loading="isLoading"
        >
          提交
        </el-button>
      </span>
    </el-dialog>
  </template>
  
  <script>
  export default {
    name: 'CustomElDialog',
    props: {
      visible: {
        type: Boolean,
        default: false
      },
      title: {
        type: String,
        default: '人脸识别验证'
      }
    },
    data() {
      return {
        base64Image:null,
        innerVisible: this.visible,
        formData: {
          studentId: ''
        },
        isLoading: false,
        faceRecognition: null
      }
    },
    watch: {
      visible(newVal) {
        this.innerVisible = newVal
        if (newVal) {
          this.$nextTick(() => {
            this.initFaceRecognition()
          })
        }
      },
      innerVisible(newVal) {
        this.$emit('update:visible', newVal)
        if (!newVal) {
          this.cleanupFaceRecognition()
        }
      }
    },
    methods: {
      initFaceRecognition() {
        this.faceRecognition = this.$faceEffet.init({
          el: this.$refs.effet,
          callBack: this.faceRecognitionCallback
        })
      },
      
      handleSubmit() {

          if (!this.formData.studentId) {
            this.$message.error('请输入学号')
            return
          }
          if(this.base64Image){
            this.isLoading = true
            this.$emit('confirm', {
            studentId: this.formData.studentId,
            faceImage: this.base64Image
          })
        }else{
            this.$message.error('请通过人脸')
          }
          },

      
      faceRecognitionCallback(data) {
        if (data.progressMessage === 'success') {
          this.base64Image = data.base64Array[0]
        }
      },
      
      handleCancel() {
        this.innerVisible = false
        this.$emit('cancel')
      },
      
      handleClose() {
        this.cleanupFaceRecognition()
        this.$emit('close')
      },
      
      cleanupFaceRecognition() {
        if (this.faceRecognition) {
          this.faceRecognition.close()
          this.faceRecognition = null
        }
      }
    },
    beforeDestroy() {
      this.cleanupFaceRecognition()
    }
  }
  </script>
  
  <style scoped>
  .login-mid {
    margin-top: 250px;
    width: 250px;
    height: 100px;
  }
  .el-form-item {
    margin-bottom: 20px;
  }
  </style>