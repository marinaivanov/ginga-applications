<ncl id="App_Targeted_Advertising">
<head>

	<ruleBase>
		<rule id="rWoman" var="profile" comparator="eq" value="woman"/>
		<rule id="rMan" var="profile" comparator="eq" value="man"/>		
	</ruleBase>
	
	<regionBase>
		<region id="rgVideo" width="100%" height="100%"/>
	</regionBase>
	
	<descriptorBase>
		<descriptor id="dVideo" region="rgVideo"/>
		<descriptor id="dAdv" region="rgVideo"/>		
	</descriptorBase>

	<connectorBase>
		<causalConnector id="onBeginAndTestStart">
			<compoundCondition operator="and">
				<simpleCondition role="onBegin" />
				<assessmentStatement comparator="eq">
				<attributeAssessment role="test" 	eventType="preparation"  attributeType="prepared"/>
					<valueAssessment value="true" />
				</assessmentStatement>
			</compoundCondition>
			<simpleAction role="start" />
		</causalConnector>
		<causalConnector id="onBeginStart">
			<simpleCondition role="onBegin"/>
			<simpleAction role="start"/>
		</causalConnector>
		<causalConnector id="onEndStop">
			<simpleCondition role="onEnd" />
			<simpleAction role="stop" />
		</causalConnector>
		<causalConnector id="onBeginSet">
			<connectorParam name="val"/>
			<simpleCondition role="onBegin" />
			<simpleAction role="set" value="$val"/>
		</causalConnector>
		<causalConnector id="onEndSet">
			<connectorParam name="val"/>
			<simpleCondition role="onEnd" />
			<simpleAction role="set" value="$val"/>
		</causalConnector>
	
	</connectorBase>

</head>
<body>
	<port id="pStart" component="mainVideo"/>
	<media id="mainVideo" src="media/stream.mp4" 	descriptor="dVideo">
		<area id="a1" begin="23s" end="53s"/>
		<property name="soundLevel" value="1"/>
		<property name="zIndex" value="0"/>
	</media>
	
	<media id="settings" type="application/x-ginga-settings">
      <property name="profile" value="woman"/>
    </media>
	
	<switch id="switchAdv">
	
		<switchPort id="pWoman">
			<mapping component="adWoman"/>
		</switchPort>
		<switchPort id="pMan">
			<mapping component="adMan"/>
		</switchPort>
	
		<bindRule constituent="adWoman" rule="rWoman"/>
		<bindRule constituent="adMan" rule="rMan"/>
	
		<media id="adWoman" src="media/advertising1.mp4" descriptor="dAdv">
			<property name="zIndex" value="1"/>
		</media>
		
		<media id="adMan" src="media/advertising4.mp4" descriptor="dAdv">
			<property name="zIndex" value="1"/>
		</media>	
	
	</switch>	
	
	<link xconnector="onBeginAndTestStart">
		<bind role="onBegin" component= "mainVideo" interface="a1"/>
		<bind role="test" component="switchAdv" interface="pWoman"/>
		<bind role="start" component="switchAdv"/>
	</link>
	
	<link xconnector="onBeginAndTestStart">
		<bind role="onBegin" component= "mainVideo" interface="a1"/>
		<bind role="test" component="switchAdv" interface="pMan"/>
		<bind role="start" component="switchAdv"/>
	</link>
	
	<!--link xconnector="onBeginStart">
		<bind role="onBegin" component="mainVideo" interface="a1"/>
		<bind role="start" component="switchAdv"/>
	</link-->
	
	<link xconnector="onEndStop">
		<bind role="onEnd" component= "mainVideo" interface="a1"/>
		<bind role="stop" component="switchAdv"/>
	</link>
	
	<link xconnector="onBeginSet">
		<bind role="onBegin" component= "switchAdv"/>
		<bind role="set" component="mainVideo" interface="soundLevel">
			<bindParam name="val" value="0"/>
		</bind>
	</link>
		<link xconnector="onEndSet">
		<bind role="onEnd" component= "switchAdv"/>
		<bind role="set" component="mainVideo"  interface="soundLevel">
			<bindParam name="val" value="1"/>
		</bind>
	</link>

</body>
</ncl>