package com.yfy.sms.controller.AnswerRecord;

import com.yfy.sms.domain.AnswerRecord;
import com.yfy.sms.service.AnswerRecord.AnswerRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/api/exams")
public class AnswerRecordController {

    @Autowired
    private AnswerRecordService answerRecordService;

    @PostMapping("/submit")
    public Map<String, Object> submitExam(@RequestBody AnswerRecord answerRecord) {
        boolean success = answerRecordService.saveAnswerRecord(answerRecord);
        Map<String, Object> result = new HashMap<>();
        result.put("success", success);
        result.put("message", success ? "提交成功！" : "提交失败，请重试！");
        return result;
    }


//    @GetMapping("/scores")
//    public List<Map<String, Object>> getAllScores() {
//        return answerRecordService.getAllAnswerRecordsWithDetails();
//    }
@PostMapping("/scores")
public List<AnswerRecord> getAllScores(@RequestBody Map<String, String> data) {
    return answerRecordService.getAllAnswerRecords(data);
}
}
