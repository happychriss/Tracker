var $j = jQuery.noConflict();

  $j(document).ready(function() {
  $j('#example').dataTable( {
      "bFilter": true,
      "bPaginate": false,
      "bInfo": false

  } );
  } );
