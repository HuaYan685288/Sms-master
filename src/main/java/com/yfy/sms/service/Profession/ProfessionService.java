package com.yfy.sms.service.Profession;

import com.yfy.sms.domain.Profession;

import java.util.List;

/**
 * Description 专业信息Service层
 * Author: yfy
 * Date2024/3/31 17:31
 **/
public interface ProfessionService {
/**
* description: 获取专业
* return:
* Author: yfy
* @Date: 2020/3/31 17:31
*/
  List<Profession> getProfessionList();
}
