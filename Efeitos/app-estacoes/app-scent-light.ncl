<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="aplTesteEffect" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
	<regionBase>
		<region id="rg1" width="100%" height="100%" zIndex = "0" />
		<region id="rg2" location="center:top:front" />
		<region id="rg3" location="center:top:front" />

   	</regionBase>

	<descriptorBase>
	    <descriptor id="desc1"  region="rg1" explicitDur="12s"/> 
		<descriptor id="desc2"  region="rg1" explicitDur="15s"/> 
		<descriptor id="desc3"  region="rg1" explicitDur="15s"/> 
		<descriptor id="descL"  region="rg2" intensityValue="100" intensityRange="[0,10]" color="blue"/>
		<descriptor id="descScent"  region="rg2" intensityValue="10" intensityRange="[0,10]" scent="Sea"/>
	</descriptorBase>
	
	<connectorBase>

	<causalConnector id="onBeginStart">
		<simpleCondition role="onBegin" />
		<simpleAction role="start" max="unbounded"/>
	</causalConnector>
	
	<causalConnector id="onBeginSet">
	<connectorParam name="var"/>
		<simpleCondition role="onBegin" />
		<simpleAction role="set" max="unbounded" value="$var"/>
	</causalConnector>

	<causalConnector id="onEndStop">
		<simpleCondition role="onEnd" />
		<simpleAction role="stop" max="unbounded"/>
	</causalConnector>

	<causalConnector id="onEndStart">
		<simpleCondition role="onEnd" />
		<simpleAction role="start" max="unbounded"/>
	</causalConnector>

	<causalConnector id="onEndSet">
		<connectorParam name="var"/>
		<simpleCondition role="onEnd"/>
		<simpleAction role="set" value="$var"/>
      	</causalConnector>
	

	</connectorBase>
  </head>

  <body>
  	
		<port id="pVideo" component="video1" />
		<port id="pMusic" component="audio" />

		<media id="audio" src="media/soundtrack.mp3"/>

		<media id="video1" src="media/autumn_720.mp4" descriptor="desc1"/>
		<media id="video2" src="media/forest_720.mp4" descriptor="desc2"/>
		<media id="video3" src="media/lavender_720.mp4" descriptor="desc3"/>
		
		<effect id="lightEffect" type="LightType" descriptor="descL">
			<property name="color" value="orange"/>
			<property name="intensityValue" value="100"/>
		</effect>

		<effect id="scentEffect" type="ScentType" descriptor="descScent"/>

		<link xconnector="onBeginStart">
			<bind role="onBegin" component="video1"  />
			<bind role="start" component="lightEffect" />
		</link>

		<link xconnector="onEndStart">
			<bind role="onEnd" component="video1"  />
			<bind role="start" component="video2" />
		</link>

		<link xconnector="onBeginSet">
			<bind role="onBegin" component="video2"/>
			<bind role="set" component="lightEffect" interface="color" >
				<bindParam name="var" value="green"/>
			</bind>
		</link>

		<link xconnector="onEndStart">
			<bind role="onEnd" component="video2"  />
			<bind role="start" component="video3" />
		</link>

		<link xconnector="onBeginSet">
			<bind role="onBegin" component="video3"/>
			<bind role="set" component="lightEffect" interface="color" >
				<bindParam name="var" value="purple"/>
			</bind>
		</link>

		<link xconnector="onBeginStart">
			<bind role="onBegin" component="video3"  />
			<bind role="start" component="scentEffect" />
		</link>

		<link xconnector="onEndStop">
			<bind role="onEnd" component="video3" />
			<bind role="stop" component="lightEffect" />
			<bind role="stop" component="audio" />
		</link>

</body>
</ncl>

