package com.mmall.controller;

import com.mmall.common.ApplicationContextHelper;
import com.mmall.common.JsonData;
import com.mmall.dao.SysAclModuleMapper;
import com.mmall.exception.ParamException;
import com.mmall.exception.PermissionException;
import com.mmall.model.SysAclModule;
import com.mmall.param.TestVo;
import com.mmall.util.BeanValidator;
import com.mmall.util.JsonMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/test")
@Slf4j
public class TestController {
    @RequestMapping("/hello.json")
    @ResponseBody
    public JsonData hello(){
        log.info("hello");
        return JsonData.success("hello, permission");
    }
    @RequestMapping("/hello.exception")
    @ResponseBody
    public JsonData helloException(){
        log.info("hello");
        throw new PermissionException("msg");
    }
    @RequestMapping("/validator.json")
    @ResponseBody
    public JsonData validate(TestVo vo) throws ParamException{
        log.info("validate");
        /*try {
            Map<String,String> map = BeanValidator.validateObject(vo);
            if(MapUtils.isEmpty(map)){
                for(Map.Entry<String,String> entry : map.entrySet()){
                    log.info("{}->{}",entry.getKey(),entry.getValue());
                }
            }
        }catch (Exception e){

        }*/
        BeanValidator.check(vo);
        return JsonData.success("test validate");
    }
    @RequestMapping("/jsonMapper.json")
    @ResponseBody
    public JsonData jsonMapper(TestVo vo) throws ParamException{
        log.info("validate");
        SysAclModuleMapper sysAclModuleMapper = ApplicationContextHelper.popBean(SysAclModuleMapper.class);
        SysAclModule module = sysAclModuleMapper.selectByPrimaryKey(1);
        log.info(JsonMapper.object2String(module));
        BeanValidator.check(vo);
        return JsonData.success("test validate");
    }
}
