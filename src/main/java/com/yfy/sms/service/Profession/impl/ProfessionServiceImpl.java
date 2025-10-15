package com.yfy.sms.service.Profession.impl;

import com.yfy.sms.dao.Profession.ProfessionMapper;
import com.yfy.sms.domain.Profession;
import com.yfy.sms.service.Profession.ProfessionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Description
 * Author: yfy
 * Date2024/3/31 17:33
 **/
@Service
public class ProfessionServiceImpl implements ProfessionService {
  @Resource
  private ProfessionMapper professionMapper;

  @Override
  public List<Profession> getProfessionList() {
    return professionMapper.getProfessionList();
  }
}
