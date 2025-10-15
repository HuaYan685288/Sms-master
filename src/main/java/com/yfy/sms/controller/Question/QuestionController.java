package com.yfy.sms.controller.Question;

import com.yfy.sms.domain.Question;
import com.yfy.sms.service.Question.QuestionService;
import com.yfy.sms.service.paper.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/questions")
public class QuestionController {
    @Autowired
    private QuestionService questionService;
    @GetMapping("/list")
    public List<Question> getAllQuestions(@RequestParam Map<String, String> params) {
        System.out.println("Received search parameters: " + params);
        return questionService.getAllQuestions(params);
    }
    @GetMapping("/{id}")
    public Question getQuestionById(@PathVariable Integer id) {
        return questionService.getQuestionById(id);
    }

    @PostMapping
    public void addQuestion(@RequestBody Question question) {
        questionService.addQuestion(question);
    }

    @PutMapping("/{id}")
    public void updateQuestion(@PathVariable Integer id,@RequestBody Question question) {
        question.setQuestionId(id);
        questionService.updateQuestion(question);
    }

    @DeleteMapping("/{id}")
    public void deleteQuestion(@PathVariable Integer id) {
        questionService.deleteQuestion(id);
    }
    @DeleteMapping("/paper/{id}")
    public void deletepaperQuestion(@PathVariable Integer id) {
        questionService.deletepaperQuestion(id);
    }
    /**
     * 根据id查询内容
     * @param paperId
     * @return
     */
    @GetMapping("/{paperId}/questions")
    public List<Question> getQuestionsByPaperId(@PathVariable Integer paperId) {
        return questionService.getQuestionsByPaperId(paperId);
    }

}
