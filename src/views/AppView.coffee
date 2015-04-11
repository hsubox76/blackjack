class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  showResult: -> 
    if (@model.get 'winner') == 'dealer'
      $('.dealer-name').text('Dealer Wins')

    if (@model.get 'winner') == 'player'
      $('.player-name').text('You Win')

    if (@model.get 'winner') == 'push'
      $('.dealer-name').text('Dealer Push')
      $('.player-name').text('You Push')
      



  initialize: ->
    @render()

    @dealerHandView.on 'rendered', => 
      if @model.get 'winner'
        console.log("triggered by dealer hit #{@model.get 'winner'} is the winner!")
        @showResult()

    @playerHandView.on 'rendered', => 
      if @model.get 'winner'
        console.log("triggered by playerhit #{@model.get 'winner'} is the winner!")
        @showResult()

    @model.on 'dealerStand', =>
      if @model.get 'winner'
        console.log("triggered by dealerstand #{@model.get 'winner'} is the winner!")
        @showResult()


  render: ->
    @$el.children().detach()
    @$el.html @template()

    @playerHandView = new HandView(collection: @model.get 'playerHand')
    @dealerHandView = new HandView(collection: @model.get 'dealerHand')

    @$('.player-hand-container').html @playerHandView.el
    @$('.dealer-hand-container').html @dealerHandView.el

