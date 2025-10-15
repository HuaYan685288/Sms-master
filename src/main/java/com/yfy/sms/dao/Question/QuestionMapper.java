package com.yfy.sms.dao.Question;

import com.yfy.sms.domain.Question;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface QuestionMapper {

     List<Question> findAll(String questionText, String questionId, String score);
     Question findById(Integer questionId);
     int insert(Question question);
     int update(Question question);
     int delete(Integer questionId);
     int paperdelete(Integer questionId);
     /**
      * 根据试卷ID查询试卷中的题目
      *
      * @param paperId 试卷ID
      * @return 题目列表
      */
     List<Question> getQuestionsByPaperId(@Param("paperId") Integer paperId);

}
