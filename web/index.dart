import 'dart:html';

import 'package:js_proxy/js_proxy.dart';

/**
 * Shortcut for jQuery.
 */
var $ = new JProxy.fromContext('jQuery');

/**
 * Shortcut for browser console object.
 */
var console = window.console;

main() {
  // Print the verion of jQuery out to console
  printVersion();
  // Selectors
  selectors();
  // Event Methods
  events();
  // Effects
//  effects();
//  // Method chaining
//  chaining();
//  // Get content and attributes
//  getContentAndAttributes();
//  // Set content and attributes
//  setContentAndAttributes();
//  // Add elements and content
//  addElementsAndContent();
//  // Remove elements and content
//  removeElementsAndContent();
//  // Get and set CSS classes
//  getAndSetClasses();
//  // Dimensions
//  dimensions();
//  // Traversing up the DOM tree
//  traversingUp();
//  // Traversing down the DOM tree
//  traversingDown();
//  // Traversing sideways
//  sibling();
//  // Filtering
//  filtering();
}

/**
 * jQuery code:
 * 
 *   var ver = $().jquery;
 *   console.log("jQuery version is " + ver);
 * 
 * JS_Proxy based analog:
 */
printVersion() {
  var ver = $().jquery;
  console.log("jQuery version is " + ver);
}

/**
 * jQuery code:
 * 
 *   var btn = $("button");
 * 
 * JS_Proxy based analog:
 */
selectors() {
  var btn = $("button");
  var p = $("#ccontainer");
  var txt = $(".input");
}

/**
 * jQuery code:
 * 
 *   $("p").click(function(){
 *     alert('You click on paragraph');
 *   });
 * 
 * JS_Proxy based analog:
 */
events() {
  // We remove 'funtion' and add 'event' here
  $("p").click((event) {
    // Call method 'alert' of 'window'
    window.alert('You click on paragraph');
  });
}

/**
 * jQuery code:
 * 
 *   $("p").hide("slow",function(){
 *     alert("The paragraph is now hidden");
 *   });
 *   $("button").click(function(){
 *     $(this).animate({left:'250px'});
 *   }); 
 * 
 * JS_Proxy based analog:
 */
effects() {
  $("#toHide").click((event) {
    $(event['target']).hide("slow", (){
      window.alert("The paragraph is now hidden");
    });
  });
  $("button").click((event) {
    // Because difference in notion about 'this' keyword between JavaScript 
    // and Dart we should use real instance here
    var target = $(event['target']); 
    target.animate({'left':'250px'});
  });
}

/**
 * jQuery code:
 * 
 *   $("#p1").css("color","red").slideUp(2000).slideDown(2000);
 * 
 * JS_Proxy based analog:
 */
chaining() {
  $("#p1").css("color","red").slideUp(2000).slideDown(2000);
}

/**
 * jQuery code:
 * 
 *   $("#btn1").click(function(){
 *     alert("Text: " + $("#test").text());
 *   });
 *   $("#btn2").click(function(){
 *     alert("HTML: " + $("#test").html());
 *   });
 *   $("#btn1").click(function(){
 *     alert("Value: " + $("#test").val());
 *   });
 *   $("button").click(function(){
 *     alert($("#w3s").attr("href"));
 *   });
 * 
 * JS_Proxy based analog:
 */
getContentAndAttributes() {
  $("#btn1").click((event){
    window.alert("Text: " + $("#test").text());
  });
  $("#btn2").click((event){
    window.alert("HTML: " + $("#test").html());
  });
  $("#btn1").click((event){
    window.alert("Value: " + $("#test").val());
  });
  $("button").click((event){
    window.alert($("#w3s").attr("href"));
  });
}

/**
 * jQuery code:
 * 
 *   $("#btn1").click(function(){
 *     $("#test1").text("Hello world!");
 *   });
 *   $("#btn2").click(function(){
 *     $("#test2").html("<b>Hello world!</b>");
 *   });
 *   $("#btn3").click(function(){
 *     $("#test3").val("Dolly Duck");
 *   });
 * 
 * Callback functions:
 *   $("#btn1").click(function(){
 *     $("#test1").text(function(i,origText){
 *       return "Old text: " + origText + " New text: Hello world! (index: " + i + ")"; 
 *     });
 *   });
 *   $("#btn2").click(function(){
 *     $("#test2").html(function(i,origText){
 *       return "Old html: " + origText + " New html: Hello <b>world!</b>(index: " + i + ")"; 
 *     });
 *   });
 * 
 * Usage 'attr':
 *   $("button").click(function(){
 *     $("#w3s").attr("href","http://www.w3schools.com/jquery");
 *   });
 * 
 * Callback for 'attr':
 *   $("button").click(function(){
 *     $("#w3s").attr("href", function(i,origValue){
 *       return origValue + "/jquery"; 
 *     });
 *   });
 * 
 * JS_Proxy based analog:
 */
