package herma;

import com.nhncorp.mods.socket.io.impl.handlers.StaticHandler;
import org.junit.Test;
import org.springframework.util.FileCopyUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

/**
 * @author Keesun Baik
 */
public class ResourceTests {

	@Test
	public void loadingStaticFiles() throws IOException {
//		URL url  = SocketIOServer.class.getClassLoader().getResource("socket.io.js");
		ClassLoader loader = this.getClass().getClassLoader();
		URL url  = loader.getResource("socket.io.js");
		System.out.println(url);
		System.out.println(url.getFile());

		InputStream is = loader.getResourceAsStream("socket.io.js");
		String staticRootDir = StaticHandler.getRootDir();
		System.out.println(staticRootDir);
		File file = new File(staticRootDir + "/socket.io.js");
		File parent = file.getParentFile();
		if(parent != null && !parent.exists()) {
			parent.mkdirs();
		}
		FileCopyUtils.copy(is, new FileOutputStream(staticRootDir + "/socket.io.js"));
	}
}
