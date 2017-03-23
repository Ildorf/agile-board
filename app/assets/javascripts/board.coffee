ready = ->
  jQuery ->
    return unless window.location.pathname.startsWith('/boards/')

    board_id = document.getElementById('board-area').dataset.boardId
    $.getJSON '/api/boards/' + board_id + '/cards', (cards) ->
      $.each cards, (i) ->
        $(".cards-area##{cards[i]['status']}").append(JST["templates/card"]({card: cards[i]}))
        if cards[i].accessible
          $("select[data-card-id='#{cards[i].id}']").append($("form.new_card #card_doer_id")[0].innerHTML)

    $(document)
      .on 'ajax:success', 'form.edit_card', (e, data, status, xhr) ->
        card = $.parseJSON(xhr.responseText)
        $("#div_card_#{card.id}" ).html(JST["templates/card"]({card: card}))
        e.preventDefault()

      .on 'ajax:error', 'form.edit_card', (e, xhr, status, error) ->
        error = $.parseJSON(xhr.responseText)
        $('.alerts').append(JST["templates/error"]({error: error}))
        e.preventDefault()

      .on 'ajax:success', 'form.new_card', (e, data, status, xhr) ->
        card = $.parseJSON(xhr.responseText)
        $(".cards-area##{card['status']}").append(JST["templates/card"]({card: card}))
        $('.new-card-form').hide()
        $('#add-new-card-link').show()

      .on 'ajax:error', 'form.new_card', (e, xhr, status, error) ->
        error = $.parseJSON(xhr.responseText)
        $('.alerts').append(JST["templates/error"]({error: error}))

      .on 'ajax:success', 'a.delete-card-link', (e, xhr, status, error) ->
        notice = $.parseJSON(xhr.responseText)
        alert xhr.responseText
        $('.alerts').append(JST["templates/error"]({notice: notice}))

      .on 'ajax:error', 'a.delete-card-link', (e, xhr, status, error) ->
        error = $.parseJSON(xhr.responseText)
        alert xhr.responseText
        $('.alerts').append(JST["templates/error"]({error: error}))

      .on 'click', '#add-new-card-link', (e) ->
        $(this).hide()
        $('#new-card-form').show()
        e.preventDefault()

      .on 'click', '#close-card-form', (e) ->
        $('#new-card-form').hide()
        $('#add-new-card-link').show()
        e.preventDefault()

      .on 'click', '.edit-card-link', (ev) ->
        ev.preventDefault()
        card_id = ev.target.dataset.cardId
        $("#card_#{card_id}").hide()
        $("#edit-card-from-#{card_id}").show()

      .on 'click', '.close-edit-card-link', (ev) ->
        ev.preventDefault()
        card_id = ev.target.dataset.cardId
        $("#card_#{card_id}").show()
        $("#edit-card-from-#{card_id}").hide()

      .on "drop", ".cards-area", (ev) ->
        ev.preventDefault()
        data = ev.originalEvent.dataTransfer.getData('text')
        target = ev.originalEvent.target
        while target.className != 'cards-area'
          target = target.parentElement
        target.appendChild document.getElementById(data)

      .on "dragover", ".cards-area", (ev) ->
        ev.originalEvent.preventDefault()

      .on "dragstart", ".card", (ev) ->
        ev.originalEvent.dataTransfer.setData 'text', ev.target.id

$(document).on('turbolinks:load', ready);
