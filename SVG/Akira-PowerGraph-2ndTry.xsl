xquery version "3.1";
(:2018-04-08 ebb: Nick-- I'd like you to redo this one so it uses a FLWOR to loop through EACH of your superpower characters instead of hand-selecting them.  :)
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
(:ebb: It seems kind of arbitrary to choose specific characters, and it adds a lot of "code bloat". I'd like you to REVISE this XQuery, and try writing a FLWOR down inside your <svg> output, a FLWOR that looks at all the distinct super-power characters in your $whoPowers variable--that is, loops through them based on their distinct-values(). For $i in each distinct-values($whoPowers), go back to the tree and get a count() of how many times that powerful character is marked in a milestone. Then, you can return the counts and test them to make sure they're working. When you know they are outputting what you want, set the "o" of your FLWOR to "order by $yourCountVariable descending. You can read out the counts and make a decision to cut off drawing a plot for characters below a certain count, or just output them all! You could use a "where" statement to indicate your cutoff point, maybe only return results where $countVariable gt 5 . Most likely you'd just plot the bars all the same color, but you *could* set them to vary on one color's saturation: see my post on the DHClass-Hub today about that: https://github.com/ebeshero/DHClass-Hub/issues/482.  Give it a try?  You can use the same FLWOR return to give you regular text labels of each superpower character' s name using a variable instead of writing it in. See if you can rewrite this XQuery to make it work better with variables and in fewer lines of code.  :)
    declare variable $stretchFactor := 10;
    
    declare variable $ThisFileContent :=
    <svg width="1200" height="900">
        <g transform="translate(200, 100)">
            <line x1="200" y1="500" x2="810" y2="500" stroke="black" stroke-width="8"/>
            <line x1="200" y1="504" x2="200" y2="50" stroke="black" stroke-width="8"/>
            
            <!--ebb: Here, instead of just outputting each SVG element "by hand", I recommend setting a FLWOR and have it return just a rect and text element (anything else you need for one unit) inside a <g> element for a given superpower character. 
    {for $i in distinct-values($whoPowers)
    let $treeWalkerMatch := (find it on the XML tree milestone elements)
    let $count := count($treeWalkerMatch)
    order by $count descending (:this would sort it from highest to lowest:)
    return
        <g>
            <rect /> 
            <text>{$i}</text>
         </g>
        
    }
    
    -->
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
    (: ebb: Preliminary Score: 8/10 because this is a bit too easy. I'd like you to Revise and Resubmit this as a FLWOR looping through all of your power characters to retrieve counts and order them. Instead of choosing a different color for each bar, you *could* vary the saturation a single color based on the count (as posted on DHClass-Hub).  :)