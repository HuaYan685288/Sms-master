package com.yfy.sms.dao.AnswerRecord;

import com.yfy.sms.domain.AnswerRecord;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;


@Mapper
public interface AnswerRecordMapper {
    @Insert("INSERT INTO answer_records (student_id, paper_id, score) VALUES (#{studentId}, #{paperId}, #{score})")
    int insertAnswerRecord(AnswerRecord answerRecord);

    List<AnswerRecord> selectAll(String studentName, String paperName, String score);
}
