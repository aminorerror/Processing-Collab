

float[] SimpleLinearRegression(ArrayList<Country> list_, int dv_, int iv_ ){
   
  int listSize = list_.size();
  
  //get a list of the dependent and independent variables
  FloatList dv = new FloatList();
  FloatList iv = new FloatList();
  for (int i=0; i<listSize; i++){
      dv.append(list_.get(i).INF_MORT);
      iv.append(list_.get(i).PCI);
  }
  
  //calculate mean
  float meanDv=Mean(dv);
  float meanIv=Mean(iv);
  
  float stDevDv = StandardDev(dv, meanDv);
  float stDevIv = StandardDev(iv, meanIv);
  
  
  
  //Calculate SSxy
  
  // dv - mean Dv (x - xbar)
  FloatList a = new FloatList();
  FloatList b = new FloatList();
  for (int i=0; i<listSize; i++){
    dv.sub(i,meanDv);
    iv.sub(i,meanIv);
    
    //Substract both variables by their respective means and multiply them together
    
    a.append(dv.get(i)*iv.get(i));
    
    //Square  DV
    b.append(sq(iv.get(i)));
    
    println(b.get(i));
  }
  
  float numerator = Sum(a);
  float denominator = Sum(b);
  
  float beta1 = Sum(a)/(Sum(b));
  float beta0 = meanDv-beta1*meanIv;
  
  //Descriptives
  println(meanDv, meanIv, stDevDv, stDevIv);
  
  return new float[] {beta0, beta1};
  
}

float Sum(FloatList list){
  float x = 0;
  
  for (int i=0; i<list.size(); i++){
    x+=list.get(i);
  }
  
  return x;
}

float Mean(FloatList list){
  return Sum(list)/list.size();
}

float StandardDev(FloatList list, float mean){
  float x = 0.0;
  int df = list.size()-1;
  for (int i=0; i<list.size(); i++){
    x += sq(list.get(i)-mean);
  }

  return sqrt(x/df);
}