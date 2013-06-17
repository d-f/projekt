import SimpleOpenNI.*;
SimpleOpenNI  context;

float breite = 675, hoehe = 605;
boolean erste_bewegung = true, zweite_bewegung = false, dritte_bewegung = false, vierte_bewegung = false;

float min_dist = 0;   // 500 ist ca 0,5m
float max_dist = 2000;  //3600 entspricht ca. 4m.
float arbeits_dist = max_dist - min_dist;

void setup () {
  context = new SimpleOpenNI(this);
  context.enableDepth();
  background(0);
  stroke(0,0,255);
  strokeWeight(3);
  smooth();
  size(800, 800);
  //size((int)breite, (int)hoehe);
}

void draw () {
  PVector[] pv = context.depthMapRealWorld();
  float tiefe = max_dist - pv[176960].z;
  if (tiefe < 0){
    tiefe = 0;
  }
  println(tiefe);
  context.update();
  background(0);
  
  //Dreieck
  stroke(100, 100, tiefe/10);
  line(0, hoehe, breite/2, 0);
  line(breite/2, 0, breite, hoehe);
  line(breite, hoehe, 0, hoehe);
  
  //Um die Bewegung immer beim Laufen zu haben, mann muss beim Rückkehr der Maus Erlaubparameter auf "true" setzen.
 if (tiefe >= min_dist && tiefe <= (min_dist + arbeits_dist/4)){
    erste_bewegung = true;
    zweite_bewegung = false;
    dritte_bewegung = false;
    vierte_bewegung = false;
  }

  if (erste_bewegung == true){
    erste_bewegung(tiefe);
  } else {
    male_eins();
  }
  
  //2. Bewegung ausführen
  if (tiefe > (min_dist + arbeits_dist/4) && tiefe <= (min_dist + arbeits_dist/2)){
    zweite_bewegung = true;
    dritte_bewegung = false;
    vierte_bewegung = false;
  }
  
  if (zweite_bewegung == true){
    male_eins();
    zweite_bewegung(tiefe);
  }else if (erste_bewegung == false){
    male_eins();
    male_zwei();
  }
  
  //3. Bewegung ausführen
  if (tiefe > (min_dist + arbeits_dist/2) && tiefe <= (min_dist + arbeits_dist*3/4)){
    zweite_bewegung = false;
    dritte_bewegung = true;
    vierte_bewegung = false;
  }
  
  if (dritte_bewegung == true){
    dritte_bewegung(tiefe);
  }else if (erste_bewegung == false && zweite_bewegung == false){
    male_drei();
  }
  
  //4. Bewegung ausführen
  if (tiefe > (min_dist + arbeits_dist*3/4)){
    zweite_bewegung = false;
    dritte_bewegung = false;
    vierte_bewegung = true;
  }
  
  if (vierte_bewegung == true){
    vierte_bewegung(tiefe);
  }
}
  
