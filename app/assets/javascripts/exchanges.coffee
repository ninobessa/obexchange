$(document).ready ->
  $('form').submit ->
    if $('form').attr('action') == '/convert'
      $('.result img').show();
      $.ajax '/convert',
          type: 'GET'
          dataType: 'json'
          data: {
                  source_currency: $("#source_currency").val(),
                  target_currency: $("#target_currency").val(),
                  amount: $("#amount").val()
                }
          error: (jqXHR, textStatus, errorThrown) ->
            alert textStatus
            $('.result img').show();
          success: (data, text, jqXHR) ->
            $('#result').val(data.value.toLocaleString('pt-br',{style: 'currency', minimumFractionDigits: 2, currency: $("#target_currency").val()}););
            $('.result img').hide();
        return false;
  
  $('form').on 'change', 'select', ->
    current_text =  $(this).children("option:selected").text();
    current_id   = $(this).attr("id");
    $('#subtitle_'+current_id).fadeOut 500, ->
      $(this).text(current_text).fadeIn 500
    if $('#amount').val() != ''
      $('#exchange_form').submit();
    else
      $('#result').val('');

  $('#exchange_form').on 'keyup', '#amount', ->
    if $('#amount').val() != ''
      $('#exchange_form').submit();
    else
      $('#result').val('');
  
  $('.invert').on 'click', (e) ->
    e.preventDefault();
    source_currency = $("#source_currency").val()
    target_currency = $("#target_currency").val()
    
    $("#source_currency").val(target_currency);
    $("#target_currency").val(source_currency);
    
    $('#subtitle_source_currency').fadeOut 500, ->
      $(this).text($("#source_currency").children("option:selected").text()).fadeIn 500
    $('#subtitle_target_currency').fadeOut 500, ->
      $(this).text($("#target_currency").children("option:selected").text()).fadeIn 500
    
    $('#exchange_form').submit();


    
