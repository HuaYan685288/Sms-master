import request from '@/utils/request';

// 查询试卷列表
export function listPapers(query) {
  return request({
    url: '/api/papers',
    method: 'get',
    params: query
  });
}

// 查询试卷详细信息
export function getPaper(paperId) {
  return request({
    url: `/api/papers/${paperId}`,
    method: 'get'
    
  });
}

// 新增试卷
export function addPaper(data) {
  return request({
    url: '/api/papers',
    method: 'post',
    data: data
  });
}

// 更新试卷
export function updatePaper(data) {
  return request({
    url: `/api/papers/${data.paperId}`,
    method: 'put',
    data: data
  });
}

// 删除试卷
export function deletePaper(paperId) {
  return request({
    url: `/api/papers/${paperId}`,
    method: 'delete'
  });
}

// 将题目添加到试卷
export function addQuestionsToPaper(paperId,questionIds) {
  return request({
    url: `/api/papers/${paperId}`,
    method: 'post',
    data: {questionIds},
  
  });
}