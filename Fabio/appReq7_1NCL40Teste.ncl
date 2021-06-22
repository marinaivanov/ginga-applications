<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="aplReq7_1NCLTesteStart" xmlns="http://www.ncl.org.br/NCL4.0/EDTVProfile">
 <head>
	<regionBase>
		<region id="florestaVideoReg" width="100%" height="100%" zIndex = "0" />
	</regionBase>
	<descriptorBase>
	    <descriptor id="florestaVideoRegDesc"  region="florestaVideoReg" />
	</descriptorBase>
	<connectorBase>
       <causalConnector id="onVoiceRecognitionPause">
          <connectorParam name="key"/>
          <simpleCondition role="onVoiceRecognition" key="$key"/>
          <simpleAction role="pause" />
       </causalConnector>  
       <causalConnector id="onVoiceRecognitionResume">
          <connectorParam name="key"/>
          <simpleCondition role="onVoiceRecognition" key="$key"/>
          <simpleAction role="resume" />
       </causalConnector>  
       <causalConnector id="onVoiceRecognitionStop">
          <connectorParam name="key"/>
          <simpleCondition role="onVoiceRecognition" key="$key"/>
          <simpleAction role="stop" />
       </causalConnector>  
	</connectorBase>
  </head>
<body>
		<port id="pVideo" component="florestaVideo" />
		<media id="florestaVideo" src="videos/forest_720.mp4" descriptor="florestaVideoRegDesc"/>
    <link xconnector="onVoiceRecognitionPause">
          <bind role="onVoiceRecognition" component="florestaVideo">
            <bindParam name="key" value="pause"/>
          </bind>
          <bind role="pause" component="florestaVideo"/>
    </link> 
    <link xconnector="onVoiceRecognitionResume">
          <bind role="onVoiceRecognition" component="florestaVideo">
            <bindParam name="key" value="resume"/>
          </bind>
          <bind role="resume" component="florestaVideo"/>
    </link> 
    <link xconnector="onVoiceRecognitionStop">
          <bind role="onVoiceRecognition" component="florestaVideo">
            <bindParam name="key" value="stop"/>
          </bind>
          <bind role="stop" component="florestaVideo"/>
    </link> 
 </body>
</ncl>