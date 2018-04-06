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
                <link rel="stylesheet" type="text/css" href="akira.css"/>  
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::teiHeader//title"/></h1>
              <h2>Cast of Characters in Speaking Order</h2>  
    <table>
        <tr>
            <th>ID</th><th>Name</th>
        </tr>
        <xsl:apply-templates select="descendant::person">
            <xsl:sort select="number((//sp[substring-after(@who, '#') = current()/@xml:id])[1]/@n)" order="ascending"/>
        </xsl:apply-templates>
        
    </table>
</body>
        </html>
    </xsl:template>
    
    <xsl:template match="person">
        <xsl:if test="//sp[substring-after(@who, '#') = current()/@xml:id]"> <tr>
            <td><xsl:apply-templates select="@xml:id"/></td>
            <td><xsl:apply-templates select="child::persName[1]"/></td>
            <td><xsl:apply-templates select="(//sp[substring-after(@who, '#') = current()/@xml:id])[1]/@n"/></td>
        </tr>  </xsl:if>  
        
    </xsl:template>
    
   
    <xsl:template match="spGrp">
        <div class="spGrp">
            <xsl:apply-templates/>
            
        </div>
    </xsl:template>
    
    <xsl:template match="sp">
        
        <div class="sp">     <strong><xsl:apply-templates select="@who"/> </strong>  
            <p><xsl:apply-templates/></p>
        </div>
        
    </xsl:template>
    
    
    
    
</xsl:stylesheet>