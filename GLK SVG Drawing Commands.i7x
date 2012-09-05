GLK SVG Drawing Commands (for Glulx only) by Tesca Fitzgerald begins here.
"Calls the GLK function to render SVG strings and display the resulting images."

Use maximum indexed text length of at least 5000.

The group count is a number that varies.
The group count is 0.

The group text is a indexed text that varies.
The group text is "".

Include (-
[ glk_svg_draw _vararg_count ret;
! glk_svg_draw (window, svg, alignment_x, alignment_y)
  ! And now the @glk call;
  @glk 227 _vararg_count ret;
  return ret;
];

[ glk_svg_draw_scaled _vararg_count ret align_x;
! glk_svg_draw_scaled (window, svg, alignment_x, alignment_y, width, height)
  ! And now the @glk call;
  @glk 228 _vararg_count align_x;
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

[ drawSVG svgString alignment
    cstring;
    cstring = indexedTextToNewCStyle(svgString);
    glk_svg_draw(gg_mainwin, cstring, alignment, 0);
    @mfree cstring;
];
-).
[ End of contributed section ]

To render (svg - some indexed text) as SVG:
	if the group count is 0:
		display svg as SVG;
	otherwise:
		now group text is "[group text][svg]".
				
To start a/-- SVG group:
	if the group count is 0:
		now the group text is "";
	now the group text is "[group text]<g>";
	now the group count is (group count plus 1).
	
To end a/-- SVG group:
	now the group count is (group count minus 1);
	now the group text is "[group text]</g>";
	if the group count is 0:
		render "[group text]" as SVG;
		now the group text is "";

To display (render text - some indexed text) as SVG:
	(- drawSVG({render text}, 0); -)

To display (render text - some indexed text) as SVG with alignment (align - some text):
	(- drawSVG({render text}, {align}); -)

To render/draw a/-- custom SVG element (svg - a text):
	render "'[svg]'" as SVG.
	
Section - Rectangle

To draw a SVG rectangle of dimension (width - a number) by (height - a number) at position (x - a number) by (y - a number ):
	render "<rect width='[width]' height='[height]' x='[x]' y='[y]'/>" as SVG.
	
To draw a SVG rectangle of dimension (width - a number) by (height - a number) at position (x - a number) by (y - a number ) and text (t - a text):
	render "<rect width='[width]' height='[height]' x='[x]' y='[y]'/>" as SVG.
	
To draw a SVG circle of radius (r - a number) at position (x - a number) by (y - a number ):
	render "<circle cx='[x]' cy='[y]' r='[r]'/>" as SVG.

Chapter - Rectangles

To draw/display a/-- rectangle/rect colored (color - a text) at (x - a number) by/x (y - a number) with size/dimensions (width - a number) by/x (height - a number):
	render "<rect width='[width]' height='[height]' x='[x]' y='[y]' style='fill:[color];'/>" as SVG.

To draw/display a/-- rectangle/rect colored (color - a text) at (coordinates - a list of numbers) with size/dimensions (width - a number) by/x (height - a number):
	let x be entry 1 of coordinates;
	let y be entry 2 of coordinates;
	draw a rectangle colored (color) at (x) by (y) with size (width) by (height);

Chapter - Polygons

Section - Triangle

To draw/display a/-- stroked triangle colored (color - a text) at (x1 - a number) by/x (y1 - a number) to (x2 - a number) by/x (y2 - a number) to (x3 - a number) by/x (y3 - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke:
	render "<polygon points='[x1],[y1] [x2],[y2] [x3],[y3]' style='fill:[color];stroke:black;stroke-width:[borderw]' />" as SVG.

Chapter - Outlined rectangles

Section - Box

To draw/display a/-- stroked rectangle colored (color - a text) at (x - a number) by/x (y - a number) with size/dimensions (width - a number) by/x (height - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke colored (borderc - a text):
	render "<rect width='[width]' height='[height]' x='[x]' y='[y]' style='fill:[color];stroke:[borderc];stroke-width:[borderw];'/>" as SVG.
		
To draw/display a/-- stroked rectangle colored (color - a text) at (x - a number) by/x (y - a number) with size/dimensions (width - a number) by/x (height - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke:
	render "<rect width='[width]' height='[height]' x='[x]' y='[y]' style='fill:[color];stroke:black;stroke-width:[borderw];'/>" as SVG.
	
To draw/display a/-- stroked rectangle colored (color - a text) at (coordinates - a list of numbers) with size/dimensions (width - a number) by/x (height - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke colored (borderc - a text):
	let x be entry 1 of coordinates;
	let y be entry 2 of coordinates;
	draw a stroked rectangle colored (color) at (x) by (y) with size (width) by (height) with a (borderw) pixel stroke colored (borderc);

To draw/display a/-- stroked rectangle colored (color - a text) at (coordinates - a list of numbers) with size/dimensions (width - a number) by/x (height - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke:
	let x be entry 1 of coordinates;
	let y be entry 2 of coordinates;
	draw a stroked rectangle colored (color) at (x) by (y) with size (width) by (height) with a (borderw) pixel stroke;
				
Chapter - Text

To draw/display a/-- text (txt - a text) colored (color - a text) at (x - a number) by/x (y - a number):
	render "<text x='[x]' y='[y]' fill='[color]'>[txt]</text>" as SVG.

To draw/display a/-- number (num - a number) colored (color - a text) at (x - a number) by/x (y - a number):
	render "<text x='[x]' y='[y]' fill='[color]'>[num]</text>" as SVG.
	
Chapter - Ellipses

To draw a/-- circle colored (color - a text) at (x - a number) by/x (y - a number) with radius/size (r - a number):
	render "<circle cx='[x]' cy='[y]' r='[r]' fill='[color]'/>" as SVG.

To draw a/-- circle colored (color - a text) at (x - a number) by/x (y - a number) with radius/size (r - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke colored (borderc - a text):
	render "<circle cx='[x]' cy='[y]' r='[r]' fill='[color]' stroke-width='[borderw]' stroke='[borderc]'/>" as SVG.
	
To draw a/-- oval colored (color - a text) at (x - a number) by/x (y - a number) with size/dimensions (width - a number) by/x (height - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke:
	render "<ellipse cx='[x]' cy='[y]' rx='[width]' ry='[height]' style='fill:[color];stroke:black;stroke-width:[borderw]' />" as SVG.
	
To draw a/-- oval colored (color - a text) at (x - a number) by/x (y - a number) with size/dimensions (width - a number) by/x (height - a number) with a/-- (borderw - a number) pixel/pixels/px line-weight/stroke colored (borderc - a text):
	render "<ellipse cx='[x]' cy='[y]' rx='[width]' ry='[height]' style='fill:[color];stroke:[borderc];stroke-width:[borderw]' />" as SVG.
			
Chapter - Lines

To draw a/-- line colored (color - a text) from (x1 - a number) by/x (y1 - a number) to (x2 - a number) by/x (y2 - a number) with (linew - a number) pixel/pixels/px line-weight/stroke:
	render "<line x1='[x1]' y1='[y1]' x2='[x2]' y2='[y2]' style='stroke:[color];stroke-width:[linew];'/>" as SVG.
		

To draw a/-- line colored (color - a text) from (coordinates1 - a list of numbers) to (coordinates2 - a list of numbers) with (linew - a number) pixel/pixels/px line-weight/stroke:
	let x1 be entry 1 of coordinates1;
	let y1 be entry 2 of coordinates1;
	let x2 be entry 1 of coordinates2;
	let y2 be entry 2 of coordinates2;
	Draw a line colored (color) from x1 by y1 to x2 by y2 with linew pixel stroke.
	

GLK SVG Drawing Commands ends here.

---- Documentation ----

The SVG Handler extension provides SVG capability for Inform 7. This extension is a simple interface to a GLK function that renders a SVG string and displays the resulting image. Any Inform 7 story that uses this extension to render and display SVG should be run on an interpreter that supports this GLK function.

To display SVG, the following syntax is used:

        render (indexed text) as SVG.

The indexed text provided to this rule is converted to a GLK c-style string, which can then be used by the GLK function to render the SVG string.

Example: * Three-Puzzle - Drawing a simple puzzle in SVG

        *: "Three-Puzzle"
        Include SVG Handler by Tesca Fitzgerald

        Section - Demo

        The Chamber of the Three-Puzzle is a room.  "You
        have entered the Chamber of the Three-Puzzle. You
        are filled with a deep foreboding as you contemplate
        its complexity."
        
        The three-puzzle is a thing. The description is "This
        puzzle has three sliding tiles. You are to put them
        in order left-to-right, top-to-bottom, by sliding a
        tile up, down, left or right."

        Table of Tile Positions
        tile tile-x tile-y
        1    1      2
        2    1      1
        3    2      1

        To draw the three-puzzle:
        	repeat with x running through {1, 2}:
                	repeat with y running through {1, 2}:
                        	if there is a row with tile-x of x and tile-y of y in the Table of Tile Positions:
                                	let r be the row with tile-x of x and tile-y of y in the Table of Tile Positions:
                                	say "[the tile of r]"
                                else:
                                	say " "
                        say "[line break]"

        Instead of examining the three-puzzle: draw the three-puzzle.

        

        Test me with "".
