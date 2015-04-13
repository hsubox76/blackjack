class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h3><span class="<% if(isDealer){ %>dealer<% }else{ %>player<% } %>-name"><% if(isDealer){ %>Dealer<% }else{ %>You<% } %></span> (<span class="score"></span>)</h3>'

  lastHandSize: 0

  initialize: ->
    @collection.on 'add remove change', => 
      if @collection.length > @lastHandSize
        @render() 
        @lastHandSize = @collection.length
        @trigger('rendered') 
      
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    if @collection.scores()[1] > 21
      @$('.score').text @collection.scores()[0]
    else
      @$('.score').text @collection.scores()[1]


