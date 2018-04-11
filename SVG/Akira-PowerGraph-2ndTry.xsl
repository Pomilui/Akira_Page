xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $AkiraFile := doc('/db/akira/akira-tei.xml');
declare variable $AkiraAll := $AkiraFile/*;
declare variable $allPowers := $AkiraAll//tei:text//tei:body//tei:milestone[@type="powers"];
declare variable $allControlScene := $AkiraAll//tei:text//tei:body//tei:spGrp/@controlScene;
declare variable $whoPowers := $allPowers/@who/string();
declare variable $distinctPowers := distinct-values($whoPowers);
declare variable $heightStretchFactor := 10;
declare variable $xStretchFactor := 100;

declare variable $ThisFileContent :=
<svg width="1200" height="900">
    <g transform="translate(200, 500)">
        <!--ebb: We've set transform="translate()" on the svg element above so you can plot the graph from 0,0. That makes it a lot easier to plot the SVG shapes, but it means that values above the X axis have to climb UP the screen from zero to negative numbers. The line below is the X axis, and we're setting it to start at 0,0 -->
        <line x1="0" y1="0" x2="810" y2="0" stroke="red" stroke-width="8"/>
        <!--The line below is the Y axis, and it, too, starts at 0,0 -->
        <line x1="0" y1="0" x2="0" y2="-500" stroke="red" stroke-width="8"/>
        
        <text x="375" y="75" fill="Black">Characters</text>
        <text x="-150" y="-350" fill="black">Number of Times 
            <tspan x="-150" y="-325">Powers Are Used</tspan>
        </text>
        <text x="400" y="-400" fill="Black">Power Usage</text>
        
        
        
        <!--ebb: I remembered what we have to do to sort your bars! We need to sort the values based on their associated counts BEFORE we start using the $pos variable. I've done this by creating a new variable, $sortedPowers, that contains its own for-loop, and outputs the powernames in descending order. Then they are all available in sorted form in the loop we use to plot the graph parts. Note that the $treeMatch and $count variables aren't available in the other for loop: they go away once their loop is complete and the values all sorted. They're exactly the same values, though, that we see in the other loop. -->     
        {let $sortedPowers := 
        for $i in $distinctPowers
        let $treeMatch := $AkiraAll//tei:text//tei:body//tei:milestone[@who=[$i]]
        let $count := count($treeMatch)
        order by $count descending (:this would sort it from highest to lowest:)
        return $i
        for $i at $pos in $sortedPowers
        let $treeWalkerMatch := $AkiraAll//tei:text//tei:body//tei:milestone[@who=[$i]]
        let $count := count($treeWalkerMatch)
        return
        
        <g>
            <rect x="{($pos * $xStretchFactor)}" y="{-($count * $heightStretchFactor)}" width="50" height="{$count * $heightStretchFactor}" fill="hsl(358, {$count * 10}%, 30%)"/> 
            <text x="{($pos * $xStretchFactor)}" y="27" >{$i}{$treeWalkerMatch}({$count})</text>
            
        </g>
        }
        
    </g>
</svg>;


let $filename := "pcsolar-AkiraPowerGraph2.svg"
let $doc-db-uri := xmldb:store("/db/npp16", $filename, $ThisFileContent)
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/npp16/pcsolar-AkiraPowerGraph2.svg :) 
(: ebb: Preliminary Score: 8/10 because this is a bit too easy. I'd like you to Revise and Resubmit this as a FLWOR looping through all of your power characters to retrieve counts and order them. Instead of choosing a different color for each bar, you *could* vary the saturation a single color based on the count (as posted on DHClass-Hub).  :)
