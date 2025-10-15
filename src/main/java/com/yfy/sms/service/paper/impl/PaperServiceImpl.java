package com.yfy.sms.service.paper.impl;

import com.yfy.sms.dao.Paper.PaperMapper;
import com.yfy.sms.domain.Paper;
import com.yfy.sms.service.paper.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class PaperServiceImpl implements PaperService {
    @Autowired
    private PaperMapper paperMapper;

    @Override
    public List<Paper> getAllPapers() {
        return paperMapper.findAll();
    }
    @Override
    public List<Paper> getstudent(Long id) {
        return paperMapper.getstudent(id);
    }
    @Override
    public void addPaper(Paper paper) {
        paperMapper.insert(paper);
    }

    @Override
    public void updatePaper(Paper paper) {
        paperMapper.update(paper);
    }

    @Override
    public void deletePaper(Integer paperId) {
        paperMapper.answer_records(paperId);
        paperMapper.paper_question(paperId);
        paperMapper.delete(paperId);
    }

    @Override
    public void addQuestionsToPaper(Integer paperId, List<Integer> questionIds) {
        if (questionIds == null || questionIds.isEmpty()) {
            throw new IllegalArgumentException("题目ID列表不能为空");
        }

        // 遍历 questionIds，逐个调用 Mapper
        for (Integer questionId : questionIds) {
            // 创建参数 Map（每个 questionId 单独处理）
            Map<String, Object> params = new HashMap<>();
            params.put("paperId", paperId);
            params.put("questionIds", String.valueOf(questionId)); // 单个 questionId 转为字符串
            // 调用 Mapper（每次插入一个 questionId）
            paperMapper.addQuestionsToPaper(params);
        }
    }

    public Paper getPaperById(Integer paperId) {
        return paperMapper.findById(paperId);
    }


}
