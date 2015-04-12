class window.AppView extends Backbone.View
  template: _.template '
    <div class="game-container"> 
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    </div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-again-button': ->
        @model.reset()
        @reset()

  showPlayAgainButton: ->
    $('.stand-button').after('<button class="play-again-button">Play Again</button>')
    $('.stand-button').remove()
    $('.hit-button').remove()

  showResult: -> 
    if (@model.get 'winner') == 'dealer'
      $('.dealer-name').text('Dealer Wins')

    if (@model.get 'winner') == 'player'
      $('.player-name').text('You Win')

    if (@model.get 'winner') == 'push'
      $('.dealer-name').text('Dealer Push')
      $('.player-name').text('You Push')

    @showPlayAgainButton()


  initialize: ->
    @reset()

    @model.on 'dealerStand', =>
      if @model.get 'winner'
        @showResult()

  reset: ->
    @render()

    @dealerHandView.on 'rendered', => 
      if @model.get 'winner'
        @showResult()

    @playerHandView.on 'rendered', => 
      if @model.get 'winner'
        @showResult()


  render: ->
    @$el.children().detach()
    @$el.html @template()

    @playerHandView = new HandView(collection: @model.get 'playerHand')
    @dealerHandView = new HandView(collection: @model.get 'dealerHand')

    @$('.player-hand-container').html @playerHandView.el
    @$('.dealer-hand-container').html @dealerHandView.el

