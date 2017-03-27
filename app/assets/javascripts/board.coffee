ready = ->
  jQuery ->
    return unless window.location.pathname.startsWith('/boards/')

    board_id = document.getElementById('board-area').dataset.boardId
    $.getJSON '/api/boards/' + board_id + '/cards', (cards) ->
      $.each cards, (i) ->
        $(".cards-area##{cards[i]['state']}").append(JST["templates/card"]({card: cards[i]}))
        if cards[i].accessible
          $("select[data-card-id='#{cards[i].id}']").append($("form.new_card #card_doer_id")[0].innerHTML)

    $(document)
      .on 'ajax:success', 'a.vote, a.unvote', (e, data, status, xhr) ->
        card = $.parseJSON(xhr.responseText)
        $("#vote-card-#{card.id}").html(JST["templates/vote_card"]({card: card}))
        e.preventDefault()

      .on 'ajax:error', 'a.vote', (e, xhr, status, error) ->
        alert xhr.responseText
        error = $.parseJSON(xhr.responseText)
        $('.alerts').append(JST["templates/error"]({error: error}))
        e.preventDefault()

      .on 'ajax:success', 'form.new_participation', (e, data, status, xhr) ->
        user = $.parseJSON(xhr.responseText)
        notice = "#{user.email} successfully added as #{user.role}"
        $('#add-user-modal').modal('hide');
        $('select[name="card[doer_id]"]').append("<option value='#{user.id}'>#{user.email}</option>")
        $('.alerts').append(JST["templates/notice"]({notice: notice}))
        e.preventDefault()

      .on 'ajax:error', 'form.new_participation', (e, xhr, status, error) ->
        error = $.parseJSON(xhr.responseText)
        $('.alerts').append(JST["templates/error"]({error: error}))
        e.preventDefault()

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
        $(".cards-area##{card['state']}").append(JST["templates/card"]({card: card}))
        $('.new-card-form').hide()
        $('#add-new-card-link').show()

      .on 'ajax:error', 'form.new_card', (e, xhr, status, error) ->
        error = $.parseJSON(xhr.responseText)
        $('.alerts').append(JST["templates/error"]({error: error}))

      .on 'ajax:success', 'a.delete-card-link', (e, xhr, status, error) ->
        notice = xhr.responseText
        card_id = e.target.dataset.cardId
        $("#div_card_#{card_id}").remove()
        $('.alerts').append(JST["templates/error"]({notice: notice}))

      .on 'ajax:error', 'a.delete-card-link', (e, xhr, status, error) ->
        error = xhr.responseText
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
        card_id = ev.originalEvent.dataTransfer.getData('card_id')
        card = ev.originalEvent.dataTransfer.getData('element_id')
        board_id = document.getElementById('board-area').dataset.boardId
        to_state = ev.currentTarget.id
        $.ajax "/api/boards/#{board_id}/cards/#{card_id}/move?to_state=#{to_state}",
          type: 'PATCH'
          dataType: 'text'
          error: (xhr, status, error) ->
            error = xhr.responseText
            $('.alerts').append(JST["templates/error"]({error: error}))
          success: (xhr, status, error) ->
            target = ev.originalEvent.toElement
            while target.className != 'cards-area'
              target = target.parentElement
            target.append document.getElementById(card)


      .on "dragover", ".cards-area", (ev) ->
        ev.originalEvent.preventDefault()

      .on "dragstart", ".card_box", (ev) ->
        ev.originalEvent.dataTransfer.setData 'element_id', ev.target.id
        ev.originalEvent.dataTransfer.setData 'card_id', ev.target.dataset.cardId

$(document).on('turbolinks:load', ready);
