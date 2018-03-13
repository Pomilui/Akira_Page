<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="text"/>
    
    <xsl:template match="teiHeader//particDesc//listPerson">
        <xsl:for-each select="person">
            <xsl:value-of select="@xml:id"/>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
        
    </xsl:template>

    
</xsl:stylesheet>