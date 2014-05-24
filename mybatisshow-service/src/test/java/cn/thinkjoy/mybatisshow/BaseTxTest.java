package cn.thinkjoy.mybatisshow;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 事务测试基类
 * 根据规范，应用的配置主入口为spring.xml
 * Created by qyang on 14-5-3.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring.xml")
public class BaseTxTest extends AbstractTransactionalJUnit4SpringContextTests {
}
