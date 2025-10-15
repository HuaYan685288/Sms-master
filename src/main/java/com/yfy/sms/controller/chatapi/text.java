package com.yfy.sms.controller.chatapi;

import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.exception.ApiException;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.yfy.sms.service.chatapi.chatapiService;
import org.springframework.web.multipart.MultipartFile;

import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/api/chatapi")
public class text {
    @Autowired
    private chatapiService chatapiService;
    @GetMapping("/text")
    public GenerationResult show2(String question) {
        System.out.println(question);
        try {
            GenerationResult result = chatapiService.callWithMessage("你现在叫铁小科,你是一个湖南铁路科技职业技术学院的一个乐于助人的小助手",question);
            System.out.println(result.getOutput().getChoices().get(0).getMessage().getContent());
            return result;
        } catch (ApiException | NoApiKeyException | InputRequiredException e) {
            // 使用日志框架记录异常信息
            System.err.println("An error occurred while calling the generation service: " + e.getMessage());
        }
        System.exit(0);
        return null;


    }
    @PostMapping("/upload")
    public GenerationResult upload(MultipartFile file) throws Exception {
        System.out.println(file);
        if (file == null || file.isEmpty()) {
            throw new InputRequiredException("File is required and cannot be empty.");
        }

        // 读取文件内容为字节数组
        byte[] bytes = file.getBytes();

        // 将字节数组转换为字符串
        String content = new String(bytes, StandardCharsets.UTF_8);

        // 打印或处理文件内容
        System.out.println(content);
        GenerationResult result = chatapiService.callWithMessage("你是一个Python老师，帮我改作业，并给出分数和解析与总结但不需要改进，满分一百分",content);
        System.out.println(result.getOutput().getChoices().get(0).getMessage().getContent());
        return result;
    }
}
