{literal}
<!-- http://tympanus.net/codrops/2010/05/05/beautiful-background-image-navigation-with-jquery/ -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html> 
    <head> 
        <title>Beautiful Background Image Navigation with jQuery</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
        <meta name="description" content="Beautiful Background Image Navigation with jQuery" /> 
        <meta name="keywords" content="jquery, background image, animate, menu, navigation, css3, cross-browser compatible"/> 
        <link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/> 
        <style> 
            *{
                margin:0;
                padding:0;
            }
            body{
                font-family:Arial;
                padding-top:30px;
                background:#FFF9DF url(title.png) no-repeat top center;
            }
            a.back{
                background:transparent url(back.png) no-repeat 0px 0px;
                position:absolute;
                width:150px;
                height:27px;
                outline:none;
                top:2px;
                right:0px;
            }
            .reference{
                margin:20px auto;
                width:600px;
                padding:20px;
            }
            .reference p a{
                text-transform:uppercase;
                text-shadow:1px 1px 1px #fff;
                color:#666;
                text-decoration:none;
                font-size:10px;
 
            }
            .reference p a:hover{
                color:#333;
            }
        </style> 
        <!--[if lte IE 6]>
             <link rel="stylesheet" href="css/styleIE6.css" type="text/css" media="screen"/>
        <![endif]--> 
    </head> 
    <body> 
        <div id="content"> 
 
            <a class="back" href="http://tympanus.net/codrops/2010/05/05/beautiful-background-image-navigation-with-jquery"></a> 
            <div id="menuWrapper" class="menuWrapper bg1"> 
                <ul class="menu" id="menu"> 
                    <li class="bg1" style="background-position:0 0;"> 
                        <a id="bg1" href="#">Our Passion</a> 
                        <ul class="sub1" style="background-position:0 0;"> 
                            <li><a href="#">Submenu 1</a></li> 
                            <li><a href="#">Submenu 2</a></li> 
                            <li><a href="#">Submenu 3</a></li> 
                        </ul> 
                    </li> 
                    <li class="bg1" style="background-position:-266px 0px;"> 
                        <a id="bg2" href="#">Our Brands</a> 
                        <ul class="sub2" style="background-position:-266px 0;"> 
                            <li><a href="/yummers/subMenu_4">Greg</a></li> 
                            <li><a href="#">loves</a></li> 
                            <li><a href="#">Joanne</a></li> 
                        </ul> 
                    </li> 
                    <li class="last bg1" style="background-position:-532px 0px;"> 
                        <a id="bg3" href="#">Contact</a> 
                        <ul class="sub3" style="background-position:-266px 0;"> 
                            <li><a href="#">Joanne</a></li> 
                            <li><a href="#">Loves</a></li> 
                            <li><a href="#">Greg</a></li> 
                        </ul> 
                    </li> 
                </ul> 
            </div> 
 
            <div class="reference"> 
                <p><a href="http://www.flickr.com/photos/patdavid/3842889677/in/set-72157622106008372/">Photo 1: Doobies Birthday</a></p> 
                <p><a href="http://www.flickr.com/photos/patdavid/3905945428/in/set-72157622106008372/">Photo 2: Cup O Joe</a></p> 
                <p><a href="http://www.flickr.com/photos/patdavid/3786736230/in/set-72157622106008372/">Photo 3: At the bookstore</a></p> 
                <p><a href="http://www.flickr.com/photos/patdavid">From avhell's photostream on Flickr</a></p> 
            </div> 
        </div> 
        <!-- The JavaScript --> 
        
        <script type="text/javascript" src="/js/index.js"></script>
		<script type="text/javascript" src="/js/jquery.bgpos.js"></script>

        <!--
        	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script> 
        	<script type="text/javascript" src="jquery.bgpos.js"></script>
         --> 
        <script type="text/javascript"> 
            $(function() {
                /* position of the <li> that is currently shown */
                var current = 0;
				
				var loaded  = 0;
				for(var i = 1; i <4; ++i)
					$('<img />').load(function(){
						++loaded;
						if(loaded == 3){
							$('#bg1,#bg2,#bg3').mouseover(function(e){
								
								var $this = $(this);
								/* if we hover the current one, then don't do anything */
								if($this.parent().index() == current)
									return;
 
								/* item is bg1 or bg2 or bg3, depending where we are hovering */
								var item = e.target.id;
 
								/*
								this is the sub menu overlay. Let's hide the current one
								if we hover the first <li> or if we come from the last one,
								then the overlay should move left -> right,
								otherwise right->left
								 */
								if(item == 'bg1' || current == 2)
									$('#menu .sub'+parseInt(current+1)).stop().animate({backgroundPosition:"(-266px 0)"},300,function(){
										$(this).find('li').hide();
									});
								else
									$('#menu .sub'+parseInt(current+1)).stop().animate({backgroundPosition:"(266px 0)"},300,function(){
										$(this).find('li').hide();
									});
 
								if(item == 'bg1' || current == 2){
									/* if we hover the first <li> or if we come from the last one, then the images should move left -> right */
									$('#menu > li').animate({backgroundPosition:"(-800px 0)"},0).removeClass('bg1 bg2 bg3').addClass(item);
									move(1,item);
								}
								else{
									/* if we hover the first <li> or if we come from the last one, then the images should move right -> left */
									$('#menu > li').animate({backgroundPosition:"(800px 0)"},0).removeClass('bg1 bg2 bg3').addClass(item);
									move(0,item);
								}
 
								/*
								We want that if we go from the first one to the last one (without hovering the middle one),
								or from the last one to the first one, the middle menu's overlay should also slide, either
								from left to right or right to left.
								 */
								if(current == 2 && item == 'bg1'){
									$('#menu .sub'+parseInt(current)).stop().animate({backgroundPosition:"(-266px 0)"},300);
								}
								if(current == 0 && item == 'bg3'){
									$('#menu .sub'+parseInt(current+2)).stop().animate({backgroundPosition:"(266px 0)"},300);
								}
 
								
								/* change the current element */
								current = $this.parent().index();
								
								/* let's make the overlay of the current one appear */
							   
								$('#menu .sub'+parseInt(current+1)).stop().animate({backgroundPosition:"(0 0)"},300,function(){
									$(this).find('li').fadeIn();
								});
							});
						}	
					}).attr('src', 'images/'+i+'.jpg');
				
							
                /*
                dir:1 - move left->right
                dir:0 - move right->left
                 */
                function move(dir,item){
                    if(dir){
                        $('#bg1').parent().stop().animate({backgroundPosition:"(0 0)"},200);
                        $('#bg2').parent().stop().animate({backgroundPosition:"(-266px 0)"},300);
                        $('#bg3').parent().stop().animate({backgroundPosition:"(-532px 0)"},400,function(){
                            $('#menuWrapper').removeClass('bg1 bg2 bg3').addClass(item);
                        });
                    }
                    else{
                        $('#bg1').parent().stop().animate({backgroundPosition:"(0 0)"},400,function(){
                            $('#menuWrapper').removeClass('bg1 bg2 bg3').addClass(item);
                        });
                        $('#bg2').parent().stop().animate({backgroundPosition:"(-266px 0)"},300);
                        $('#bg3').parent().stop().animate({backgroundPosition:"(-532px 0)"},200);
                    }
                }
            });
        </script> 
    </body> 
</html>
{/literal}