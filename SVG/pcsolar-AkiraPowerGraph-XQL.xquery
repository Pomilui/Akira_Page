xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $AkiraFile := doc('/db/akira/akira-tei.xml');
declare variable $AkiraAll := $AkiraFile/*;
declare variable $allPowers := $AkiraAll//tei:text//tei:body//tei:milestone[@type="powers"];
declare variable $allControlScene := $AkiraAll//tei:text//tei:body//tei:spGrp/@controlScene;
declare variable $whoPowers := $allPowers/@who/string();

declare variable $tetsuoPowers := count($allPowers[@who="#tetsuo"]);
declare variable $takashiPowers := count($allPowers[@who="#takashi"]);
declare variable $masaruPowers := count($allPowers[@who="#masaru"]);
declare variable $kiyokoPowers := count($allPowers[@who="#kiyoko"]);
declare variable $keiPowers := count($allPowers[@who="#kei"]);
declare variable $akiraPowers := count($allPowers[@who="#akira"]);
declare variable $stretchFactor := 10;

declare variable $ThisFileContent :=
<svg width="1200" height="900">
    <g transform="translate(200, 100)">
        <line x1="200" y1="500" x2="810" y2="500" stroke="black" stroke-width="8"/>
        <line x1="200" y1="504" x2="200" y2="50" stroke="black" stroke-width="8"/>
        <rect x="250" y="426" width="50" height="{$takashiPowers * $stretchFactor}" style="fill:green; stroke:black;"/>
        <text x="250" y="375" fill="green">Takashi 
            <tspan x="275" y="400">7</tspan></text>
        <rect x="350" y="126" width="50" height="{$tetsuoPowers * $stretchFactor}" style="fill:Red; stroke:black;"/>
        <text x="350" y="90" fill="red">Tetsuo 
            <tspan x="365" y="110">37</tspan></text>
        <rect x="450" y="456" width="50" height="{$masaruPowers * $stretchFactor}" style="fill:blue; stroke:black;"/>
        <text x="450" y="425" fill="blue">Masaru 
            <tspan x="466" y="445">4</tspan></text>
        <rect x="550" y="416" width="50" height="{$kiyokoPowers * $stretchFactor}" style="fill:pink; stroke:black;"/>
        <text x="550" y="375" fill="pink">Kiyoko 
            <tspan x="565" y="395">8</tspan></text>
        <rect x="650" y="466" width="50" height="{$keiPowers * $stretchFactor}" style="fill:gold; stroke:black;"/>
        <text x="653" y="435" fill="gold">Kei
            <tspan x="660" y="455">3</tspan></text>
        <rect x="750" y="486" width="50" height="{$akiraPowers * $stretchFactor}" style="fill:white; stroke:black;"/>
        <text x="750" y="450" fill="black">Akira 
            <tspan x="765" y="470">1</tspan></text>
        
        <text x="450" y="530" fill="Black">Characters</text>
        <text x="50" y="275" fill="black">Number of Times 
            <tspan x="50" y="300">Powers Are Used</tspan></text>
        <text x="450" y="50" fill="Black">Power Usage</text>
    </g>
</svg>;


let $filename := "pcsolar-AkiraPowerGraph.svg"
let $doc-db-uri := xmldb:store("/db/npp16", $filename, $ThisFileContent)
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/npp16/pcsolar-AkiraPowerGraph.svg :) 