void erste_bewegung(float tiefe){
float erste_line_x1 = 0, erste_line_y1 = hoehe, erste_line_x2 = breite, erste_line_y2 = hoehe;
float erste_line2_x1 = breite, erste_line2_y1 = hoehe, erste_line2_x2 = 0, erste_line2_y2 = hoehe;
float zw_erste_line_x1 = breite/2, zw_erste_line_y1 = 0, zw_erste_line_x2 = breite, zw_erste_line_y2 = hoehe;
float zw_erste_line2_x1 = breite, zw_erste_line2_y1 = hoehe, zw_erste_line2_x2 = breite/2, zw_erste_line2_y2 = 0;
float dr_erste_line_x1 = breite/2, dr_erste_line_y1 = 0, dr_erste_line_x2 = 0, dr_erste_line_y2 = hoehe;
float dr_erste_line2_x1 = 0, dr_erste_line2_y1 = hoehe, dr_erste_line2_x2 = breite/2, dr_erste_line2_y2 = 0;

//Änderungen. Bei der erste Bewegung die BreiteÄnderung ist von "breite" bis "breite*3/4". Also auf (-1/4)
//HoeheÄnderung ist von "hoehe" bis "hoehe/2"- Also auf (-1/2). 1000 kommt von Kineckt. Danach wird als Parameter.
float a_x = (breite/4)/(arbeits_dist/4);
float a_y = (hoehe/2)/(arbeits_dist/4);
float a_x3 = (breite/2)/(arbeits_dist/4);

/*if (tiefe < min_dist){
  tiefe = min_dist;
}*/
 
float aender1x = a_x*(tiefe); 
float aender1y = a_y*(tiefe);
float aender1x3 = a_x3*(tiefe);

    //Von unten links*************************************
    line(erste_line_x1, erste_line_y1, (erste_line_x2 - aender1x), (erste_line_y2 - aender1y));

    //Von unten rechts
    line(erste_line2_x1, erste_line2_y1, erste_line2_x2 + aender1x, erste_line2_y2 - aender1y);
      
    //Von rechts oben***************************************
    line(zw_erste_line_x1, zw_erste_line_y1, zw_erste_line_x2 - aender1x3, zw_erste_line_y2);
    
    //Von rechts unten
    line(zw_erste_line2_x1, zw_erste_line2_y1, zw_erste_line2_x2 - (aender1x), zw_erste_line2_y2 + aender1y);

    
    //Von links oben****************************************
    line(dr_erste_line_x1, dr_erste_line_y1, dr_erste_line_x2 + aender1x3, dr_erste_line_y2);
    
    //Von links unten
    line(dr_erste_line2_x1, dr_erste_line2_y1, dr_erste_line2_x2 + aender1x, dr_erste_line2_y2 + aender1y);


    if (tiefe > (min_dist + arbeits_dist/4)){
      erste_bewegung = false;
      zweite_bewegung = true;
    }
    else if (tiefe < min_dist) {
      erste_bewegung = false;  
      tiefe = min_dist;
    }
    else{
      erste_bewegung = true;
    }
}

void zweite_bewegung(float tiefe){
float zweite_line_x1 = breite*3/4, zweite_line_y1 = hoehe/2, zweite_line_x2 = breite/4, zweite_line_y2 = hoehe/2;
float zweite_line2_x1 = breite/4, zweite_line2_y1 = hoehe/2, zweite_line2_x2 = breite*3/4, zweite_line2_y2 = hoehe/2;
float zw_zweite_line_x1 = breite/2, zw_zweite_line_y1 = hoehe, zw_zweite_line_x2 = breite/4, zw_zweite_line_y2 = hoehe/2;
float zw_zweite_line2_x1 = breite/4, zw_zweite_line2_y1 = hoehe/2, zw_zweite_line2_x2 = breite/2, zw_zweite_line2_y2 = hoehe;
float dr_zweite_line_x1 = breite/2, dr_zweite_line_y1 = hoehe, dr_zweite_line_x2 = breite*3/4, dr_zweite_line_y2 = hoehe/2;
float dr_zweite_line2_x1 = breite*3/4, dr_zweite_line2_y1 = hoehe/2, dr_zweite_line2_x2 = breite/2, dr_zweite_line2_y2 = hoehe;

//Änderungen für zweite Bewegung
float zw_a_x = (breite/8)/(arbeits_dist/4);
float zw_a_y = (hoehe/4)/(arbeits_dist/4);

if (tiefe < (min_dist + arbeits_dist/4)){
  tiefe = (min_dist + arbeits_dist/4);
}
float aender2x = zw_a_x*(tiefe - (min_dist + arbeits_dist/4));
float aender2y = zw_a_y*(tiefe - (min_dist + arbeits_dist/4));

    //Von unten
    line(zweite_line_x1, zweite_line_y1, zweite_line_x2 + aender2x, zweite_line_y2 - aender2y);
    
    line(zweite_line2_x1, zweite_line2_y1, zweite_line2_x2 - aender2x, zweite_line2_y2 - aender2y);

    //Von rechts
    line(zw_zweite_line_x1, zw_zweite_line_y1, zw_zweite_line_x2 - aender2x, zw_zweite_line_y2 + aender2y);
        
    line(zw_zweite_line2_x1, zw_zweite_line2_y1, zw_zweite_line2_x2 - 2*aender2x, zw_zweite_line2_y2);
    
    //Von links
    line(dr_zweite_line_x1, dr_zweite_line_y1, dr_zweite_line_x2 + aender2x, dr_zweite_line_y2 + aender2y);
        
    line(dr_zweite_line2_x1, dr_zweite_line2_y1, dr_zweite_line2_x2 + 2*aender2x, dr_zweite_line2_y2);
    
    if (tiefe > (min_dist + arbeits_dist/2)){
      zweite_bewegung = false;
      dritte_bewegung = true;
    }
}

