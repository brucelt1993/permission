package com.mmall.service;

import com.google.common.base.Preconditions;
import com.mmall.beans.PageQuery;
import com.mmall.beans.PageResult;
import com.mmall.common.RequestHolder;
import com.mmall.dao.SysAclMapper;
import com.mmall.exception.ParamException;
import com.mmall.model.SysAcl;
import com.mmall.param.AclParam;
import com.mmall.util.BeanValidator;
import com.mmall.util.IpUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.security.acl.Acl;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class SysAclService {
    @Resource
    private SysAclMapper sysAclMapper;

    public void save(AclParam param) {
        BeanValidator.check(param);
        if (checkExist(param.getAclModuleId(), param.getName(), param.getId())) {
            throw new ParamException("当前权限模块下面存在相同名称的权限点");
        }
        SysAcl acl = SysAcl.builder().name(param.getName()).aclModuleId(param.getAclModuleId())
                .url(param.getUrl()).type(param.getType()).status(param.getStatus())
                .seq(param.getSeq()).remark(param.getRemark()).build();
        acl.setCode(generateCode());
        acl.setOperator(RequestHolder.getCurrentUser().getUsername());//TODO:
        acl.setOperatorIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));//TODO:
        acl.setOperatorTime(new Date());
        sysAclMapper.insertSelective(acl);
    }

    public void update(AclParam param) {
        BeanValidator.check(param);
        if (checkExist(param.getAclModuleId(), param.getName(), param.getId())) {
            throw new ParamException("当前权限模块下面存在相同名称的权限点");
        }
        SysAcl before = sysAclMapper.selectByPrimaryKey(param.getId());
        Preconditions.checkNotNull(before,"待更新的权限点不存在");
        SysAcl after = SysAcl.builder().id(param.getId()).name(param.getName()).aclModuleId(param.getAclModuleId())
                .url(param.getUrl()).type(param.getType()).status(param.getStatus())
                .seq(param.getSeq()).remark(param.getRemark()).build();
        after.setOperator(RequestHolder.getCurrentUser().getUsername());//TODO:
        after.setOperatorIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));//TODO:
        after.setOperatorTime(new Date());
        sysAclMapper.updateByPrimaryKeySelective(after);
    }

    public boolean checkExist(int aclModuleId, String name, Integer id) {
        return false;
    }

    public String generateCode() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        return dateFormat.format(new Date()) + "_" + (int) Math.random() * 100;
    }
    public PageResult<SysAcl> getPageByAclModuleId(int aclModuleId, PageQuery page){
        BeanValidator.check(page);
        int count = sysAclMapper.countByAclModuleId(aclModuleId);
        if(count>0){
            List<SysAcl> aclList = sysAclMapper.getPageByAclModuleId(aclModuleId,page);
            return PageResult.<SysAcl>builder().data(aclList).total(count).build();
        }
        return PageResult.<SysAcl>builder().build();
    }
}