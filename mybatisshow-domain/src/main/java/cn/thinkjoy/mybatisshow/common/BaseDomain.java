package cn.thinkjoy.mybatisshow.common;

import java.io.Serializable;

/**
 * 我们的domain都需要有id属性
 * Created by qyang on 14-5-2.
 */
public class BaseDomain implements Serializable{
    private long id;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