void dritte_bewegung(float tiefe){
float dritte_line_x1 = breite*3/8, dritte_line_y1 = hoehe/4, dritte_line_x2 = breite*5/8, dritte_line_y2 = hoehe/4;
float dritte_line2_x1 = breite*5/8, dritte_line2_y1 = hoehe/4, dritte_line2_x2 = breite*3/8, dritte_line2_y2 = hoehe/4;
float zw_dritte_line_x1 = breite/8, zw_dritte_line_y1 = hoehe*12/16, zw_dritte_line_x2 = breite/4, zw_dritte_line_y2 = hoehe;
float zw_dritte_line2_x1 = breite/4, zw_dritte_line2_y1 = hoehe, zw_dritte_line2_x2 = breite/8, zw_dritte_line2_y2 = hoehe*3/4;
float dr_dritte_line_x1 = breite*7/8, dr_dritte_line_y1 = hoehe*12/16, dr_dritte_line_x2 = breite*3/4, dr_dritte_line_y2 = hoehe;
float dr_dritte_line2_x1 = breite*3/4, dr_dritte_line2_y1 = hoehe, dr_dritte_line2_x2 = breite*7/8, dr_dritte_line2_y2 = hoehe*3/4;

//Änderungen für dritte Bewegung
float dr_a_x = (breite/16)/(arbeits_dist/4);
float dr_a_y = (hoehe/8)/(arbeits_dist/4);
float aender3x = dr_a_x*(tiefe - (min_dist + arbeits_dist/2));
float aender3y = dr_a_y*(tiefe - (min_dist + arbeits_dist/2));
    
    //Von unten
    line(dritte_line_x1, dritte_line_y1, dritte_line_x2 - aender3x, dritte_line_y2 - aender3y);

    line(dritte_line2_x1, dritte_line2_y1, dritte_line2_x2 + aender3x, dritte_line2_y2 - aender3y);

    //Von rechts
    line(zw_dritte_line_x1, zw_dritte_line_y1, zw_dritte_line_x2 - 2*aender3x, zw_dritte_line_y2);

    line(zw_dritte_line2_x1, zw_dritte_line2_y1, zw_dritte_line2_x2 - aender3x, zw_dritte_line2_y2 + aender3y);

    //Von links
    line(dr_dritte_line_x1, dr_dritte_line_y1, dr_dritte_line_x2 + 2*aender3x, dr_dritte_line_y2);

    line(dr_dritte_line2_x1, dr_dritte_line2_y1, dr_dritte_line2_x2 + aender3x, dr_dritte_line2_y2 + aender3y);

    if (tiefe > (min_dist + arbeits_dist*3/4)){
      dritte_bewegung = false;
      vierte_bewegung = true;
    }
}

