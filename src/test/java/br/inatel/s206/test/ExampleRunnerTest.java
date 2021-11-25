package br.inatel.s206.test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ExampleRunnerTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:src/test/java/br/inatel/s206/test")
                .tags("~@ignore")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
