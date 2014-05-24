package cn.thinkjoy.mybatisshow.service;

import cn.thinkjoy.mybatisshow.ShareService;
import cn.thinkjoy.mybatisshow.dao.ShareBatchDAO;
import cn.thinkjoy.mybatisshow.dao.ShareCommentsDAO;
import cn.thinkjoy.mybatisshow.dao.ShareDAO;
import cn.thinkjoy.mybatisshow.domain.Share;
import cn.thinkjoy.mybatisshow.domain.ShareComments;
import org.apache.ibatis.executor.BatchExecutor;
import org.apache.ibatis.executor.BatchResult;
import org.apache.ibatis.mapping.Environment;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.transaction.Transaction;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by qyang on 14-5-2.
 */
@Service
public class ShareServiceImpl implements ShareService {
    @Autowired
    private ShareDAO shareDAO;
    @Autowired
    private ShareCommentsDAO shareCommentsDAO;

    @Autowired
    private ShareBatchDAO shareBatchDAO;

    private static final int SIZE = 100000;

    public Share getShare(){
        return shareDAO.fetch(1L);
    }

    public void insert(){
        Share share = new Share();
        share.setContent("ddfcvvvvvvvvvvvvv");
        shareDAO.insert(share);
    }

    public int batchInsert(){
        List<Share> shares = new ArrayList<Share>();
        Share share = null;
        for(int i = 0; i < SIZE; i++){
            share = new Share();
            share.setContent("dddd" + i);
            shares.add(share);
        }
        return shareBatchDAO.batchInsert(shares);
    }

    @Transactional
    public void addComments(){
        Share share = new Share();
        share.setId(22222L);
        share.setContent("weeer");
        shareDAO.insert(share);
        ShareComments shareComments = new ShareComments();
        shareComments.setContent("ddfcvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvddfcvvvvvvvvvvvvvv");
        shareComments.setShare(share);
        shareCommentsDAO.insert(shareComments);
    }
}
