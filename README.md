This is a modification of the garglk implementation of the glk specifications. This version provides support for the rendering of SVG strings and displays the resulting image in the interactive console. 

SVG is drawn in the text buffer just as an image would be displayed, and is therefore drawn in-line. 

SVG can be drawn in a text buffer window by calling glk_svg_draw() or glk_svg_draw_scaled(). The align argument provides the SVG image alignment. The val2 argument is currently unused, and should always be zero. 

The svg_string argument is the image's SVG description that will be rendered. This description should be in the form of a C-style string. The result of this rendering will be displayed in the text buffer window. 

When calling glk_svg_draw_scaled(), the width and height parameters should dictate the SVG image's size after being scaled.

Specifications for calling the svg_draw functions can be found <a href="https://github.com/TescaF/GarglkSVG/blob/master/glk-spec-074_7.html">here</a>.
