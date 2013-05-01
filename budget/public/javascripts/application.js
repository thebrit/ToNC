// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function displayTotal()
{
  // function to calculate changing month totals - used in budget entry
  var jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec;
  var total, balance;
  jan =  parseFloat(document.getElementById("budget_january").value);
  feb =  parseFloat(document.getElementById("budget_february").value);
  mar =  parseFloat(document.getElementById("budget_march").value);
  apr =  parseFloat(document.getElementById("budget_april").value);
  may =  parseFloat(document.getElementById("budget_may").value);
  jun =  parseFloat(document.getElementById("budget_june").value);
  jul =  parseFloat(document.getElementById("budget_july").value);
  aug =  parseFloat(document.getElementById("budget_august").value);
  sep =  parseFloat(document.getElementById("budget_september").value);
  oct =  parseFloat(document.getElementById("budget_october").value);
  nov =  parseFloat(document.getElementById("budget_november").value);
  dec =  parseFloat(document.getElementById("budget_december").value);
  total =jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec;
//  need to work on getting the balance to work maybe need a hidden field to get the value!!!!!!!!!!!
  balance = parseFloat(document.getElementById("hidden_balance").value);
//  balance = document.getElementById("test").value;
  balance = balance - total;

  document.getElementById("budget_form_total").innerHTML = "$ " + total.toFixed(2);
  document.getElementById("form_balance").innerHTML = "$ " + balance.toFixed(2);
  document.getElementById("hidden_balance").innerHTML = balance.toFixed(2);
  //change negative to red
  if (balance < 0){
    document.getElementById("form_balance").style.color = 'red';
  }
  else {
    document.getElementById("form_balance").style.color = 'black';
  }
}