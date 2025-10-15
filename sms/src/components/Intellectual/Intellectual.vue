
<template>
  <div class="box">
    <div class="content_a">
      <div class="top">
      <h1
          style="
          display: inline-block;
          font-size: 16px;
          font-weight: 600;
          line-height: 16px;
          margin-left: 20px;
        "
      >
        铁小科
      </h1>
      <span class="number">1.0</span>
     </div>
     <div class="text">
      <ul class="answer">
      <li v-for="(item, index) in information" :key="index">
        <i v-if="index % 2 ? 0 : 1 " class="Ai"></i>
        <span :class="{ ans2: index % 2 ? 0 : 1 }" v-html="item"></span>
      </li>
      </ul>
     </div>
    <div class="inputContainer">
      <div class="chatInput">
        <div class="optionBtn">
        </div>
        <div class="chatTextarea">
          <div class="textareaWrap">
            <textarea v-model="sub"
              placeholder="遇事不决问小科"
              maxlength="10000"
              class="ant-input"
              style="
                overflow-y: hidden;
                resize: none;
                height: 60px;
                min-height: 24px;
                max-height: 96px;">
                </textarea>
          </div>
        </div>
        <div class="disabled operateBtn" @click="submitt()">
          <i class="el-icon-s-promotion"></i>
        </div>
      </div>
    </div>
    </div>
   
  </div>
</template>
<script>
import api from '@/api/chatApi'
import axios from 'axios'
export default {
  data() {
    return {
      sub:'',
      information: ["我是铁小科，是湖铁科老师们的小助手。我在这里可以帮助您解答问题或者提供有关学校的各种信息。有什么我可以帮到您的吗？"]
    }
  },
  methods: {
    submitt() {
      
    this.information.push(this.sub)
    api.text(this.sub).then(resp => {
      if(resp){
        this.information.push(resp.data.output.choices[0].message.content)
      }
    })
    this.sub = '' 
  }

  }
}
</script>


<style>
.Ai{
  width: 60px;
  height: 60px;
  background-image: url('../../assets/ai.jpg');
  background-size: 100% 100%;
}
.text{
  height: 80%;
}
.answer{
  position: relative;
  top: 20px;
  width: 100%;
  height: 90%;
  overflow: auto;
}
.answer li{
  width: 90%;
  margin: 10px auto;
  display: flex;
    flex-direction: row;
    justify-content: flex-end;
}
.answer li span  {
background-color: hsl(240, 51%, 88%);
    border-radius: 12px;
    line-height: 35px;
    max-width: 100%;
    padding: 12px 16px;
    font-size: 20px;
    white-space: pre-wrap;
}
.answer li .ans2{
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
        color: #000;
      }
.disabled{
  align-items: center;
    background: var(--TY-Bg-2);
    border-radius: 20px;
    color: #fff;
    cursor: pointer;
    display: flex
;
    flex-shrink: 0;
    height: 50px;
    justify-content: center;
    margin-left: 16px;
    position: relative;
    top: -25px;
    width: 50px;
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
/* .el-main::before{
  content: "";
    position: absolute;
    top: 0px;
    left: 240px;
    width: 720px;
    height: 100%;
    background-image: url(https://img.alicdn.com/imgextra/i3/O1CN010aKVQw1zmImwHGd1u_!!6000000006756-0-tps-720-840.jpg), linear-gradient(105deg, rgb(97, 92, 237) 7%, rgb(213, 220, 255) 66%);
    background-position: left center;
    background-size: cover;
    background-repeat: no-repeat;
    z-index: -1;
}
.el-main::after{
  content: "";
    position: absolute;
    top: 0px;
    left: 720px;
    height: 100%;
    width: calc(100% - 720px);
    background: rgb(213, 220, 255);
    z-index: -1;
} */
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
.textareaWrap{
  height: 100%;
    margin-bottom: 10px;

}
.chatTextarea{
    flex: 1;
    height: 100%;
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
.ant-input{
  background: transparent !important;
    border: 0;
    box-shadow: none !important;
    caret-color: #26244c !important;
    color: #26244c !important;
    font-size: 22px;
    line-height: normal;
    line-height: 48px;
    margin-top: 8px;
    min-height: 28px;
    outline: 0;
    padding: 0 8px 0 0;
    resize: none;
    transition: none !important;
    width: 100%;
}
.anticon{
  display: inline-flex
;
    align-items: center;
    color: inherit;
    font-style: normal;
    line-height: 0;
    text-align: center;
    text-transform: none;
    vertical-align: -0.125em;
    text-rendering: optimizeLegibility;
    -webkit-font-smoothing: antialiased;
}
</style>