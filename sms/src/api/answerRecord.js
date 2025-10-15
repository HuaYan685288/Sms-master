import request from '@/utils/request';

// 提交考试答案
export function submitScore(data) {
  return request({
    url: '/api/exams/submit',
    method: 'post',
    data: data
  });
}

//查询用户成绩
export function listScore(data) {
  return request({
    url: '/api/exams/scores',
    method: 'post',
    data: data
  });
}