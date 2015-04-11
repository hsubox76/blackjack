# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'add change', => @checkPlayerScore()
    (@get 'playerHand').on 'stand', =>
      (@get 'dealerHand').at(0).flip()
      @dealerMove()
    (@get 'dealerHand').on 'add', => @dealerMove()

  dealerMove: ->
    console.log('dealerMove called');
    dealerScoreMin = (@get 'dealerHand').scores()[0]
    console.log('dealerscoreMin: ' + dealerScoreMin);

    if dealerScoreMin > 21
      @set 'winner', 'player' 
      return

    if @currentWinner() == 'dealer'
      @set 'winner', 'dealer'
      return
      #end the game, dealer wins
      
    if dealerScoreMin <= 17
      (@get 'dealerHand').hit()



  checkPlayerScore: ->
    console.log('checkPlayerScore called');

    playerScoreMin = (@get 'playerHand').scores()[0]

    if playerScoreMin > 21
      @set 'winner', 'dealer'
      return 


  currentWinner: ->
    console.log('currentWinner called');

    dealerScoreMin = (@get 'dealerHand').scores()[0]
    dealerScoreMax = (@get 'dealerHand').scores()[1]
    playerScoreMin = (@get 'playerHand').scores()[0]
    playerScoreMax = (@get 'playerHand').scores()[1]

    if dealerScoreMax <= 21
      dealerScore = dealerScoreMax
    else
      dealerScore = dealerScoreMin

    if playerScoreMax <= 21
      playerScore = playerScoreMax
    else
      playerScore = playerScoreMin

    return 'dealer' if dealerScore > playerScore
    return 'player' if playerScore < dealerScore
    return 'push' if playerScore == dealerScore





