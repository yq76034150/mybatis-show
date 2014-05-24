package cn.thinkjoy.mybatisshow.domain;

import cn.thinkjoy.mybatisshow.common.BaseDomain;

/**
 * Created by qyang on 14-5-3.
 */
public class ShareComments extends BaseDomain{
    private Share share;
    private String content;
    private long userId;

    public Share getShare() {
        return share;
    }

    public void setShare(Share share) {
        this.share = share;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }
}
