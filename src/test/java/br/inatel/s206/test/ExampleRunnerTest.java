package br.inatel.s206.test;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(features= "classpath:br/inatel/s206/test/example.feature")
class ExampleRunnerTest {

}
