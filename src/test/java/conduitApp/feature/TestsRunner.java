package conduitApp.feature;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit5.Karate;

@KarateOptions( tags = {"@regression"})
class UsersRunner {
    
    @Karate.Test
    Karate testUsers() {
        // return Karate.run("feature").relativeTo(getClass());
        return Karate.run().relativeTo(getClass());
    }    

}
