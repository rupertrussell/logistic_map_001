// Program by Rupert Russell
// 4/01/2022
// For background view https://www.youtube.com/watch?v=1ApX-OHGOdw
int inc = 0;
float maxR = 4.0;
float step = 0.001;
int numOfXPoints = 500;
int MaxNumOfUniqueValues = 51;
int NumOfUniqueXValuesToPlot = 0;
boolean isaUniqueValue = true;
float y = 0;
float x = 0;
int count = 0;
int counter = 0;

float[] Xpos = new float[501];
float[] XUniqueValues = new float[MaxNumOfUniqueValues];
int canvasWidth = 1200;
int canvasHeight = 600;

void setup() {
  size (1200, 600);
  fill(0);
  noLoop();
  strokeWeight(0.4);

  // set all array values to -1 as a default value
  for (int n = 0; n < numOfXPoints; n++) {
    Xpos[n] = -1;
  }

  // set all array values to -1 as a default value
  for (int n = 0; n < MaxNumOfUniqueValues; n++) {
    XUniqueValues[n] = -1;
  }
}

void draw() {
  for (float r = 0; r <=maxR; r=r+step) {
    NumOfUniqueXValuesToPlot = 0;
    Xpos[0] = 0.5;

    // loop through 500 values and calculate X 
    for (int n = 0; n < numOfXPoints; n++) {
      Xpos[n+1] = r * Xpos[n] * (1-Xpos[n]);  //  Logistic Map Formula
      x = x + 0.002; //  = 1/numOfXPoints;
      // println("Xpos[n+1] = " + Xpos[n+1]);  // print
    }

    // Plot unique values for the last 50 Xpos points
    // look at each of the the last 50 Xpos values
    // if the value of the Xpos has not been already recordered save it in XUniqueValues[n]

    // store the first point so you have something to compare it against
    XUniqueValues[0] = Xpos[numOfXPoints - MaxNumOfUniqueValues]; // 500 - 50 = 450

    // print out last 50 values of  xPos[]
    count = 0;
    for (int n = numOfXPoints - MaxNumOfUniqueValues; n < numOfXPoints; n++) {
      // println(count + " - Xpos[" + n + "] = " + Xpos[n]);
      count ++;
    }

    // println("------ NumOfUniqueXValuesToPlot ------------ = " + NumOfUniqueXValuesToPlot);

    for (int n = 450; n < 500; n++) {
      // select a point and check if it matches any currently stored value if yes set flag to false
      // println("testing this number to see if it's unique: " + Xpos[n]);

      // compare the current point against each value in the array of unique values 
      // Only compare sumbers if the value int he unique array is not currently -1 (the drfaule value set above)

      int count = 0;
      isaUniqueValue = true;
      while (count < MaxNumOfUniqueValues) {  // repeat up to 50 times

        // println("the value of count is: " + count);
        if (XUniqueValues[count] == -1) {
          //  println("Breaking out of loop at count " + count);
          break;  // reached deault values so stop looking
        }

        if (Xpos[n] == XUniqueValues[count]) {
          isaUniqueValue = false;  // we found a match with an existing saved value
          //  println("This:  " + Xpos[n]+" should match == this: " + XUniqueValues[count]);
        }
        count ++;  // Increment count so it will look at next value in list of XUniqueValues[count]
      }
      if (isaUniqueValue == true) {  // we did not find a match with an existing saved value so save it
        //  println(Xpos[n]+" is unique! so store it in position " + counter);
        //  println("current counter = " + counter);
        XUniqueValues[counter + 1] = Xpos[n];  // save the value
        counter ++;  // If we have another unique value it wil save in the next position 
        NumOfUniqueXValuesToPlot ++ ;
      }
      isaUniqueValue = true;
    }


    //// print out unique values
    //println("-- NumOfUniqueXValuesToPlot = " + NumOfUniqueXValuesToPlot);
    //println("---------------------------------------------");
    //println("---------------------------------------------");

    // for (int counter2 = 0; counter2 < MaxNumOfUniqueValues; counter2++) {
    //   println("XUniqueValues[" + counter2 + "] = " + XUniqueValues[counter2]);
    //  }
    //  println("NumOfUniqueXValuesToPlot = " + NumOfUniqueXValuesToPlot);


    // test plot
    for (int n = 1; n < numOfXPoints; n++) {

      point(r* width/maxR, canvasHeight- Xpos[n] * canvasHeight);
    }
    counter = 0;
  }
  inc++;
  save("logistic_map_" + canvasWidth +"_" + canvasHeight +".png");
}
