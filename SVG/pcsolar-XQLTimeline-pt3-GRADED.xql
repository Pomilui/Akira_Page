xquery version "3.1";
(:ebb: I've also saved this file with my comments in your directory on the eXist-db as Mitford_TimelineSVG3.xql :)
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $mitfordColl := collection ('/db/mitford');
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $countLetterFiles := count($letterFiles);
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when;
declare variable $letterYears := $letterDates/tokenize(string(), '-')[1];
declare variable $minLetterYear := xs:integer(min($letterYears));
declare variable $maxLetterYear := xs:integer(max($letterYears));
declare variable $totalLetterYears := $maxLetterYear - $minLetterYear;
declare variable $stretchFactor := 365;
declare variable $HaydonLetters := $lettersColl[descendant::tei:titleStmt/tei:title/tei:persName/@ref="#Haydon"];
declare variable $HaydonDates :=$HaydonLetters//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string();
declare variable $minHaydon := min($HaydonDates);
declare variable $maxHaydon := max($HaydonDates);
declare variable $minHaydonYear := xs:integer(tokenize($minHaydon, '-')[1]);
declare variable $maxHaydonYear := xs:integer(tokenize($maxHaydon, '-')[1]);
declare variable $svgHaydonSpan := ($maxHaydonYear - $minHaydonYear) * 365;
declare variable $svgHaydonMinYearPlot := ($minHaydonYear - $minLetterYear) * 365;
declare variable $svgHaydonMaxYearPlot := ($maxHaydonYear  - $minLetterYear) *365;
declare variable $minHaydonDayAdd := xs:integer(format-date($minHaydon, '[d]'));
declare variable $maxHaydonDayAdd := xs:integer(format-date($maxHaydon, '[d]'));
declare variable $maxHaydonDate := $maxHaydonDayAdd + $svgHaydonMaxYearPlot;
declare variable $minHaydonDate := $minHaydonDayAdd + $svgHaydonMinYearPlot;



 declare variable $ThisFileContent :=  
<svg width="900" height = "{$stretchFactor * $totalLetterYears + 500}">
    <g transform="translate(200, 100)">
      <line x1="50" y1="0" x2="50" y2="{($totalLetterYears * $stretchFactor)}" stroke="#3333ff" stroke-width="3" /> 
      <line x1="200" y1="{$minHaydonDate}" x2="200" y2="{$maxHaydonDate}" stroke="Brown" stroke-width="3" />
     <!--ebb: Nice work with plotting the Haydon line from its earliest to latest date! -->
      <text x="200" y="375" style="font-size: 30px;">Haydon Letters</text>
        <text x="210" y="415">First Letter (2/13/1819)</text><!--The +10 moves the date titles down to be level with the lines.-->
        <text x="210" y="2099">Last Letter (10/1/1823)</text>
         {
         for $i in (0 to $totalLetterYears)
         let $currentYear := $minLetterYear + $i
         let $matchCurrentYear := $letterFiles[contains(descendant::tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string(), $currentYear)]
         (:ebb: This is your "tree-walker" variable, and once we figured this out, you were able to get a count of the letters in a given year. If you wanted to, you could write another variable to find out how many letters to Haydon were written in this current year, or really anything you need from the current year's batch of letters. :)
         let $countCurrentYear := count($matchCurrentYear)
         
         return
             <g>
                 <line x1="40" y1="{$i * $stretchFactor}" x2="60" y2="{$i * $stretchFactor}" stroke="orange" stroke-width="4"/>
                 <text x="100" y="{$i * $stretchFactor}" color="black">{$currentYear}</text>
                 <circle cx="25" cy="{$i * $stretchFactor}" r="{$countCurrentYear * 2}" stroke="Green" fill="darkred" stroke-width="2"/>
 <!--ebb: Great job with the circles. I might want to move the @cx over to the left (decrease it) just a scootch so the largest circles don't overlap your main timeline. But really the output is quite legible and looks great!   -->                                
             
        
        </g>
         }
      
   </g>
   
</svg>; 

   let $filename := "pcsolarTimeline.svg"
let $doc-db-uri := xmldb:store("/db/npp16", $filename, $ThisFileContent)
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/npp16/pcsolarTimeline.svg :) 
(: 2018-04-04 ebb: Excellent work with customizing this timeline assignment. We'll be continuing this exercise as our last JavaScript assignment (and last homework of the term), and you have a great code-base here to start with. (In case you're looking ahead, what we'll do is output more people's timespans of correspondence, and toggle them on or off on click of a selection box.) 
 Score: 10/10
 :  :)