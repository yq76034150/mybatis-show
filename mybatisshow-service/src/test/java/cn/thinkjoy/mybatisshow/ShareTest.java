package cn.thinkjoy.mybatisshow;

import cn.thinkjoy.mybatisshow.service.ShareServiceImpl;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by qyang on 14-5-2.
 */
public class ShareTest extends BaseTest {

    @Autowired
    private ShareServiceImpl shareService;

    @Test
    public void testFetch(){
        shareService.addComments();

        //shareService = (ShareService) context.getBean("shareService");
//        Share share = shareService.getShare();
//        share.getContent();
//        long start = System.currentTimeMillis();
//        //shareService.insertBatch();
//        System.out.println(System.currentTimeMillis()-start);
//        start = System.currentTimeMillis();
//        //shareService.batchInsert();
//        System.out.println(System.currentTimeMillis()-start);
//
//        start = System.currentTimeMillis();
//        shareService.realBatchInsert();
//        System.out.println(System.currentTimeMillis()-start);
    }
}
