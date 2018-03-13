package com.mmall.service;

import com.google.common.base.Preconditions;
import com.google.common.collect.Sets;
import com.mmall.beans.Mail;
import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.RequestHolder;
import com.mmall.dao.SysUserMapper;
import com.mmall.exception.ParamException;
import com.mmall.model.SysUser;
import com.mmall.param.UserParam;
import com.mmall.util.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
public class SysUserService {
    @Resource
    private SysUserMapper sysUserMapper;

    /**
     * 保存
     *
     * @param param
     */
    public void save(UserParam param) {
        BeanValidator.check(param);
        if (checkEmailExist(param.getMail(), param.getId())) {
            throw new ParamException("邮箱已被使用用");
        }
        if (checkTelephoneExist(param.getTelephone(), param.getId())) {
            throw new ParamException("电话已被占用");
        }
        String password = PasswordUtil.randomPassword();
        String encryptedPassword = MD5Util.encrypt(password);
        SysUser sysUser = SysUser.builder().username(param.getUsername()).telephone(param.getTelephone())
                .mail(param.getMail()).password(encryptedPassword).deptId(param.getDeptId()).status(param.getStatus())
                .remark(param.getRemark()).build();
        sysUser.setOperator(RequestHolder.getCurrentUser().getUsername());//TODO:
        sysUser.setOperatorIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        sysUser.setOperatorTime(new Date());
        //TODO:SendEmail
        String object = "权限网站更新密码通知!";
        String message = "尊敬的" + sysUser.getUsername() + "用户,您的初始密码为:" + password + ",请及时更新密码";
        String receiver = "1253565646@qq.com";
        Set<String> receivers = Sets.newHashSet();
        receivers.add(receiver);
        Mail mail = Mail.builder().subject(object).message(message).receivers(receivers).build();
        if (MailUtil.send(mail)) {
            sysUserMapper.insertSelective(sysUser);
        } else {
            log.info("发送邮件异常");
        }
    }

    /**
     * 更新
     *
     * @param param
     */
    public void update(UserParam param) {
        BeanValidator.check(param);
        if (checkEmailExist(param.getMail(), param.getId())) {
            throw new ParamException("邮箱已被使用用");
        }
        if (checkTelephoneExist(param.getTelephone(), param.getId())) {
            throw new ParamException("电话已被占用");
        }
        SysUser before = sysUserMapper.selectByPrimaryKey(param.getId());
        Preconditions.checkNotNull(before, "待更新的用户不存在");
        SysUser after = SysUser.builder().id(param.getId()).username(param.getUsername()).telephone(param.getTelephone())
                .mail(param.getMail()).password(before.getPassword()).deptId(param.getDeptId()).status(param.getStatus())
                .remark(param.getRemark()).build();
        after.setOperator(RequestHolder.getCurrentUser().getUsername());//TODO:
        after.setOperatorIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));//TODO:
        after.setOperatorTime(new Date());
        sysUserMapper.updateByPrimaryKeySelective(after);
    }

    public boolean checkEmailExist(String mail, Integer userId) {
        return sysUserMapper.countByMail(mail, userId) > 0;
    }

    public boolean checkTelephoneExist(String telephone, Integer userId) {
        return sysUserMapper.countByTelephone(telephone, userId) > 0;
    }

    public SysUser findByKeyword(String keyword) {
        return sysUserMapper.findByKeyword(keyword);
    }

    public PageResult<SysUser> getPageByDeptId(int deptId, PageQuery page) {
        BeanValidator.check(page);
        int count = sysUserMapper.countByDeptId(deptId);
        if (count > 0) {
            List<SysUser> list = sysUserMapper.getPageByDeptId(deptId, page);
            return PageResult.<SysUser>builder().total(count).data(list).build();
        }
        return PageResult.<SysUser>builder().build();
    }

    public List<SysUser> getAll(){
        return sysUserMapper.getAll();
    }
}
