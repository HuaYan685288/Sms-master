package com.yfy.sms.dao.User;

import com.github.pagehelper.PageRowBounds;
import com.yfy.sms.dto.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Description 教师用户mapper层
 * Author: yfy
 * Date2024/3/7 15:11
 **/
@Mapper
public interface TeacherMapper {

  /**
   * description: 新增教师账号信息
   * @param user
   * @return void
   * @author yfy
   * @date 2020/3/4 23:05
   */
  void addTeacher(User user);

  /**
   * description: 删除教师账号
   *
   * @param ids
   * @return void
   * @author yfy
   * @date 2019/8/29 14:55
   */
  void delete(@Param("ids") List<Integer> ids);

  /**
   * description: 修改教师账号
   *
   * @param user
   * @return void
   * @author yfy
   * @date 2019/8/29 14:55
   */
  void update(User user);

  /**
   * description: 获取教师账号信息列表
   * @param rowBounds
   * @author yfy
   * @return java.util.List<dto.com.yfy.sms.User>
   * @date 2020/3/4 23:05
   */
  List<User> getTeacherList(PageRowBounds rowBounds, @Param("condition") Map<String, Object> condition);
  /**
   * description:
   * @param:
   * return:
   * Author: yfy
   * @Date: 2020/3/30 23:43
   */
  User getUserById(@Param("id") String id);
  /**
   * description: 查看人数
   * return: Integer
   * Author: yfy
   * @Date: 2020/3/11 15:03
   */
  Integer checkCodeCount();
}
