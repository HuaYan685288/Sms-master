import request from '@/utils/request.js'

function chat(msg){
  return request.get('http://localhost:8443/api/chatapi/file?question='+msg)
}
function text(msg){
  return request.get('http://localhost:8443/api/chatapi/text?question='+msg)
}
export default{
  chat,
  text
}



