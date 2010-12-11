
jQuery.fn.log = function(msg){
    console.log("%s: %o", msg, this);
   return this;
};
/**
 * @author development
 */
function is_numeric(input){
    return !isNaN(input);
}

function addChangeHandler(){
    var i = 0;

	var validation_ok = true;

    var remaining_hours = 0;

	$("*").find("#workhours input").each(function(){
        if (validation_ok)
            if (is_numeric($(this).val())) {
                i = i + Number($(this).val());
				$(this).css({"background-color": "white"})
            }
            else {
                $(this).css({"background-color": "red"})
                $("#eac_hours").html("---");
                validation_ok = false
           }
    });

/**
 Find read-only workhours for addition as well
 */

    if (validation_ok) {
 		$("*").find("#show_workhours").each(function() {
			i = i + Number($(this).html());
		});

        remaining_hours=Number($("#pert_eac_hours").html())-i;

        $("#hours_submit").val(String(i));

        $("#eac_hours").html(String(i));

        $("#remaining_hours").html(String(remaining_hours));

        if (remaining_hours == 0) {
             $("#remaining_hours").css({"background-color": "green"})
        }
        else {
             $("#remaining_hours").css({"background-color": "red"})
        }

    }

}

$(document).ready(function(){
    $("*").find("#workhours input").change(addChangeHandler)
    $("#estimation_submit").click(addChangeHandler)

});
