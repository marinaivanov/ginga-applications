<?xml version="1.0" encoding="ISO-8859-1"?>

<ncl id="aplMultiUser" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
	<regionBase>
		<region id="jardimBotanicoImgReg" width="100%" height="100%" zIndex = "0" />
    <region id="jardimBotanicoVideoReg" bottom ="10%" width="50%" height="45%" zIndex = "1"/> 
    <region id="ImgPropagandaReg" right="15%" bottom="40%" width="5%" height="5%" zIndex = "2"/>  
	</regionBase>

  <descriptorBase>
      <descriptor id="jardimBotanicoImgDesc"  region="jardimBotanicoImgReg"/>  
      <descriptor id="jardimBotanicoVideoDesc"  region="jardimBotanicoVideoReg" />
      <descriptor id="ImgPropagandaDesc"  region="ImgPropagandaReg"  />
  </descriptorBase>

  <userBase>
      <userAgent id="user1" src="usr1.xml"/>
      <userAgent id="user2" src="usr2.xml"/>
  </userBase>
	
	<connectorBase>

       <causalConnector id="onBeginStart">
          <simpleCondition role="onBegin"/>
          <simpleAction role="start" max = "unbounded"/>
       </causalConnector> 

       <causalConnector id="onSelectionSet">
          <connectorParam name="val"/>
          <simpleCondition role="onSelection"/>
          <simpleAction role="set" value="$var" />
       </causalConnector>  

       <causalConnector id="onVoiceRecognitionTestSet">
          <connectorParam name="key"/>
          <connectorParam name="user"/>      
          <connectorParam name="val"/>
          <connectorParam name="var"/>

          <compoundCondition operator="and">
            <simpleCondition role="onVoiceRecognition" key="$key" user = "$user"/>
            <assessmentStatement comparator="eq">
              <attributeAssessment role="attNodeTest" eventType="attribution" attributeType="nodeProperty"/>
              <valueAssessment value="$val"/>
            </assessmentStatement>
          </compoundCondition>
          <simpleAction role="set" value="$var" />
       </causalConnector>  


      <causalConnector id="onBeginTestStart">      
        <connectorParam name="val"/>

        <compoundCondition operator="and">
          <simpleCondition role="onBegin"/>        
          <assessmentStatement comparator="eq">
              <attributeAssessment role="attNodeTest" eventType="attribution" attributeType="nodeProperty"/>
              <valueAssessment value="$val"/>
          </assessmentStatement>
        </compoundCondition>

        <simpleAction role="start"/>
      </causalConnector>    
	</connectorBase>
  </head>
<body>

		<port id="pVideo" component="botanicalGardenImage" />

		<media id="botanicalGardenImage" src="images/jardimBotanico.jpg" descriptor="jardimBotanicoImgDesc"/>

    <media id="ImgPropaganda" src="images/blusaMasc.jpg" descriptor="ImgPropagandaDesc">
	        <property name="selecionado" value = "não"/>              
    </media >

    <media id="jardimBotanicoVideo" src="videos/JardimBotanico.mp4" descriptor="jardimBotanicoVideoDesc">
      <area id="aPropaganda" begin="2s" /> 
    </media>

    <media id="user1Set" type= "application/x-ginga-user-settings" user = "user1">
        <property name="propaganda" value = ""/>        
        <property name="compra" value = ""/>        
    </media >

    <media id="user2Set" type= "application/x-ginga-user-settings" user = "user2">
        <property name="propaganda" value = ""/>        
        <property name="compra" value = ""/>        
    </media >

  
    <link xconnector="onBeginStart">
          <bind role="onBegin" component="botanicalGardenImage" />
          <bind role="start" component="jardimBotanicoVideo"/>
    </link> 

    <link xconnector="onSelectionSet">
      <bind role="onSelection" component="ImgPropaganda"/>
      <bind role="set" component="ImgPropaganda" interface="selecionado"/>
    </link>

    <link xconnector="onBeginTestStart">
      <bind role="onBegin" component="jardimBotanicoVideo" interface="aPropaganda"/>
      <bind role="attNodeTest" component="user1Set" interface="propaganda">
        <bindParam name="val" value="sim"/>
      </bind>  
     <bind role="start" component="ImgPropaganda"/>
    </link>
    
    <link xconnector="onBeginTestStart">
      <bind role="onBegin" component="jardimBotanicoVideo" interface="aPropaganda"/>
      <bind role="attNodeTest" component="user2Set" interface="propaganda">
        <bindParam name="val" value="sim"/>
      </bind>  
     <bind role="start" component="ImgPropaganda"/>
    </link>

    <link xconnector="onVoiceRecognitionTestSet">
      <bind role="onVoiceRecognition" component="ImgPropaganda">
          <bindParam name="key" value="buy"/>
          <bindParam name="user" value="user1"/>
      </bind>
      <bind role="attNodeTest" component="ImgPropaganda" interface="selecionado">
        <bindParam name="val" value="sim"/>
      </bind>    
      <bind role="set" component="user1set" interface="compra">
        <bindParam name="var" value="blusa"/>
      </bind> 
    </link>

    <link xconnector="onVoiceRecognitionTestSet">
      <bind role="onVoiceRecognition" component="ImgPropaganda">
          <bindParam name="key" value="buy"/>
          <bindParam name="user" value="user2"/>
      </bind>
      <bind role="attNodeTest" component="ImgPropaganda" interface="selecionado">
        <bindParam name="val" value="sim"/>
      </bind>    
      <bind role="set" component="user1Set" interface="compra">
        <bindParam name="var" value="blusa"/>
      </bind> 
    </link>
</body>
</ncl>