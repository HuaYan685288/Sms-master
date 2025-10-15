package com.yfy.sms.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AnswerRecord {
    private Integer id;
    private String studentId;
    private String studentName;
    private Integer paperId;
    private String paperName;
    private Integer score;
}
