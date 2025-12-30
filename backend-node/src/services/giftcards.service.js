const giftcardsRepository = require('../data/giftcards.repository');

function getAvailableGiftcards() {
  return giftcardsRepository.findAllAvailable();
}

module.exports = {
  getAvailableGiftcards
};
