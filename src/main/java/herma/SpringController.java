package herma;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.vertx.java.core.json.JsonObject;

/**
 * @author Keesun Baik
 */
@Controller
public class SpringController {

	@Autowired SampleVerticle sampleVerticle;

	@RequestMapping("/howto")
	public String start(){
		return "/howto";
	}

	@RequestMapping("/send")
	public @ResponseBody String send(){
        // logic
		sampleVerticle.getIo().sockets().emit("echo", new JsonObject().putString("data", "hello spring"));
		return "ok";
	}
}
