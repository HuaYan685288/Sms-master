package com.yfy.sms.service.AnswerRecord.impl;


import com.yfy.sms.dao.AnswerRecord.AnswerRecordMapper;
import com.yfy.sms.domain.AnswerRecord;

import com.yfy.sms.domain.Paper;
import com.yfy.sms.domain.Student;
import com.yfy.sms.service.AnswerRecord.AnswerRecordService;

import com.yfy.sms.service.Student.StudentService;
import com.yfy.sms.service.paper.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class AnswerRecordImpl implements AnswerRecordService {

    @Autowired
    private AnswerRecordMapper answerRecordMapper;

//    @Autowired
//    private StudentService studentService;
//
//    @Autowired
//    private PaperService paperService;
//
//    public List<Map<String, Object>> getAllAnswerRecordsWithDetails() {
//        List<AnswerRecord> answerRecords = answerRecordMapper.selectAll();
//        List<Map<String, Object>> result = new ArrayList<>();
//
//        for (AnswerRecord record : answerRecords) {
//            Map<String, Object> resultMap = new HashMap<>();
//            resultMap.put("studentId", record.getStudentId());
//
//            // 获取学生姓名
//            Student student = studentService.getStudentById(record.getStudentId());
//            resultMap.put("studentName", student.getStudentName());
//
//            resultMap.put("paperId", record.getPaperId());
//
//            // 获取试卷名称
//            Paper paper = paperService.getPaperById(record.getPaperId());
//            resultMap.put("paperName", paper.getPaperName());
//
//            resultMap.put("score", record.getScore());
//            result.add(resultMap);
//        }
//
//        return result;
//    }

    public boolean saveAnswerRecord(AnswerRecord answerRecord) {
        int result = answerRecordMapper.insertAnswerRecord(answerRecord);
        return result > 0;
    }

    @Override
    public List<AnswerRecord> getAllAnswerRecords( Map<String, String> params) {
        String studentName = params.get("studentName");
        String paperName = params.get("paperName");
        String score = params.get("score");
        System.out.println(studentName + " " + paperName + " " + score);
        return answerRecordMapper.selectAll(studentName, paperName, score);
    }


}





