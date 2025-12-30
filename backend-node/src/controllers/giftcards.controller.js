const giftcardsService = require('../services/giftcards.service');

function getGiftcards(req, res) {
  const giftcards = giftcardsService.getAvailableGiftcards();
  res.json(giftcards);
}

module.exports = {
  getGiftcards
};
