package com.yfy.sms.dao.User;

import com.github.pagehelper.PageRowBounds;
import com.yfy.sms.dto.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Description 管理员账号Mapper层
 * Author: yfy
 * Date2024/3/28 11:08
 **/
@Mapper
public interface AdminMapper {
  /**
   * description: 新增管理员账号信息
   * @param user
   * @return void
   * @author yfy
   * @date 2020/3/4 23:05
   */
  void add(User user);

  /**
   * description: 删除管理员账号
   *
   * @param ids
   * @return void
   * @author yfy
   * @date 2019/8/29 14:55
   */
  void delete(@Param("ids") List<Integer> ids);

  /**
   * description: 修改管理员账号
   *
   * @param user
   * @return void
   * @author yfy
   * @date 2019/8/29 14:55
   */
  void update(User user);

  /**
   * description: 获取管理员账号信息列表
   * @param rowBounds
   * @author yfy
   * @return java.util.List<dto.com.yfy.sms.User>
   * @date 2020/3/4 23:05
   */
  List<User> getAdminList(PageRowBounds rowBounds, @Param("condition") Map<String, Object> condition);
  /**
  * description: 根据管理员id获取管理员信息
  * @param: String
  * return: User
  * Author: yfy
  * @Date: 2020/3/30 23:43
  */
  User getUserById(@Param("id") String id);
  /**
   * description: 查看管理员人数
   * return: Integer
   * Author: yfy
   * @Date: 2020/3/11 15:03
   */
  Integer checkCodeCount();
}
