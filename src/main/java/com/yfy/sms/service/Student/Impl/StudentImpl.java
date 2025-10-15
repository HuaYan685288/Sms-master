package com.yfy.sms.service.Student.Impl;

import com.yfy.sms.dao.User.StudentMapper;
import com.yfy.sms.domain.Student;
import com.yfy.sms.service.Student.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;

    public Student getStudentById(String studentId) {
        return studentMapper.selectById(studentId);
    }
}
