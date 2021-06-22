<?xml version="1.0" encoding="ISO-8859-1"?>

<ncl id="aplMultiUser" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
...

  <userBase>
      <userProfile id="profile1" src="kfld.xml"/>

      <userAgent id="all" profile = "profile1"/>
  </userBase>
	
	<connectorBase>
 
 ...

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

    <media id="ProfileSet" type= "application/x-ginga-user-settings" user = "profile1">
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
      <bind role="attNodeTest" component="idPerfil" interface="propaganda">
        <bindParam name="val" value="sim"/>
      </bind>  
     <bind role="start" component="ImgPropaganda"/>
    </link>

    <link xconnector="onVoiceRecognitionTestStart">
      <bind role="onVoiceRecognition" component="ImgPropaganda">
          <bindParam name="key" value="buy"/>
          <bindParam name="user" value="any"/>
      </bind>
      <bind role="attNodeTest" component="ImgPropaganda" interface="selecionado">
        <bindParam name="val" value="sim"/>
      </bind>    
      <bind role="set" component="any" interface="compra">
        <bindParam name="var" value="blusa"/>
      </bind> 
    </link>

...
</body>
</ncl>