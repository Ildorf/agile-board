ready = ->
  jQuery ->
    return unless window.location.pathname == '/'

    $.getJSON '/api/boards', (boards) ->
      $.each boards, (i) ->
        $(".boards-list").append(JST["templates/board"]({board: boards[i]}))

    $(document)
      .on 'ajax:success', 'form.new_board', (e, data, status, xhr) ->
        board = $.parseJSON(xhr.responseText)
        $(".boards-list").append(JST["templates/board"]({board: board}))
        $('div.board-form').hide()
        $('#new-board-link').show()

      .on 'ajax:error', 'form.new_board', (e, xhr, status, error) ->
        error = $.parseJSON(xhr.responseText)
        $('.alerts').append(JST["templates/error"]({error: error}))

      .on 'ajax:success', 'form.edit_board', (e, data, status, xhr) ->
        board = $.parseJSON(xhr.responseText)
        $("#div-board-#{board.id}").replaceWith(JST["templates/board"]({board: board}))


      .on 'ajax:error', 'form.edit_board', (e, xhr, status, error) ->
        error = $.parseJSON(xhr.responseText)
        $('.alerts').append(JST["templates/error"]({error: error}))

      .on 'click', '#new-board-link',  (e) ->
        e.preventDefault()
        $(this).hide()
        $('#new-bord-form').show()

      .on 'click', '#close-board-form', (e) ->
        e.preventDefault()
        $('#new-bord-form').hide()
        $('#new-board-link').show()

      .on 'click', '.edit-baord-link', (e) ->
        e.preventDefault()
        board_id = e.target.dataset.boardId
        $("#board-#{board_id}").hide()
        $("#edit-board-from-#{board_id}").show()

      .on 'click', '.close-edit-board-form', (e) ->
        e.preventDefault()
        board_id = e.target.dataset.boardId
        $("#edit-board-from-#{board_id}").hide()
        $("#board-#{board_id}").show()

$(document).on('turbolinks:load', ready);
