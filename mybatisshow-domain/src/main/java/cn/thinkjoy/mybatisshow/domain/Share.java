package cn.thinkjoy.mybatisshow.domain;

import cn.thinkjoy.mybatisshow.common.BaseDomain;

/**
 * Created by qyang on 14-5-2.
 */
public class Share extends BaseDomain {
    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