void vierte_bewegung(float tiefe){
float vierte_line_x1 = breite*9/16, vierte_line_y1 = hoehe/8, vierte_line_x2 = breite*7/16, vierte_line_y2 = hoehe/8;
float vierte_line2_x1 = breite*7/16, vierte_line2_y1 = hoehe/8, vierte_line2_x2 = breite*9/16, vierte_line2_y2 = hoehe/8;
float zw_vierte_line_x1 = breite/8, zw_vierte_line_y1 = hoehe, zw_vierte_line_x2 = breite/16, zw_vierte_line_y2 = hoehe*7/8;
float zw_vierte_line2_x1 = breite/16, zw_vierte_line2_y1 = hoehe*7/8, zw_vierte_line2_x2 = breite/8, zw_vierte_line2_y2 = hoehe;
float dr_vierte_line_x1 = breite*7/8, dr_vierte_line_y1 = hoehe, dr_vierte_line_x2 = breite*15/16, dr_vierte_line_y2 = hoehe*7/8;
float dr_vierte_line2_x1 = breite*15/16, dr_vierte_line2_y1 = hoehe*7/8, dr_vierte_line2_x2 = breite*7/8, dr_vierte_line2_y2 = hoehe;
    
//Änderungen für vierte Bewegung
float v_a_x = (breite/32)/(arbeits_dist/4);
float v_a_y = (hoehe/16)/(arbeits_dist/4);

if (tiefe > max_dist){
  tiefe = max_dist;
}

float aender4x = v_a_x*(tiefe - (min_dist + arbeits_dist*3/4));
float aender4y = v_a_y*(tiefe - (min_dist + arbeits_dist*3/4));
    
    //Von unten
    line(vierte_line_x1, vierte_line_y1, vierte_line_x2 + aender4x, vierte_line_y2 - aender4y);

    line(vierte_line2_x1, vierte_line2_y1, vierte_line2_x2 - aender4x, vierte_line2_y2 - aender4y);

    //Von rechts
    line(zw_vierte_line_x1, zw_vierte_line_y1, zw_vierte_line_x2 - aender4x, zw_vierte_line_y2 + aender4y);

    line(zw_vierte_line2_x1, zw_vierte_line2_y1, zw_vierte_line2_x2 - 2*aender4x, zw_vierte_line2_y2);

    //Von links
    line(dr_vierte_line_x1, dr_vierte_line_y1, dr_vierte_line_x2 + aender4x, dr_vierte_line_y2 + aender4y);

    line(dr_vierte_line2_x1, dr_vierte_line2_y1, dr_vierte_line2_x2 + 2*aender4x, dr_vierte_line2_y2);
    
    if (vierte_line_y2 == hoehe/16){
      vierte_bewegung = false;
    }
}

void male_eins(){
    line(0, hoehe, breite*3/4, hoehe/2);
    line(breite, hoehe, breite/4, hoehe/2);
    line(breite/2, 0, breite/2, hoehe);
    
    line(breite/4, hoehe/2, breite*3/4, hoehe/2);
    line(breite/4, hoehe/2, breite/2, hoehe);
    line(breite*3/4, hoehe/2, breite/2, hoehe);
}

void male_zwei(){
    line(breite/4, hoehe/2, breite*5/8, hoehe/4);
    line(breite*3/4, hoehe/2, breite*3/8, hoehe/4);
    line(breite/4, hoehe/2, breite/4, hoehe);
    line(breite/2, hoehe, breite/8, hoehe*3/4);
    line(breite*3/4, hoehe/2, breite*3/4, hoehe);
    line(breite/2, hoehe, breite*7/8, hoehe*3/4);
    
    line(breite*3/8, hoehe/4, breite*5/8, hoehe/4);
    line(breite*1/8, hoehe*3/4, breite/4, hoehe);
    line(breite*7/8, hoehe*3/4, breite*3/4, hoehe);
    
    line(breite*3/8, hoehe*1/4, breite*3/4, hoehe);
    line(breite*5/8, hoehe*1/4, breite*1/4, hoehe);
    line(breite*1/8, hoehe*3/4, breite*7/8, hoehe*3/4);
}

void male_drei(){
    line(breite*3/8, hoehe/4, breite*9/16, hoehe/8);
    line(breite*5/8, hoehe/4, breite*7/16, hoehe/8);
    line(breite/8, hoehe*3/4, breite/8, hoehe);
    line(breite/4, hoehe, breite/16, hoehe*7/8);
    line(breite*7/8, hoehe*3/4, breite*7/8, hoehe);
    line(breite*3/4, hoehe, breite*15/16, hoehe*7/8);
    
    line(breite*7/16, hoehe/8, breite*9/16, hoehe/8);
    line(breite*1/16, hoehe*7/8, breite*1/8, hoehe);
    line(breite*15/16, hoehe*7/8, breite*7/8, hoehe);
}
