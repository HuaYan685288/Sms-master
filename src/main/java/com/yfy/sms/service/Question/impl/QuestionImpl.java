package com.yfy.sms.service.Question.impl;

import com.yfy.sms.dao.Question.QuestionMapper;
import com.yfy.sms.domain.Question;
import com.yfy.sms.service.Question.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class QuestionImpl implements QuestionService {
    @Autowired
    QuestionMapper questionMapper;

    @Override
    public List<Question> getAllQuestions(Map<String, String> params) {
        String questionId = params.get("questionId");
        String questionText = params.get("questionText");
        String score = params.get("score");
        return questionMapper.findAll(questionText,questionId,score);
    }
    @Override
    public Question getQuestionById(Integer questionId) {
        return questionMapper.findById(questionId);
    }

    @Override
    public void addQuestion(Question question) {
        questionMapper.insert(question);
    }

    @Override
    public void updateQuestion(Question question) {
        questionMapper.update(question);
    }

    @Override
    public void deleteQuestion(Integer questionId) {
        questionMapper.delete(questionId);
    }
    @Override
    public void deletepaperQuestion(Integer questionId) {
        questionMapper.paperdelete(questionId);
    }
    @Override
    public List<Question> getQuestionsByPaperId(Integer paperId) {
        return questionMapper.getQuestionsByPaperId(paperId);
    }
}
