<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <style>
    
        ul {
            list-style-type: none;
        }

        #css3dimagePager {
            text-align: center;
            position: relative;
            z-index: 11;
            padding: 0 0 10px;
            margin: 0;
        }

		#css3dimagePager li {
			padding-right: 2em;
			display: inline-block;
			cursor: pointer;
		}

        #css3dimageslider {
            -webkit-perspective: 1000;
            -moz-perspective: 1000px;
            -ms-perspective: 1000;
            perspective: 1000;
            -webkit-perspective-origin: 50% 100px;
            -moz-perspective-origin: 50% 100px;
            -ms-perspective-origin: 50% 100px;
            perspective-origin: 50% 100px;
            margin: 40px auto 20px auto;
            width: 100%;
            height: 350px;
        }

		#css3dimageslider ul {
			position: relative;
			margin: 0 auto;
			height: 281px;
			width: 450px;
			-webkit-transform-style: preserve-3d;
			-moz-transform-style: preserve-3d;
			-ms-transform-style: preserve-3d;
			transform-style: preserve-3d;
			-webkit-transform-origin: 50% 100px 0;
			-moz-transform-origin: 50% 100px 0;
			-ms-transform-origin: 50% 100px 0;
			transform-origin: 50% 100px 0;
			-webkit-transition: all 1.0s ease-in-out;
			-moz-transition: all 1.0s ease-in-out;
			-ms-transition: all 1.0s ease-in-out;
			transition: all 1.0s ease-in-out;
		}

		#css3dimageslider ul li {
			position: absolute;
			height: 281px;
			width: 450px;
			padding: 0px;
		}

		#css3dimageslider ul li:nth-child(1) {
			-webkit-transform: translateZ(225px);
			-moz-transform: translateZ(225px);
			-ms-transform: translateZ(225px);
			transform: translateZ(225px);
		}

		#css3dimageslider ul li:nth-child(2) {
			-webkit-transform: rotateY(90deg) translateZ(225px);
			-moz-transform: rotateY(90deg) translateZ(225px);
			-ms-transform: rotateY(90deg) translateZ(225px);
			transform: rotateY(90deg) translateZ(225px);
		}

		#css3dimageslider ul li:nth-child(3) {
			-webkit-transform: rotateY(180deg) translateZ(225px);
			-moz-transform: rotateY(180deg) translateZ(225px);
			-ms-transform: rotateY(180deg) translateZ(225px);
			transform: rotateY(180deg) translateZ(225px);
		}

		#css3dimageslider ul li:nth-child(4) {
			-webkit-transform: rotateY(-90deg) translateZ(225px);
			-moz-transform: rotateY(-90deg) translateZ(225px);
			-ms-transform: rotateY(-90deg) translateZ(225px);
			transform: rotateY(-90deg) translateZ(225px);
		}
		
		#css3dimageslider ul li img{
			width: 100%;
		}
		
    </style>
</head>
<body>
    <div id="css3dimageslider">
        <ul>
            <li><img src="img/airdior_right.png" /></li>
            <li><img src="img/airdior_front.png" /></li>
            <li><img src="img/airdior_left.png" /></li>
            <li><img src="img/airdior_back.png" /></li>
        </ul>
    </div>
    <ul id="css3dimagePager">
        <li class="active">Image 1</li>
        <li>Image 2</li>
        <li>Image 3</li>
        <li>Image 4</li>
    </ul>

    <script src="https://code.jquery.com/jquery-3.5.1.js"
			integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" 
			crossorigin="anonymous">
    </script>
    <script>
        $(document).ready(function () {
            $("#css3dimagePager li").click(function () {
                var rotateY = ($(this).index() * -90);
                $("#css3dimageslider ul").css({ "-webkit-transform": "rotateY(" + rotateY + "deg)", "-moz-transform": "rotateY(" + rotateY + "deg)", "-ms-transform": "rotateY(" + rotateY + "deg)", "transform": "rotateY(" + rotateY + "deg)" });
                $("#css3dimagePager li").removeClass("active");
                $(this).addClass("active");
            });
            
        });
    </script>
</body>
</html>
