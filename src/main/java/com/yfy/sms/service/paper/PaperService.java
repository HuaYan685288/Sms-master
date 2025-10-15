package com.yfy.sms.service.paper;

import com.yfy.sms.domain.Paper;

import java.util.List;

public interface PaperService {
    List<Paper> getAllPapers();
    List<Paper> getstudent(Long id);
    void addPaper(Paper paper);
    void updatePaper(Paper paper);
    void deletePaper(Integer paperId);
    void addQuestionsToPaper(Integer paperId, List<Integer> questionIds);

    Paper getPaperById(Integer paperId);

}
