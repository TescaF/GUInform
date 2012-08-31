GLK SVG Drawing Commands (for Glulx only) by Tesca Fitzgerald begins here.
"Calls the GLK function to render and display SVG text."

Include (-
[ glk_svg_draw _vararg_count ret;
! glk_svg_draw (window, svg)
  ! And now the @glk call;
  @glk 227 _vararg_count ret;
  return ret;
];

! The following function converts an indexed text into an  
! equivalent GLK C-style string.

! Acknowledgement:
! Functions contributed by user 'EmacsUser' on the intfiction.org forum
! Date: 11/08/2012
! Source: http://www.intfiction.org/forum/viewtopic.php?f=7&t=5518#p40124
[ indexedTextToNewCStyle indexedText
   length bufferByteCount buffer index character;
   length = BlkValueExtent(indexedText);
   bufferByteCount = 4 * (length + 2);
   @malloc bufferByteCount buffer;
   buffer-->0 = $E2000000;
   for (index = 0: index < length: ++index) {
      character = BlkValueRead(indexedText, index);
      buffer-->(index+1) = character;
      if (~~character) break;
   }
   if (index == length) {
      buffer-->(index+1) = 0;
   }
   return buffer;
];

[ drawSVG svgString
    cstring;
    cstring = indexedTextToNewCStyle(svgString);
    glk_svg_draw(gg_mainwin, cstring, 0);
    @mfree cstring;
];
-)
[ End of contributed section ]

To render (rendered text - some indexed text) as SVG:
	(- drawSVG({rendered text}); -)

GLK SVG Drawing Commands ends here.

---- Documentation ----

The SVG Handler extension provides SVG capability for Inform 7. This extension is a simple interface to a GLK function that renders and display SVG text. Any Inform 7 story that uses this extension to render and display SVG should be run on an interpreter that contains this GLK function.

To display SVG, the following syntax is used:

render (indexed text) as SVG.

The indexed text provided to this rule is converted to a GLK c-style string, which can then be used by the GLK function to render the SVG string.

Example:  * Shapes - A simple SVG shape drawing

*: "Shapes"
Include SVG Handler by Tesca Fitzgerald

Section - Demo

There is a room called The Starting Room.

Drawing a circle is an action applying to nothing.  Understand "draw a circle" as drawing a circle. 

Drawing a triangle is an action applying to nothing.  Understand "draw a triangle" as drawing a triangle. 

Carry out drawing a circle: 
	render "<circle cx='40' cy='40' r='40' fill='green' />" as SVG.

Carry out drawing a triangle:
	render "<polygon points='50,10 10,60 90,60' />" as SVG.
	
Test me with "draw a circle / draw a triangle".
