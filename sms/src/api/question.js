import request from '@/utils/request';

// 查询题目列表
export function listQuestions(params) {
  return request({
    url: '/api/questions/list',
    method: 'get',
    params: params
  });
}

// 查询题目详细信息
export function getQuestion(questionId) {
  return request({
    url: `/api/questions/${questionId}`,
    method: 'get'
  });
}



// 新增题目
export function addQuestion(data) {
  return request({
    url: '/api/questions',
    method: 'post',
    data: data
  });
}

// 更新题目
export function updateQuestion(data) {
  return request({
    url:  `/api/questions/${data.questionId}`,
    method: 'put',
    data: data
  });
}

// 删除题目
export function deleteQuestion(questionId) {
  return request({
    url: `/api/questions/${questionId}`,
    method: 'delete'
  });
}
export function deletepaperQuestion(questionId) {
  return request({
    url: `/api/questions/paper/${questionId}`,
    method: 'delete'
  });
}

// 根据试卷ID查询题目列表
export function getQuestionsByPaperId(paperId) {
  return request({
    url: `/api/questions/${paperId}/questions`,
    method: 'get'
  });
}



