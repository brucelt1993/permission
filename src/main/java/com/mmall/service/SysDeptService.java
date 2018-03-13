package com.mmall.service;

import com.google.common.base.Preconditions;
import com.mmall.common.RequestHolder;
import com.mmall.dao.SysDeptMapper;
import com.mmall.dao.SysUserMapper;
import com.mmall.exception.ParamException;
import com.mmall.model.SysDept;
import com.mmall.param.DeptParam;
import com.mmall.util.BeanValidator;
import com.mmall.util.IpUtil;
import com.mmall.util.LevelUtil;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class SysDeptService {
    @Resource
    private SysDeptMapper sysDeptMapper;
    @Resource
    private SysUserMapper sysUserMapper;

    /**
     * 保存
     * @param param
     */
    public void save(DeptParam param) {
        BeanValidator.check(param);
        if(checkExist(param.getParentId(),param.getName(),param.getId())){
            throw new ParamException("同一层级下存在相同名称的部门");
        }
        SysDept dept = SysDept.builder().name(param.getName()).parentId(param.getParentId())
                .seq(param.getSeq()).remark(param.getRemark()).build();
        dept.setLevel(LevelUtil.calculateLevel(getLevel(param.getParentId()),param.getParentId()));
        dept.setOperator(RequestHolder.getCurrentUser().getUsername());//TODO:
        dept.setOperatorIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));//TODO:
        dept.setOperatorTime(new Date());
        sysDeptMapper.insertSelective(dept);
    }

    /**
     * 更新操作
     * @param param
     */
    public void update(DeptParam param){
        BeanValidator.check(param);
        if(checkExist(param.getParentId(),param.getName(),param.getId())){
            throw new ParamException("同一层级下存在相同名称的部门");
        }
        SysDept before = sysDeptMapper.selectByPrimaryKey(param.getId());
        Preconditions.checkNotNull(before,"待更新的部门不存在");
        if(checkExist(param.getParentId(),param.getName(),param.getId())){
            throw new ParamException("同一层级下存在相同名称的部门");
        }
        SysDept after = SysDept.builder().id(param.getId()).name(param.getName()).parentId(param.getParentId())
                .seq(param.getSeq()).remark(param.getRemark()).build();
        after.setLevel(LevelUtil.calculateLevel(getLevel(param.getParentId()),param.getParentId()));
        after.setOperator(RequestHolder.getCurrentUser().getUsername());//TODO:
        after.setOperatorIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));//TODO:
        after.setOperatorTime(new Date());
        updateWithChild(before,after);
    }

    /**
     * 批量更新子部门(如果涉及到更改)
     * @param before
     * @param after
     */
    @Transactional
    private void updateWithChild(SysDept before,SysDept after){
        String newLevelPrefix = after.getLevel();
        String oldLevelPrefix = before.getLevel();
        if(!after.getLevel().equals(before.getLevel())){
            List<SysDept> deptList = sysDeptMapper.getChildDeptListByLevel(before.getLevel());
            if(CollectionUtils.isNotEmpty(deptList)){
                for(SysDept dept : deptList){
                    String level = dept.getLevel();
                    if(level.indexOf(oldLevelPrefix)==0){
                        level = newLevelPrefix+level.substring(oldLevelPrefix.length());
                        dept.setLevel(level);
                    }
                }
                sysDeptMapper.batchUpdateLevel(deptList);
            }
        }
        sysDeptMapper.updateByPrimaryKey(after);
    }
    private boolean checkExist(Integer parentId,String deptName,Integer deptId){
        return sysDeptMapper.countByNameAndParentId(parentId,deptName,deptId)>0;
    }

    /**
     * 根据deptId获取层级
     * @param deptId
     * @return
     */
    private String getLevel(Integer deptId){
        SysDept dept = sysDeptMapper.selectByPrimaryKey(deptId);
        if(dept==null){
            return null;
        }
        return dept.getLevel();
    }

    public void delete(int deptId){
        SysDept dept = sysDeptMapper.selectByPrimaryKey(deptId);
        Preconditions.checkNotNull(dept,"待删除的部门不存在，无法删除");
        if(sysDeptMapper.countByParentId(deptId)>0){
            throw new ParamException("当前部门下面有子部门，无法删除");
        }
        if(sysUserMapper.countByDeptId(deptId)>0){
            throw new ParamException("当前部门下面有用户，无法删除");
        }
        sysDeptMapper.deleteByPrimaryKey(deptId);
    }
}
