
class ForecastImage{
  // final String code;
  // final String image;

  String getImage(String code) {
    if(code == "0" || code == "01d" || code == "01n"){
      return "images/01d.png";
    }
    else if(code == "1" || code == "2" || code == "3"|| code == "02d" || code == "02n"){
      return "images/02d.png";
    }
    else if(code == "45 "|| code == "48" || code == "03d"  || code == "03n"){
      return "images/03d.png";
    }
    else if(code == "51" || code == "53"|| code == "55" || code == "04d" || code == "04n"){
      return "images/04d.png";
    }
    else if(code == "56" || code == "57" || code == "09d"  || code == "09n"){
      return "images/09d.png";
    }
    else if(code == "61" || code == "63" || code == "65" || code == "10d" || code == "10n"){
      return "images/10d.png";
    }

    else if(code == "66"|| code == "67" || code == "11d" || code == "11n"){
      return "images/11d.png";
    }

    else if(code == "71" || code == "73" || code == "75" || code == "13d" || code == "13n"){
      return "images/13d.png";
    }
   else {
     return "images/13d.png";
    }
  }


}

