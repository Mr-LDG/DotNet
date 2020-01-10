//'use strict';
/**
 * // ||||||||||||||||||||||||||||||| \\ // Global Object $: Generic controls //
 * ||||||||||||||||||||||||||||||| \\
 */
(function () {
    // http://stackoverflow.com/questions/4083351/what-does-jquery-fn-mean
    var $ = function (elem) {
        if (!(this instanceof $)) {
            return new $(elem);
        }
    	this.el = document.getElementById(elem);
    };
    window.$ = $;
    $.prototype = {
        onChange: function (callback) {
            this.el.addEventListener('change', callback);
            return this;
        }
    };
})();
/**
 * // ||||||||||||||||||||||||||||||| \\ // Drag and Drop code for Upload //
 * ||||||||||||||||||||||||||||||| \\
 */
var dragdrop = {
    init: function (elem) {
        if(elem != null) {
	    	elem.setAttribute('ondrop', 'dragdrop.drop(event)');
	        elem.setAttribute('ondragover', 'dragdrop.drag(event)');
        }
    },
    drop: function (e) {
        e.preventDefault();
        var file = e.dataTransfer.files[0];

        runUpload(file);
    },
    drag: function (e) {
        e.preventDefault();
        
    }
};

/**
 * // ||||||||||||||||||||||||||||||| \\ // Code to capture a file (image) //
 * and upload it to the browser // ||||||||||||||||||||||||||||||| \\
 */
var user11 = document.getElementById('userActions11');
var user1 = document.getElementById('userActions1');
var user2 = document.getElementById('userActions2');
var user3 = document.getElementById('userActions3');
var user4 = document.getElementById('userActions4');
var user5 = document.getElementById('userActions5');
var user6 = document.getElementById('userActions6');
var user7 = document.getElementById('userActions7');
var user8 = document.getElementById('userActions8');
var user9 = document.getElementById('userActions9');
var user10 = document.getElementById('userActions10');

function runUpload(file) {
    // http://stackoverflow.com/questions/12570834/how-to-preview-image-get-file-size-image-height-and-width-before-upload
    if (file.type === 'image/png' ||
        file.type === 'image/jpg' ||
        file.type === 'image/jpeg' ||
        file.type === 'image/gif' ||
        file.type === 'image/bmp') {
        var reader = new FileReader(),
            image = new Image();
        reader.readAsDataURL(file);

        reader.onload = function (_file) {
        	if (user1.className == 'dad hovered') {
                $('img1').el.src = _file.target.result;
                $('img1').el.style.display = 'inline';
            } 
            else if (user2.className == 'dad hovered') {
                $('img2').el.src = _file.target.result;
                $('img2').el.style.display = 'inline';
            } 
            else if (user3.className == 'dad hovered') {
                $('img3').el.src = _file.target.result;
                $('img3').el.style.display = 'inline';
            }
            else  if (user4.className == 'dad hovered') {
                $('img4').el.src = _file.target.result;
                $('img4').el.style.display = 'inline';
            }
            else   if (user5.className == 'dad hovered') {
            	$('img5').el.src = _file.target.result;
            	$('img5').el.style.display = 'inline';
            }
            else  if (user6.className == 'dad hovered') {
            	$('img6').el.src = _file.target.result;
            	$('img6').el.style.display = 'inline';
            }
            else  if (user7.className == 'dad hovered') {
            	$('img7').el.src = _file.target.result;
            	$('img7').el.style.display = 'inline';
            }
            else  if (user8.className == 'dad hovered') {
            	$('img8').el.src = _file.target.result;
            	$('img8').el.style.display = 'inline';
            }
            else  if (user9.className == 'dad hovered') {
            	$('img9').el.src = _file.target.result;
            	$('img9').el.style.display = 'inline';
            }
            else  if (user10.className == 'dad hovered') {
            	$('img10').el.src = _file.target.result;
            	$('img10').el.style.display = 'inline';
            }
            else if (user11.className == 'dad hovered') {
                $('img11').el.src = _file.target.result;
                $('img11').el.style.display = 'inline';
            } 
        	

        } // END reader.onload()
     
// alert("reader.readAsDataURL(file)" + reader.readAsDataURL(file))
// alert("file : " + file)
    } // END test if file.type === image
}

/*
 * 드래그 앤 드롭 부침
 * 
 */
