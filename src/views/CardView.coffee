class window.CardView extends Backbone.View
  className: 'card'



  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    #@$el.html @template @model.attributes
    rank = (@model.get 'rankName').toString().toLowerCase();
    suit = (@model.get 'suitName').toLowerCase();
    @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.css("background-image", "url('./img/cards/#{rank}-#{suit}.png')") if @model.get 'revealed'
    console.log("rendered #{rank} and #{suit}")

