<ncl>
    <head>
    <regionBase>
        <region id="rMain" width="100%" height="100%" zIndex="0"/> 
        <region id="rAdvertising" width="100%" height="100%" zIndex="1"/>       
    </regionBase>
    <descriptorBase>
        <descriptor id="dVideo" region="rMain"
/>
        <descriptor id="dAdvertising" region="rAdvertising" explicitDur="20s"/>
    </descriptorBase> 
    <connectorBase>
        <causalConnector id="onBeginStart">
            <simpleCondition role="onBegin"/>
            <simpleAction role="start" max="unbounded"/>
        </causalConnector>
        <causalConnector id="onBeginStartPreparation">
            <simpleCondition role="onBegin"/>
            <simpleAction role="startPreparation" max="unbounded"/>
        </causalConnector>
        <causalConnector id="onBeginSet">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
            <simpleAction role="set" value="$var"/>
        </causalConnector>
	<causalConnector id="onBeginStop">
            <simpleCondition role="onBegin"/>
            <simpleAction role="stop"/>
        </causalConnector>
	<causalConnector id="onEndStop">
            <simpleCondition role="onEnd"/>
            <simpleAction role="stop"/>
        </causalConnector>
        <causalConnector id="onEndSet">
            <connectorParam name="var"/>
            <simpleCondition role="onEnd"/>
            <simpleAction role="set" value="$var"/>
        </causalConnector>        
    </connectorBase>
    </head>
    <body>
        <port id="pInicio" component="video"/>
        <media id="video" src="media/stream.mp4" descriptor="dVideo">
	    <area id="area0" begin="10s"/>
	    <area id="area1" begin="17s"/>
            <property name="soundLevel"/>
        </media>
        <media id="advertising" src="https://raw.githubusercontent.com/marinaivanov/media-file/master/media/propaganda_viagem.mp4" descriptor="dAdvertising"/>
       
        <link xconnector="onBeginStart">
            <bind role="onBegin" component="video" interface="area1"/>
            <bind role="start" component="advertising" />            
        </link>

	<link xconnector="onBeginSet">
            <bind role="onBegin" component="advertising"/>
            <bind role="set" component="video" interface="soundLevel">
                <bindParam name="var" value="0"/>
            </bind>
        </link>

        <!--link xconnector="onEndSet">
            <bind role="onEnd" component="advertising"/>
            <bind role="set" component="video" interface="soundLevel">
                <bindParam name="var" value="0.8"/>
            </bind>
        </link-->

	<link xconnector="onEndStop">
            <bind role="onEnd" component="advertising"/>
            <bind role="stop" component="video" />            
        </link>

    </body>
</ncl>
