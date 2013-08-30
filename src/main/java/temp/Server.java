package temp;

import org.vertx.java.core.Handler;
import org.vertx.java.core.eventbus.EventBus;
import org.vertx.java.core.eventbus.Message;
import org.vertx.java.platform.Verticle;

/**
 * @author Keesun Baik
 */
public class Server extends Verticle {

    @Override
    public void start() {
        EventBus eventBus = vertx.eventBus();
        eventBus.registerHandler("hello", new Handler<Message>() {
            @Override
            public void handle(Message message) {
                System.out.println("I got " + message.body());
            }
        });
    }

}
