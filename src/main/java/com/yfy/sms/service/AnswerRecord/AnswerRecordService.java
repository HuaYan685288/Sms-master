package com.yfy.sms.service.AnswerRecord;

import com.yfy.sms.domain.AnswerRecord;
import com.yfy.sms.domain.Paper;
import com.yfy.sms.domain.Question;

import java.util.List;
import java.util.Map;

public interface AnswerRecordService {


    boolean saveAnswerRecord(AnswerRecord answerRecord);

    List<AnswerRecord> getAllAnswerRecords(Map<String, String> params);

//    List<Map<String, Object>> getAllAnswerRecordsWithDetails();



}
