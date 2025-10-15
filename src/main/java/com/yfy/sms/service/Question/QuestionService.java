package com.yfy.sms.service.Question;


import com.yfy.sms.domain.Question;

import java.util.List;
import java.util.Map;

public interface QuestionService {

    List<Question> getAllQuestions(Map<String, String> params);
    Question getQuestionById(Integer questionId);
    void addQuestion(Question question);
    void updateQuestion(Question question);
    void deleteQuestion(Integer questionId);
    void deletepaperQuestion(Integer questionId);
    List<Question> getQuestionsByPaperId(Integer paperId);

}
