package temp;

import org.vertx.java.core.eventbus.EventBus;
import org.vertx.java.platform.Verticle;

/**
 * @author Keesun Baik
 */
public class Client extends Verticle {

    @Override
    public void start() {
        EventBus eventBus = vertx.eventBus();
        for(int i = 0 ; i < 100 ; i++) {
            eventBus.publish("hello", "message " + i);
        }
    }
}
