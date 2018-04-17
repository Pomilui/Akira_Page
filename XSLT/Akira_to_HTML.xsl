<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
   
    <xsl:template match="/">
        <html>
            <head>
                <title>Akira</title>
               
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="styling.css"/>
                <script type="text/javascript" src="checkBox.js">/**/</script>
                
            </head>
            <body>
                <div id="scriptbody">
                <h1><xsl:apply-templates select="descendant::teiHeader//title"/></h1>
                <h2>Cast of Characters in Speaking Order</h2>  
                    <br />
                    <div class="flex-container">
                        <div class="space"></div>
                        <div class="toggle">
                            <fieldset>
                                <legend>Click to Highlight</legend>
                                <input type="checkbox" id="persNameToggle" />
                                <span class="persNameToggle">Control Scenes</span>
                                <input type="checkbox" id="locToggle" />
                                <span class="locToggle">Usage of Powers</span>
                                <input type="checkbox" id="currentToggle" />
                                <span class="currentToggle">Notes</span>
                                <input type="checkbox" id="dateToggle" />
                                <span class="dateToggle">GIFs</span>
                            </fieldset>
                        </div>
                    </div>
                    <br/>
                    <br/>
                   
                <table id="test">
                    <tr>
                        <th>ID</th><th>Name</th><th>Speaking Order with Line #</th>
                    </tr>
                    <xsl:apply-templates select="descendant::person">
                        <xsl:sort select="number((//sp[substring-after(@who, '#') = current()/@xml:id])[1]/@n)" order="ascending"/>
                    </xsl:apply-templates>
                    
                </table>
                    <br/>
                    <br/>
                    <hr/>
                    <br/>
                    <br/>
   
<h2>Akira Script</h2>   
   <xsl:apply-templates select="descendant::body"/>
                </div>  
            </body>
        </html>
    </xsl:template>
   
    <xsl:template match="person">
        <xsl:if test="//sp[substring-after(@who, '#') = current()/@xml:id]">
            <xsl:variable name="firstSpeechNum" select="(//sp[substring-after(@who, '#') = current()/@xml:id])[1]/@n"/>
            <tr>
            <td><xsl:apply-templates select="@xml:id"/></td>
            <td><xsl:apply-templates select="child::persName[1]"/></td>
            <td><a href="#{@xml:id}_{$firstSpeechNum}"><xsl:text>Line </xsl:text><xsl:apply-templates select="$firstSpeechNum"/></a></td>
        </tr>  </xsl:if>  
        
    </xsl:template>
    <xsl:template match="spGrp">
        <div class="spGrp">
            <xsl:apply-templates/>
            
        </div>
    </xsl:template>
   
    
    
    
        <xsl:template match="sp">

               <div class="sp" id="{string-join(for $i in tokenize(@who, ' ') return substring-after($i, '#'), '_')}_{@n}">     
                   <span class="speaker"><xsl:apply-templates select="substring-after(@who, '#')"/> </span>  
                   <p><xsl:apply-templates/></p>
               </div>
            
    </xsl:template>
        
        <xsl:template match="milestone">
           <!-- <span class="noteNum"><xsl:value-of select="count(preceding::note) + 1"/>-->
                <span title="{substring-after(@who, '#')}" class="note"><xsl:apply-templates select ="following-sibling::note[1]" mode="notes"/></span>
               <!-- </span>-->
             
        </xsl:template>
        
<xsl:template match="note"/>


    
    
</xsl:stylesheet>