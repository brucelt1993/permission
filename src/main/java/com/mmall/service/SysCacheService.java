package com.mmall.service;

import com.google.common.base.Joiner;
import com.mmall.beans.CacheKeyConstans;
import com.mmall.util.JsonMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import redis.clients.jedis.ShardedJedis;

import javax.annotation.Resource;

@Service
@Slf4j
public class SysCacheService {
    @Resource(name = "redisPool")
    private RedisPool redisPool;

    public void saveCache(String toSaveValue, int timeoutSeconds, CacheKeyConstans prefix) {
        saveCache(toSaveValue, timeoutSeconds, prefix, null);
    }

    public void saveCache(String toSaveValue, int timeoutSeconds, CacheKeyConstans prefix, String... keys) {
        if (toSaveValue == null) {
            return;
        }
        ShardedJedis shardedJedis = null;
        try {
            String cacheKey = generateCacheKey(prefix, keys);
            shardedJedis = redisPool.instance();
            shardedJedis.setex(cacheKey, timeoutSeconds, toSaveValue);
        } catch (Exception e) {
            log.error("save cache exception,prefix:{},keys:{}", prefix.name(), JsonMapper.object2String(keys),e);
        } finally {
            redisPool.safeClose(shardedJedis);
        }
    }

    public String getFromCache(CacheKeyConstans prefix, String... keys) {
        ShardedJedis shardedJedis = null;
        String cacheKey = generateCacheKey(prefix, keys);
        try {
            shardedJedis = redisPool.instance();
            String value = shardedJedis.get(cacheKey);
            return value;
        } catch (Exception e) {
            log.error("get from cache exception,prefix:{},keys:{}", prefix.name(), JsonMapper.object2String(keys),e);
            return null;
        }finally {
            redisPool.safeClose(shardedJedis);
        }
    }

    private String generateCacheKey(CacheKeyConstans prefix, String... keys) {
        String key = prefix.name();
        if (keys != null && keys.length > 0) {
            key += "_" + Joiner.on("_").join(keys);
        }
        return key;
    }
}