setContentAndAttributes() {
  $("#btn1").click((event){
    $("#test1").text("Hello world!");
  });
  $("#btn2").click((event){
    $("#test2").html("<b>Hello world!</b>");
  });
  $("#btn3").click((event){
    $("#test3").val("Dolly Duck");
  });
  // Callback functions
  $("#btn1").click((event){
    $("#test1").text((i,origText){
      return "Old text: " + origText + " New text: Hello world! (index: " + i + ")"; 
    });
  });
  $("#btn2").click((event){
    $("#test2").html((i,origText){
      return "Old html: " + origText + " New html: Hello <b>world!</b> (index: " + i + ")"; 
    });
  });
  // Usage 'attr'
  $("button").click((event){
    $("#w3s").attr("href","http://www.w3schools.com/jquery");
  });
  // Callback for 'attr'
  $("button").click((event){
    $("#w3s").attr("href", (i,origValue){
      return origValue + "/jquery"; 
    });
  });
}

/**
 * jQuery code:
 * 
 *   $("p").append("Some appended text.");
 *   $("p").prepend("Some prepended text.");
 *   $("img").after("Some text after");
 *   $("img").before("Some text before");
 * 
 * Add several new elements:
 *   var txt1 = "<p>Text.</p>";               // Create element with HTML  
 *   var txt2 = $("<p></p>").text("Text.");   // Create with jQuery
 *   var txt3 = document.createElement("p");  // Create with DOM
 *   txt3.innerHTML = "Text.";
 *   $("p").append(txt1, txt2, txt3);         // Append the new elements 
 * 
 * JS_Proxy based analog:
 */
addElementsAndContent() {
  $("p").append("Some appended text.");
  $("p").prepend("Some prepended text.");
  $("img").after("Some text after");
  $("img").before("Some text before");
  // Add several new elements
  var txt1 = "<p>Text.</p>";               // Create element with HTML  
  var txt2 = $("<p></p>").text("Text.");   // Create with jQuery
  var txt3 = document.createElement("p");  // Create with DOM
  txt3.setInnerHtml("Text.");
  $("p").append(txt1, txt2, txt3);
}

/**
 * jQuery code:
 * 
 *   $("#div1").remove();
 *   $("#div1").empty();
 * 
 * Filter the elements to be removed:
 *   $("p").remove(".italic");
 * 
 * JS_Proxy based analog:
 */
removeElementsAndContent() {
  $("#div1").remove();
  $("#div1").empty();
  // Filter the elements to be removed
  $("p").remove(".italic");
}

/**
 * jQuery code:
 * 
 *   $("button").click(function(){
 *     $("h1,h2,p").addClass("blue");
 *     $("div").addClass("important");
 *   });
 *   $("button").click(function(){
 *     $("#div1").addClass("important blue");
 *   });
 *   $("button").click(function(){
 *     $("#div1").addClass("important blue");
 *   });
 *   $("button").click(function(){
 *     $("h1,h2,p").toggleClass("blue");
 *   });
 * 
 * Via 'css' method:
 *   $("p").css("background-color");
 *   $("p").css("background-color","yellow");
 * 
 * Set multiple properties with 'css':
 *   $("p").css({"background-color":"yellow","font-size":"200%"});
 * 
 * JS_Proxy based analog:
 */
getAndSetClasses() {
  $("button").click((event){
    $("h1,h2,p").addClass("blue");
    $("div").addClass("important");
  });
  $("button").click((event){
    $("#div1").addClass("important blue");
  });
  $("button").click((event){
    $("h1,h2,p").removeClass("blue");
  });
  $("button").click((event){
    $("h1,h2,p").toggleClass("blue");
  });
  // Via 'css' method
  $("p").css("background-color");
  $("p").css("background-color","yellow");
  // Set multiple properties with 'css'
  $("p").css({"background-color":"yellow","font-size":"200%"});
}

