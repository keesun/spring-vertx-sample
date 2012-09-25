<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>RTCS2 Sample</title>
    <link href="/resources/css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/prettify.css" rel="stylesheet">
</head>
<body>
<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="#">RTCS2</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li class=""><a href="/">Home</a></li>
                    <li class="active"><a href="/howto">Get started</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <h2>First</h2>
    <p>NHN 메이븐 저장소 설정을 pom.xml에 추가합니다.</p>
<pre class="prettyprint linenums languague-xml">
&lt;repositories&gt;
    ...
    &lt;repository&gt;
        &lt;id&gt;nhn&lt;/id&gt;
        &lt;url&gt;http://repo.nhncorp.com/nexus/content/groups/nhn/&lt;/url&gt;
    &lt;/repository&gt;
&lt;/repositories&gt;
</pre>
    <h2>Second</h2>
    <p>mod-socket-io 라이브러리를 dependency에 추가합니다.</p>
<pre class="prettyprint linenums languague-xml">
&lt;dependency&gt;
    &lt;groupId&gt;com.nhncorp&lt;/groupId&gt;
    &lt;artifactId&gt;mod-socket-io&lt;/artifactId&gt;
    &lt;version&gt;0.9&lt;/version&gt;
&lt;/dependency&gt;
</pre>
    <h2>Third</h2>
    <p><code>DefaultEmbeddableVerticle</code>을 상속받아 Verticle을 작성하고 빈으로 등록합니다.</p>
<pre class="prettyprint linenums languague-java">
@Component
public class SampleVerticle extends DefaultEmbeddableVerticle {

	@Override
	public void start(Vertx vertx) {
		HttpServer server = vertx.createHttpServer();
		SocketIOServer io = new DefaultSocketIOServer(vertx, server);
		io.sockets().onConnection(new Handler&lt;SocketIOSocket&gt;() {
            public void handle(final SocketIOSocket socket) {
                socket.emit("welcome");
                socket.on("echo", new Handler&lt;JsonObject&gt;() {
                    public void handle(JsonObject msg) {
                        socket.emit("echo", msg);
                    }
                });
            }
        });
        server.listen(19999);
    }
}
</pre>
    <h2>Forth</h2>
    <p>클라이언트를 작성합니다.</p>
<pre class="prettyprint linenums languague-java">
var socket = io.connect("http://localhost:19999");
socket.on('connect', function(){
    console.log('connected');
});
</pre>
    <h2>Last</h2>
    <p>스프링 웹 애플리케이션을 실행하면 Verticle도 실행되고 애플리케이션을 종료하면 Verticle로 종료됩니다.</p>
    <button id="testBtn" class="btn btn-info">Test Node.js</button>
    <button id="testBtn2" class="btn btn-info">Test Spring MVC</button>
    <footer>
        <hr/>
        <p>@ NHN 2012</p>
    </footer>
</div>

<script src="/resources/js/jquery-1.7.2.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/socket.io.js"></script>
<script src="/resources/js/prettify.js"></script>
<script type="text/javascript">
    $(function(){
        prettyPrint();
        var socket = io.connect("http://localhost:19999");
        socket.on('connect', function(){
            console.log('connected');
        });
        socket.on('echo', function(msg){
            console.dir(msg);
            alert(msg.data);
        });

        $('#testBtn').click(function(){
            socket.emit('echo', 'hello');
        });

        $('#testBtn2').click(function(){
            $.get("/send");
        });
    });
</script>
</body>
</html>