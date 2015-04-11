class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()

    @dealerHandView.on 'rendered', => 
      if @model.get 'winner'
        alert "#{@model.get 'winner'} is the winner!"

    @playerHandView.on 'rendered', => 
      if @model.get 'winner'
        alert "#{@model.get 'winner'} is the winner!"

  render: ->
    @$el.children().detach()
    @$el.html @template()

    @playerHandView = new HandView(collection: @model.get 'playerHand')
    @dealerHandView = new HandView(collection: @model.get 'dealerHand')

    @$('.player-hand-container').html @playerHandView.el
    @$('.dealer-hand-container').html @dealerHandView.el

