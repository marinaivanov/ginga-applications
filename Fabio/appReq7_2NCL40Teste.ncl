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
       <causalConnector id="onHandPoseRecognitionPause">
          <connectorParam name="key"/>
          <connectorParam name="user"/>      
          <simpleCondition role="onHandPoseRecognition" key="$key" user = "$user"/>
          <simpleAction role="pause" />
       </causalConnector>  

       <causalConnector id="onHandPoseRecognitionResume">
          <connectorParam name="key"/>
          <connectorParam name="user"/>      
          <simpleCondition role="onHandPoseRecognition" key="$key" user = "$user"/>
          <simpleAction role="resume" />
       </causalConnector>  

       <causalConnector id="onHandPoseRecognitionStop">
          <connectorParam name="key"/>
          <connectorParam name="user"/>      
          <simpleCondition role="onHandPoseRecognition" key="$key" user = "$user"/>
          <simpleAction role="stop" />
       </causalConnector>  

  </connectorBase>
</head>

<body>

    <port id="pVideo" component="florestaVideo" />
  
    <media id="florestaVideo" src="videos/forest_720.mp4" descriptor="florestaVideoRegDesc"/>

    <link xconnector="onHandPoseRecognitionPause">
          <bind role="onHandPoseRecognition" component="florestaVideo">
            <bindParam name="key" value="pause"/>
          </bind>
          <bind role="pause" component="florestaVideo"/>
    </link> 
    <link xconnector="onHandPoseRecognitionResume">
          <bind role="onHandPoseRecognition" component="florestaVideo">
            <bindParam name="key" value="resume"/>
          </bind>
          <bind role="resume" component="florestaVideo"/>
    </link> 
    <link xconnector="onHandPoseRecognitionStop">
          <bind role="onHandPoseRecognition" component="florestaVideo">
            <bindParam name="key" value="stop"/>
          </bind>
          <bind role="stop" component="florestaVideo"/>
    </link> 
 </body>
</ncl>