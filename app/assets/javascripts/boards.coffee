ready = ->
  jQuery ->
    return unless window.location.pathname.startsWith('/boards/')


    $.getJSON '/api/'+window.location.pathname + '/cards', (cards) ->
      console.log cards
      $.each cards, (i) ->
        $(".cards-area##{cards[i]['status']}").append(JST["templates/card"]({card: cards[i]}))

  # "drop", "#idea, #to-do, #in-progress, #on-review, #commited, #done"

  .on "drop", ".cards-area", (ev) ->
    ev.preventDefault()
    data = ev.originalEvent.dataTransfer.getData('text')
    target = ev.originalEvent.target
    if target.className == 'cards-area'
      target.appendChild document.getElementById(data)
    else
      target.parentElement.appendChild document.getElementById(data)
    return

  .on "dragover", ".cards-area", (ev) ->
    ev.originalEvent.preventDefault()
    return

  .on "dragstart", ".card", (ev) ->
    ev.originalEvent.dataTransfer.setData 'text', ev.target.id
    return


$(document).on('turbolinks:load', ready);
