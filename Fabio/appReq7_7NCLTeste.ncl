<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="aplMultiUser" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
<head>
  <regionBase>
    <region id="VideoReg" width="100%" height="100%" zIndex = "0" />
    <region id="ImgPropagandaReg" right="5%" bottom="5%" width="20%" height="20%" zIndex = "2"/>  
    <region id="rg1" left="5%" bottom="5%" height="10%"  width="50%" />
  </regionBase>

  <descriptorBase>
      <descriptor id="VideoDesc"  region="VideoReg"/>  
      <descriptor id="ImgPropagandaDesc"  region="ImgPropagandaReg"  />
      <descriptor id="desc1"  region="rg1"/> 
  </descriptorBase>

  <userBase>
      <userProfile id="profile1" src="profiles/profile.xml"/>
  </userBase>

  <connectorBase>

      <causalConnector id="onBeginStart">
        <simpleCondition role="onBegin"/>
        <simpleAction role="start" max = "unbounded"/>
      </causalConnector> 
   
      <causalConnector id="onVoiceRecognitionSet">
        <connectorParam name="key"/>
        <connectorParam name="user"/>      
        <connectorParam name="var"/>      
        <simpleCondition role="onVoiceRecognition" key="$key" user = "$user"/>
        <simpleAction role="set" value="$var"/>
      </causalConnector>

  </connectorBase>

</head>
<body>
    <port id="pInicio" component="lua" />
    <port id="pVideo" component="snowVideo"/>

    <media id="lua" src="scripts/script.lua" type= "application/x-ginga-NCLua" descriptor="desc1">
      <property name="usr" value="false"/>
    </media>

    <media id="ImgPropaganda" src="images/mochila.jpeg" descriptor="ImgPropagandaDesc">
      <property name="usr" value="false"/>
    </media>

    <media id="snowVideo" src="videos/snow_720.mp4" descriptor="VideoDesc">
      <property name="usr" value="false"/>
      <area id="aPropaganda" begin="2s" /> 
    </media>

    <link xconnector="onBeginStart">
        <bind role="onBegin" component="snowVideo" interface="aPropaganda"/>
        <bind role="start" component="ImgPropaganda"/>
    </link>

    <link xconnector="onVoiceRecognitionSet">
      <bind role="onVoiceRecognition" component="ImgPropaganda">
          <bindParam name="key" value="buy"/>
          <bindParam name="user" value="profile1"/>
      </bind> 
      <bind role="getValue" component="ImgPropaganda" interface="usr"/>
        <bind role="set" component="lua" interface="usr">
            <bindParam name="var" value="$getValue"/>
        </bind>
    </link>

</body>
</ncl>