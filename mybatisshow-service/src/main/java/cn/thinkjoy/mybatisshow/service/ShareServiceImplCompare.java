package cn.thinkjoy.mybatisshow.service;

import cn.thinkjoy.mybatisshow.dao.ShareBatchDAO;
import cn.thinkjoy.mybatisshow.dao.ShareDAO;
import cn.thinkjoy.mybatisshow.domain.Share;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import java.util.ArrayList;
import java.util.List;

/**
 * 批量插入性能比较
 * Created by qyang on 14-5-2.
 */
@Service
public class ShareServiceImplCompare {
    @Autowired
    private ShareDAO shareDAO;

    @Autowired
    private ShareBatchDAO shareBatchDAO;

    @Autowired
    private DataSourceTransactionManager txManager;

    @Autowired
    private SqlSessionFactoryBean sqlSessionFactory;

    @Autowired
    private SqlSessionTemplate sqlSessionTemplateBatch;

    private static final int SIZE = 100000;

    public Share getShare(){
        return shareDAO.fetch(1L);
    }

    public void insert(){
        Share share = new Share();
        share.setContent("ddfcvvvvvvvvvvvvv");
        shareDAO.insert(share);
    }

    public void insertBatch(){
        List<Share> shares = new ArrayList<Share>();
        Share share = null;
        for(int i = 0; i < SIZE; i++){
            share = new Share();
            share.setContent("dddd" + i);
            shares.add(share);
        }
        //shareDAO.insertList(shares);
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


    public void realBatchInsert(){
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

        TransactionStatus status = txManager.getTransaction(def);

//        SqlSession session = null;
//        try {
//            session = sqlSessionFactory.getObject().openSession(
//                    ExecutorType.BATCH, false);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

        List<Share> shares = new ArrayList<Share>();
        Share share = null;
        //ShareDAO ishareDAO = session.getMapper(ShareDAO.class);
        for(int i = 0; i < SIZE; i++){
            share = new Share();
            share.setContent("dddd" + i);
            //shares.add(share);

            //ishareDAO.insert(share);
            sqlSessionTemplateBatch.insert("cn.thinkjoy.mybatisshow.dao.ShareDAO.insert", share);
            if (i % 1000 == 0 || i == SIZE - 1) {

//                //手动每1000个一提交，提交后无法回滚
//                txManager.commit(status);
//                //清理缓存，防止溢出
//                session.clearCache();
            }
        }
        txManager.commit(status);
//        session.commit();
    }
}
