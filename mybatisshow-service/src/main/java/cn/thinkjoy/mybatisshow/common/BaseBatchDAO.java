package cn.thinkjoy.mybatisshow.common;

import java.util.List;

/**
 * 批量更新DAO接口
 * 目前使用拼sql方式，每次list不能太大，防止sql超长
 * Created by qyang on 14-5-3.
 */
public interface BaseBatchDAO<T extends BaseDomain> {
    public int batchInsert(List<T> entities);
}
