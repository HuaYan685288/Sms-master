package com.yfy.sms.dao.Paper;

import com.yfy.sms.domain.Paper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface PaperMapper {
    List<Paper> findAll();
    List<Paper> getstudent(Long id);
    void insert(Paper paper);
    void update(Paper paper);
    void paper_question(Integer paperId);
    void answer_records(Integer paperId);
    void delete(Integer paperId);
    Paper findById(Integer paperId);
    void addQuestionsToPaper(@Param("params") Map<String, Object> params);

}