jQuery(document).on("drop", function(e) {
    e.preventDefault();  // allow dropping and don't navigate to file on drop
}).on("drop", function(e) {
	if(user1.className == 'dad hovered'){
		jQuery("input[name=upload1]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user2.className == 'dad hovered'){
		jQuery("input[name=upload2]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user3.className == 'dad hovered'){
		jQuery("input[name=upload3]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user4.className == 'dad hovered'){
		jQuery("input[name=upload4]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user5.className == 'dad hovered'){
		jQuery("input[name=upload5]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user6.className == 'dad hovered'){
		jQuery("input[name=upload6]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user7.className == 'dad hovered'){
		jQuery("input[name=upload7]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user8.className == 'dad hovered'){
		jQuery("input[name=upload8]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user9.className == 'dad hovered'){
		jQuery("input[name=upload9]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	else if(user10.className == 'dad hovered'){
		jQuery("input[name=upload10]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	} 
	else if(user11.className == 'dad hovered'){
		jQuery("input[name=upload11]")
		.prop("files", e.originalEvent.dataTransfer.files)  // put files into
															// element
		.closest("img")
		.submit();  // autosubmit as well
	}
	
	
});

/**
 * // ||||||||||||||||||||||||||||||| \\ // window.onload fun //
 * ||||||||||||||||||||||||||||||| \\
 */
window.onload = function () {
    if (window.FileReader) {
        // Connect the DIV surrounding the file upload to HTML5 drag and drop
		// calls
    	var i = 1;
    	
    	for(var j=0; j < 11; j++) {
    		var actions = "userActions" + i;
        	var upload = "fileUpload" + i;
        	
        	dragdrop.init($(actions).el);
        	//alert($(upload));
        	if($(upload).el != null) {
        		//alert("this");
        		$(upload).onChange(function () { runUpload(this.files[0]); });
        	}
    		
    		i++;
    	}
    	
//    	dragdrop.init($('userActions11').el);
//        dragdrop.init($('userActions1').el);
//        dragdrop.init($('userActions2').el);
//        dragdrop.init($('userActions3').el);
//        dragdrop.init($('userActions4').el);
//        dragdrop.init($('userActions5').el);
//        dragdrop.init($('userActions6').el);
//        dragdrop.init($('userActions7').el);
//        dragdrop.init($('userActions8').el);
//        dragdrop.init($('userActions9').el);
//        dragdrop.init($('userActions10').el);
        
        
        
        // Bind the input[type="file"] to the function runUpload()
        // if (!document.getElementById('fileUpload1').src.value)
//        $('fileUpload11').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload1').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload2').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload3').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload4').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload5').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload6').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload7').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload8').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload9').onChange(function () { runUpload(this.files[0]); });
//        $('fileUpload10').onChange(function () { runUpload(this.files[0]); });

    } else {
        // Report error message if FileReader is unavilable
        var p = document.createElement('p'),
            msg = document.createTextNode('Sorry, your browser does not support FileReader.');
        p.className = 'error';
        p.appendChild(msg);
        $('userActions11').el.innerHTML = '';
        $('userActions11').el.appendChild(p);
        $('userActions1').el.innerHTML = '';
        $('userActions1').el.appendChild(p);
        $('userActions2').el.innerHTML = '';
        $('userActions2').el.appendChild(p);
        $('userActions3').el.innerHTML = '';
        $('userActions3').el.appendChild(p);
        $('userActions4').el.innerHTML = '';
        $('userActions4').el.appendChild(p);
        $('userActions5').el.innerHTML = '';
        $('userActions5').el.appendChild(p);
        $('userActions6').el.innerHTML = '';
        $('userActions6').el.appendChild(p);
        $('userActions7').el.innerHTML = '';
        $('userActions7').el.appendChild(p);
        $('userActions8').el.innerHTML = '';
        $('userActions8').el.appendChild(p);
        $('userActions9').el.innerHTML = '';
        $('userActions9').el.appendChild(p);
        $('userActions10').el.innerHTML = '';
        $('userActions10').el.appendChild(p);
    }
};




var cX;
var sX;
var cY;
var sY;
var msg;
var res;
function checkPosition(event) {
    sX = event.screenX;
    cX = event.clientX;
    cY = event.clientY;
    sY = event.screenY;
    res = document.getElementById("coordi");
    msg = "cX : " + cX + ", cY : " + cY + "sX : " + sX + ", sY : " + sY;
    res.innerHTML = msg;
}
const empties = document.querySelectorAll('.dad');
for (const empty of empties) {
  empty.addEventListener('mouseleave', dragLeave);
  empty.addEventListener('dragover', dragEnter);
  empty.addEventListener('dragleave', dragLeave);
}

function dragEnter(e) {
    e.preventDefault();
    jQuery(this).addClass('hovered');
    console.log("dragEnter");
}

function dragLeave(e) {
    e.preventDefault();
    jQuery('.dad').removeClass('hovered');
    console.log("dragLeave");
}