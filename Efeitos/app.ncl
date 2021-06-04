<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="aplTesteEffect" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
	<regionBase>
		<region id="rg1" width="100%" height="100%" zIndex = "0" />
		<region id="rg2" location="center:top:front" />

   	</regionBase>

	<descriptorBase>
	    <descriptor id="desc1"  region="rg1" explicitDur="22s"/> 
		<descriptor id="desc2"  region="rg2" intensityValue="10" intensityRange="[0,10]" scent="Sea"/>
	</descriptorBase>
	
	<connectorBase>

	<causalConnector id="onBeginStart">
		<simpleCondition role="onBegin" />
		<simpleAction role="start" max="unbounded"/>
	</causalConnector>

	<causalConnector id="onEndStop">
		<simpleCondition role="onEnd" />
		<simpleAction role="stop" max="unbounded"/>
	</causalConnector>
	

	</connectorBase>
  </head>

  <body>
  	
		<port id="pVideo" component="video1" />

		<media id="video1" src="media/mata.jpg" descriptor="desc1">
			<area id="a1" begin="18s" end="20s"/>
		</media>
		<effect id="scentEffect" type="ScentType" descriptor="desc2"/>
	
		<link xconnector="onBeginStart">
			<bind role="onBegin" component="video1" interface="a1" />
			<bind role="start" component="scentEffect" />
		</link>
	
		<link xconnector="onEndStop">
			<bind role="onEnd" component="video1" />
			<bind role="stop" component="scentEffect" />
		</link>
		
</body>
</ncl>

