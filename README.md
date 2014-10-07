js_proxy
========

Lite Proxy to work with JavaScript from Dart.

High-level Proxy solution is lite and layered on top of dart:js. Library is very easy to use. 
To compare look at JavaScript code of jQuery:

    $( "#container" ).click( function() {
      $( this ).slideUp();
    };

    $('#container').addClass('test').removeClass('color');

That code will has next analog on Dart:

    $( "#container" ).click( (event) {
      $(event['target']).slideUp();
    });	

    $('#container').addClass('test').removeClass('color');

Usage
-----

Let's see usage based on jQuery framework. All results were checked on Dartium, Chrome, Firefox and IE.

#### HTML markups and styles
Use CDN for quick and free access to jQuery 1.11. Add this script reference before all of Dart scripts:

    <body>
    ...
    </body>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="application/dart" src="index.dart"></script>
    <script src="packages/browser/dart.js"></script>

#### Script usage
Add `js_proxy` into dependencies of `pubspec.yaml` file. Run `pub get` command to resolve dependencies:

    dependencies:
     js_proxy: '>=0.1.0 <0.2.0'

Add `js_proxy` into import statement of your code: 

    import 'dart:html';
    import 'package:js_proxy/js_proxy.dart'; 

Create shortcut for jQuery:

    var $ = new JProxy.fromContext('jQuery');

If necessary create shortcut for `console` as well:

    var console = window.console;

#### Several words about jQuery syntax 
The jQuery systax used in all examples is selecting HTML element(s) and perform some actions.
Basic syntax is: 
     
     $(selector).action();

#### Example 1. Get jQuery version number
Next code print the current version of jQuery to console:

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

#### Example 2. jQuery selectors
jQuery selectors allows select and manipulate HTML element(s) based on their

- id, 
- classes, 
- types, 
- attributes, 
- values of attributes

All selectors in jQuery start with the dollar sign and parentheses: 

    /**
     * jQuery code:
     * 
     *   var btn = $("button");
     * 
     * JS_Proxy based analog:
     */
    selectors() {
      var btn = $("button");
    }

#### Example 3. jQuery events
jQuery could server events in an HTML page:

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

#### Example 4. jQuery effects
With jQuery we can hide, show, toggele, slide, fade and animate you elements:

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
      $("p").hide("slow", (){
        window.alert("The paragraph is now hidden");
      });
      $("button").click((event) {
        // Because difference in notion about 'this' keyword between JavaScript 
        // and Dart we should use real instance here
        $(event.target).animate({'left':'250px'});
      });
    }

P.S. _We can't use `this` keyword in anonimouse functions so directly use element to manipulate_

#### Exmple 5. jQuery method chaining
Actions and methods could be chained with jQuery. It allows you to run multiple methods or actions on the same element within a single statement:

    $("#p1").css("color","red").slideUp(2000).slideDown(2000);

#### Eample 6. Get content and attributes
With jQuery you could easy to access and manipulate elements and attributes:

- text() - Returns the text content of selected elements
- html() - Returns the content of selected elements (including HTML markup)
- val() - Returns the value of form fields

Source code:

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

#### Example 7. Set content and attributes
Use the next methods to set content and attributes:

- text() - Sets the text content of selected elements
- html() - Sets the content of selected elements (including HTML markup)
- val() - Sets the value of form fields

Source code

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

#### Example 8. jQuery add elements and content
jQuery allows you easy add new elements or content via next methods:

- append() - Inserts content at the end of the selected elements
- prepend() - Inserts content at the beginning of the selected elements
- after() - Inserts content after the selected elements
- before() - Inserts content before the selected elements

Source code:

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

#### Example 9. jQuery remove elements and content
jQuery helps to remove existing HTML elements and content via followinf methods:

- remove() - Removes the selected element (and its child elements)
- empty() - Removes the child elements from the selected element

Source code:

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

#### Example 10. jQuery get and set CSS classes
jQuery makes easy to manipulate the CSS of elements with below methods:

- addClass() - Adds one or more classes to the selected elements
- removeClass() - Removes one or more classes from the selected elements
- toggleClass() - Toggles between adding/removing classes from the selected elements
- css() - Sets or returns the style attribute

Source code:

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

#### Example 11. jQuery dimensions
With following jQuery methods you could easy to work with the dimensions of elements and browser window:

- width()
- height()
- innerWidth()
- innerHeight()
- outerWidth()
- outerHeight()

Source code:

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

#### Example 12. jQuery traversing
The jQuery helps move through HTML elements based on their relation to other elements. Yoy can start with one selection and move through that selection until you reach the elements you desire.

You could traverse up with next methods:

- parent()
- parents()
- parentsUntil()

Source code:

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

Use next methods to traverse down:

- children()
- find()

Source code:

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

Next methods help you traverse sideways in the DOM tree to find siblings of an element:

- siblings()
- next()
- nextAll()
- nextUntil()
- prev()
- prevAll()
- prevUntil()

Source code:

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

To narrow down the search elements you may use:

- first(), 
- last() 
- eq()
- filter() 
- not()

Source code:

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

