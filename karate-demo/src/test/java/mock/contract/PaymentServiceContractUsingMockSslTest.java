package mock.contract;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.core.MockServer;
import org.junit.AfterClass;
import static org.junit.Assert.assertTrue;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 *
 * @author pthomas3
 */
public class PaymentServiceContractUsingMockSslTest {

    static MockServer server;
    static String queueName = "DEMO.CONTRACT.MOCK.SSL";

    @BeforeClass
    public static void beforeClass() {
        server = MockServer
                .feature("classpath:mock/contract/payment-service-mock.feature")
                .arg("queueName", queueName)
                .https(0).build();
    }
    
    // @Test // TODO jdk 17
    public void testPaymentService() {
        String paymentServiceUrl = "https://localhost:" + server.getPort();      
        Results results = Runner.path("classpath:mock/contract/payment-service.feature")
                .configDir("classpath:mock/contract")
                .systemProperty("payment.service.url", paymentServiceUrl)
                .systemProperty("shipping.queue.name", queueName)
                .parallel(1);
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);        
    }     

    @AfterClass
    public static void afterClass() {
        server.stop();
    }

}