/**
 * jQuery code:
 * 
 * Methods width and height:
 *   $("button").click(function(){
 *     var txt="";
 *     txt+="Width: " + $("#div1").width() + "</br>";
 *     txt+="Height: " + $("#div1").height();
 *     $("#div1").html(txt);
 *   });
 * 
 * Methods innerWidth and innerHeight:
 *   $("button").click(function(){
 *     var txt="";
 *     txt+="Inner width: " + $("#div1").innerWidth() + "</br>";
 *     txt+="Inner height: " + $("#div1").innerHeight();
 *     $("#div1").html(txt);
 *   });
 * 
 * Methods outerWidth and outerHeight:
 *   $("button").click(function(){
 *     var txt="";
 *     txt+="Outer width: " + $("#div1").outerWidth() + "</br>";
 *     txt+="Outer height: " + $("#div1").outerHeight();
 *     $("#div1").html(txt);
 *   });
 * 
 * The outerWidth(true) and outerHeight(true) methods return the 
 * width and height of an element (includes padding, border, and margin):
 *   $("button").click(function(){
 *     var txt="";
 *     txt+="Outer width (+margin): " + $("#div1").outerWidth(true) + "</br>";
 *     txt+="Outer height (+margin): " + $("#div1").outerHeight(true);
 *     $("#div1").html(txt);
 *   });
 * 
 * Chaining width and height methods:
 *   $("button").click(function(){
 *     $("#div1").width(500).height(500);
 *   });
 * 
 * JS_Proxy based analog:
 */
dimensions() {
  // Methods width and height
  $("button").click((event){
    var txt="";
    txt+="Width: " + $("#div1").width() + "</br>";
    txt+="Height: " + $("#div1").height();
    $("#div1").html(txt);
  });
  // Methods innerWidth and innerHeight
  $("button").click((event){
    var txt="";
    txt+="Inner width: " + $("#div1").innerWidth() + "</br>";
    txt+="Inner height: " + $("#div1").innerHeight();
    $("#div1").html(txt);
  });
  // Methods outerWidth and outerHeight
  $("button").click((event){
    var txt="";
    txt+="Outer width: " + $("#div1").outerWidth() + "</br>";
    txt+="Outer height: " + $("#div1").outerHeight();
    $("#div1").html(txt);
  });
  // The outerWidth(true) and outerHeight(true) methods return the 
  // width and height of an element (includes padding, border, and margin):
  $("button").click((event){
    var txt="";
    txt+="Outer width (+margin): " + $("#div1").outerWidth(true) + "</br>";
    txt+="Outer height (+margin): " + $("#div1").outerHeight(true);
    $("#div1").html(txt);
  });
  // Chaining width and height methods
  $("button").click((event){
    $("#div1").width(500).height(500);
  });
}

/**
 * jQuery code:
 * 
 *   $("span").parent();
 *   $("span").parents("ul");
 *   $("span").parentsUntil("div");
 * 
 * JS_Proxy based analog:
 */
traversingUp() {
  $("span").parent();
  $("span").parents("ul");
  $("span").parentsUntil("div");
}

/**
 * jQuery code:
 * 
 *   $("div").children();
 *   $("div").children("p.1");
 *   $("div").find("span");
 *   $("div").find("*");
 * 
 * JS_Proxy based analog:
 */
traversingDown() {
  $("div").children();
  $("div").children("p.1");
  $("div").find("span");
  $("div").find("*");
}

/**
 * jQuery code:
 * 
 *   $("h2").siblings();
 *   $("h2").siblings("p");
 *   $("h2").next();
 *   $("h2").nextAll();
 *   $("h2").nextUntil("h6");
 *   $("h2").prev();
 *   $("h2").prevAll();
 *   $("h2").prevUntil("h6");
 * 
 * JS_Proxy based analog:
 */
sibling() {
  $("h2").siblings();
  $("h2").siblings("p");
  $("h2").next();
  $("h2").nextAll();
  $("h2").nextUntil("h6");
  $("h2").prev();
  $("h2").prevAll();
  $("h2").prevUntil("h6");
}

/**
 * jQuery code:
 * 
 *   $("div p").first();
 *   $("div p").last();
 *   $("p").eq(1);
 *   $("p").filter(".intro");
 *   $("p").not(".intro");
 * 
 * JS_Proxy based analog:
 */
filtering() {
  $("div p").first();
  $("div p").last();
  $("p").eq(1);
  $("p").filter(".intro");
  $("p").not(".intro");
}