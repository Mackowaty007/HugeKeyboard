$fn = 5;

echo(version=version());

//fontKey = "Arial:style=Bold";
fontKey = "Sans Serif:style=Bold";
fontLegend = "Sans Serif:style=Bold"; 

letter_depth = 0.4;

keycap_width = 25;
keycap_length = 25;
keycap_height = 9;

x_iterations = 3; 
y_iterations = 2;

print_caps = true;
convex_legend = false;
//options
//0 - normal legend
//1 - long legend
//2 - F keys
longLegend = 1;

module render_a_keycap(mainL, subL){
    module mainLetter(l,isBold) {
      //long legend
      if(longLegend==1){
          letter_size = 4;
          translate([0,4,keycap_height-letter_depth+0.01])
          linear_extrude(letter_depth) {
              if(isBold){
                    text(l, size = letter_size, font = fontKey, halign = "center", valign = "center");
              }
              else{
                  text(l, size = letter_size, font = fontLegend, halign = "center", valign = "center");
              }
          }
      }
      //F key legend
      else if(longLegend==2){
          letter_size = 8;
          translate([0,3,keycap_height-letter_depth+0.01])
          linear_extrude(letter_depth) {
              if(isBold){
                  text(l, size = letter_size, font = fontKey, halign = "center", valign = "center");
              }
              else{
                  text(l, size = letter_size, font = fontLegend, halign = "center", valign = "center");
              }
          }
      }
      //normal legend
      else{
          letter_size = 9;
          translate([-keycap_width/2+9.5,keycap_width/2-9.5,keycap_height-letter_depth+0.01])
          linear_extrude(letter_depth) {
              if(isBold){
                    text(l, size = letter_size, font = fontKey, halign = "center", valign = "center");
              }
              else{
                  text(l, size = letter_size, font = fontLegend, halign = "center", valign = "center");
              }
          }
      }
    }

    module subLetter(l,isBold) {
        //long legend
        if(longLegend==1){
            letter_size = 4;
            translate([0,-1,keycap_height-letter_depth+0.01])
            linear_extrude(letter_depth) {
                text(l, size = letter_size, font = fontKey, halign = "center", valign = "center");
            }
        }
        //F key legend
        else if(longLegend==2){
            letter_size = 4;
            translate([0,-1,keycap_height-letter_depth+0.01])
            linear_extrude(letter_depth) {
                text(l, size = letter_size, font = fontKey, halign = "center", valign = "center");
            }
        }
        //normal legend
        else{
            letter_size = 6;
            translate([keycap_width/2-8,-keycap_width/2+8,keycap_height-letter_depth+0.01])
            linear_extrude(letter_depth) {
                text(l, size = letter_size, font = fontKey, halign = "center", valign = "center");
            }
        }
    }
    
    //render the keycap case
    if(print_caps == true){
        if(convex_legend==false){
            difference() {
                rotate([180,0,0])
                import("Body1.stl",convexity = 4);
                rotate([180,0,0])
                mainLetter(mainL,true);
                rotate([180,0,0])
                subLetter(subL,true);
            }
        }
        if(convex_legend==true){
            union() {
                rotate([180,0,0])
                import("Body1.stl",convexity = 4);
                translate([0,0,letter_depth])
                rotate([180,0,0])
                mainLetter(mainL,true);
                translate([0,0,letter_depth])
                rotate([180,0,0])
                subLetter(subL,true);
            }
        }
    }
    
    if(print_caps == false){
        //render the legend
        //translate([0,(y_iterations+1)*keycap_width,0])
        rotate([180,0,0])
        mainLetter(mainL,false);
        //translate([0,(y_iterations+1)*keycap_width,0])
        rotate([180,0,0])
        subLetter(subL,false);
    }
}

//list of all the key legends
legend_list = 
[
/*["F1",""],["F2",""],["F3",""],["F4",""],["F5",""],["F6",""],["F7",""],["F8",""],["F9",""],["F10",""],["F11",""],["F12",""],
/*["1","!"],["2","@"],["3","#"],["4","$"],["5","%"],["6","^"],["7","&"],["8","*"],["9","("],["0",")"],["-","_"],["=","+"],["\u2190",""],
["Q",""],["W",""],["E",""],["R",""],["T",""],["Y",""],["U",""],["I",""],["O",""],["P",""],["[","{"],["]","}"],["\\","|"],
["A",""],["S",""],["D",""],["F",""],["G",""],["H",""],["J",""],["K",""],["L",""],[";",":"],["'","\""],
["Z",""],["X",""],["C",""],["V",""],["B",""],["N",""],["M",""],[",","<"],[".",">"],["/","?"],
["`","~"],*/["Tab",""],["Ctrl",""],["Shift",""],["Alt",""],["Alt Gr",""],["Esc",""],["Caps","Lock"],["Menu",""],["L Gui",""],["R Gui",""],
/*["Print","Screen"],["Scroll","Lock"],["Pause",""],["Insert",""],["Home",""],["Page","Up"],["Delete",""],["End",""],["Page","Down"],*/
["Kopiuj",""],["Wklej",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],
["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],
["",""],["",""],["",""],["",""],["",""],["",""],["",""]
];

for (x=[0:x_iterations]){
    for(y=[0:y_iterations]){
        translate([x*(keycap_length+1),y*(keycap_width+1),0])
        render_a_keycap(legend_list[x+y*(x_iterations+1)][0],legend_list[x+y*(x_iterations+1)][1]);
    }
}