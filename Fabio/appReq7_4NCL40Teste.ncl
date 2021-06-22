<?xml version="1.0" encoding="ISO-8859-1"?>

<ncl id="aplReq7_4NCLTesteStart" xmlns="http://www.ncl.org.br/NCL4.0/EDTVProfile">
 <head>
	<regionBase>
    <region id="backReg" width="100%" height="100%" zIndex = "0" />
    <region id="florestaVideoReg" width="100%" height="100%" zIndex = "1" />
    <region id="btnFlorestReg" bottom="5%" left="5%"  width="20%" height="20%" zIndex = "2" />
    <region id="btnAutumnReg"  bottom="5%" left="30%" width="20%" height="20%" zIndex = "2" />
    <region id="btnSnowReg"    bottom="5%" left="55%" width="20%" height="20%" zIndex = "2" />
	</regionBase>

	<descriptorBase>
      <descriptor id="backDesc"  region="backReg"/>
      <descriptor id="florestaVideoRegDesc"  region="florestaVideoReg"/>
      <descriptor id="btnFlorestDesc" region="btnFlorestReg" focusIndex="0" moveUp="2" moveDown="1" moveLeft="2" moveRight="1" focusBorderColor="yellow" focusBorderWidth="2" />
      <descriptor id="btnAutumnDesc" region="btnAutumnReg" focusIndex="1" moveUp="0" moveDown="2" moveLeft="0" moveRight="2" focusBorderColor="yellow" focusBorderWidth="2"/>
      <descriptor id="btnSnowDesc" region="btnSnowReg"    focusIndex="2" moveUp="1" moveDown="0" moveLeft="1" moveRight="0" focusBorderColor="yellow" focusBorderWidth="2" />
	</descriptorBase>
	
	<connectorBase>
       <causalConnector id="onVoiceRecognitionStart">
          <connectorParam name="key"/>
          <connectorParam name="user"/>      
          <simpleCondition role="onVoiceRecognition" key="$key" user = "$user"/>
          <simpleAction role="start" max = "unbounded"/>
       </causalConnector>  

       <causalConnector id="onBeginStart">
          <simpleCondition role="onBegin"/>
          <simpleAction role="start" max = "unbounded"/>
       </causalConnector>  
       <causalConnector id="onSelectionStartStop">
          <simpleCondition role="onSelection"/>
          <compoundAction operator="seq">
              <simpleAction role="start" max = "unbounded"/>
              <simpleAction role="stop" max = "unbounded"/>
          </compoundAction>
       </causalConnector>  

       <causalConnector id="onBeginStop">
          <simpleCondition role="onBegin"/>
          <simpleAction role="stop" max = "unbounded"/>
       </causalConnector>  
	 </connectorBase>
</head>
<body>

		<port id="pBack" component="back" />
	
    <media id="back" src="images/blue.jpg" descriptor="backDesc"/>

    <media id="florestVideo" src="videos/forest_720.mp4" descriptor="florestaVideoRegDesc"/>
    <media id="autumnVideo" src="videos/autumn_720.mp4" descriptor="florestaVideoRegDesc"/>
    <media id="snowVideo" src="videos/snow_720.mp4" descriptor="florestaVideoRegDesc"/>

    <media id="btnFlorestVideo" src="images/florest.png" descriptor="btnFlorestDesc"/>
    <media id="btnAutumnVideo" src="images/autumn.png" descriptor="btnAutumnDesc"/>
    <media id="btnSnowVideo" src="images/snow.png" descriptor="btnSnowDesc"/>

    <link xconnector="onBeginStart">
          <bind role="onBegin" component="back"/>
          <bind role="start" component="btnFlorestVideo"/>
          <bind role="start" component="btnAutumnVideo"/>
          <bind role="start" component="btnSnowVideo"/>
    </link> 
    <link xconnector="onBeginStop">
          <bind role="onBegin" component="florestVideo"/>
          <bind role="stop" component="btnFlorestVideo"/>
          <bind role="stop" component="btnAutumnVideo"/>
          <bind role="stop" component="btnSnowVideo"/>
    </link> 
   <link xconnector="onBeginStop">
          <bind role="onBegin" component="autumnVideo"/>
          <bind role="stop" component="btnFlorestVideo"/>
          <bind role="stop" component="btnAutumnVideo"/>
          <bind role="stop" component="btnSnowVideo"/>
    </link> 
   <link xconnector="onBeginStop">
          <bind role="onBegin" component="snowVideo"/>
          <bind role="stop" component="btnFlorestVideo"/>
          <bind role="stop" component="btnAutumnVideo"/>
          <bind role="stop" component="btnSnowVideo"/>
    </link> 
    <link xconnector="onSelectionStartStop">
      <bind role="onSelection" component="btnSnowVideo"/>
      <bind role="start" component="snowVideo"/>
      <bind role="stop" component="autumnVideo"/>
      <bind role="stop" component="florestVideo"/>
    </link> 
    <link xconnector="onSelectionStartStop">
      <bind role="onSelection" component="btnFlorestVideo"/>
      <bind role="start" component="florestVideo"/>
      <bind role="stop" component="autumnVideo"/>
      <bind role="stop" component="snowVideo"/>
    </link> 
    <link xconnector="onSelectionStartStop">
      <bind role="onSelection" component="btnAutumnVideo"/>
      <bind role="start" component="autumnVideo"/>
      <bind role="stop" component="snowVideo"/>
      <bind role="stop" component="florestVideo"/>
    </link>  
 
    <link xconnector="onVoiceRecognitionStart">
          <bind role="onVoiceRecognition" component="back">
            <bindParam name="key" value="trocar"/>
          </bind>
          <bind role="start" component="btnFlorestVideo"/>
          <bind role="start" component="btnAutumnVideo"/>
          <bind role="start" component="btnSnowVideo"/>
    </link> 
 
 </body>
</ncl>