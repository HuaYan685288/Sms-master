package com.yfy.sms.controller.paper;

import com.yfy.sms.domain.Paper;
import com.yfy.sms.service.paper.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/papers")
public class PaperController {
    @Autowired
    private PaperService paperService;

    @GetMapping
        public List<Paper> getAllPapers() {
        return paperService.getAllPapers();
    }
    @GetMapping("/{id}")
    public List<Paper> getstudent(@PathVariable String id) {
        System.out.println(id);
        long num = Long.parseLong(id);
        return paperService.getstudent(num);
    }
    /**
     * 添加试卷
     * @param paper
     */
    @PostMapping
    public void addPaper(@RequestBody Paper paper) {
        paperService.addPaper(paper);
    }

    @PutMapping("/{id}")
    public void updatePaper(@PathVariable Integer id, @RequestBody Paper paper) {
        paper.setPaperId(id);
        paperService.updatePaper(paper);
    }

    @DeleteMapping("/{id}")
    public void deletePaper(@PathVariable Integer id) {
        paperService.deletePaper(id);
    }

    @PostMapping("/{paperId}")
    public ResponseEntity<String> addQuestionsToPaper(@PathVariable Integer paperId, @RequestBody Map<String, Object> requestBody) {
        System.out.println(requestBody);
        List<Integer> questionIds = (List<Integer>) requestBody.get("questionIds");
        try {
            paperService.addQuestionsToPaper(paperId, questionIds);
            return ResponseEntity.ok("题目添加到试卷成功");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("添加题目到试卷失败：" + e.getMessage());
        }
    }


}
