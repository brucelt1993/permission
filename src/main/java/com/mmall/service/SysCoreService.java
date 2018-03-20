package com.mmall.service;

import com.google.common.collect.Lists;
import com.mmall.beans.CacheKeyConstans;
import com.mmall.common.RequestHolder;
import com.mmall.dao.SysAclMapper;
import com.mmall.dao.SysRoleAclMapper;
import com.mmall.dao.SysRoleUserMapper;
import com.mmall.model.SysAcl;
import com.mmall.model.SysUser;
import com.mmall.util.JsonMapper;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class SysCoreService {
    @Resource
    private SysAclMapper sysAclMapper;

    @Resource
    private SysRoleUserMapper sysRoleUserMapper;

    @Resource
    private SysRoleAclMapper sysRoleAclMapper;

    @Resource
    private SysCacheService sysCacheService;
    public List<SysAcl> getCurrentUserAclList(){
        int userId = RequestHolder.getCurrentUser().getId();
        return getUserAclList(userId);
    }

    /**
     * 获取角色分配的权限点
     * @param roleId
     * @return
     */
    public List<SysAcl> getRoleAclList(int roleId){
        List<Integer> aclIdList = sysRoleAclMapper.getAclIdListByRoleIdList(Lists.newArrayList(roleId));
        if(CollectionUtils.isEmpty(aclIdList)){
            return Lists.newArrayList();
        }
        return sysAclMapper.getByIdList(aclIdList);
    }

    /**
     * 查询用户的权限点
     * @param userId
     * @return
     */
    public List<SysAcl> getUserAclList(int userId){
        if(isSuperAdmin()){
             return sysAclMapper.getAll();
        }
        List<Integer> userRoleIdList = sysRoleUserMapper.getRoleIdListByUserId(userId);
        if(CollectionUtils.isEmpty(userRoleIdList)){
            return Lists.newArrayList();
        }
        List<Integer> userAclIdList = sysRoleAclMapper.getAclIdListByRoleIdList(userRoleIdList);
        if(CollectionUtils.isEmpty(userAclIdList)){
            return Lists.newArrayList();
        }
        return sysAclMapper.getByIdList(userAclIdList);
    }

    public boolean isSuperAdmin(){
        SysUser sysUser =RequestHolder.getCurrentUser();
        if(sysUser.getMail().contains("admin") || "13535430871".equals(sysUser.getTelephone())){
            return true;
        }
        return false;
    }

    public boolean hasUrlAcl(String url){
        if(isSuperAdmin()){
            return true;
        }
        List<SysAcl> aclList = sysAclMapper.getByUrl(url);
        if(CollectionUtils.isEmpty(aclList)){
            return true;
        }
        List<SysAcl> userAclList = getCurrentUserAclListFromCache();
        Set<Integer> userAclIdSet = userAclList.stream().map(sysAcl -> sysAcl.getId()).collect(Collectors.toSet());
        boolean hasValidAcl = false;
        for(SysAcl acl : aclList){
            //判断一个用户是否具有某个权限点的访问权限
            if(acl == null || acl.getStatus()!=1){//权限点无效
                continue;
            }
            hasValidAcl = true;
            if(userAclIdSet.contains(acl.getId())){
                return true;
            }
        }
        if(!hasValidAcl){
            return true;
        }
        return false;
    }

    public List<SysAcl> getCurrentUserAclListFromCache(){
        int userId = RequestHolder.getCurrentUser().getId();
        String cacheValue = sysCacheService.getFromCache(CacheKeyConstans.USER_ACLS,String.valueOf(userId));
        if(StringUtils.isBlank(cacheValue)){
            List<SysAcl> aclList = getCurrentUserAclList();
            if(CollectionUtils.isNotEmpty(aclList)){
                sysCacheService.saveCache(JsonMapper.object2String(aclList),600,CacheKeyConstans.USER_ACLS,String.valueOf(userId));
            }
            return aclList;
        }
        return JsonMapper.String2Obj(cacheValue, new TypeReference<List<SysAcl>>() {
        });
    }
}
