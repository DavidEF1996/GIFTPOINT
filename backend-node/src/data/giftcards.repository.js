const giftcards = [
  {
    id: 1,
    brand: 'Amazon',
    amount: 50,
    currency: 'USD',
    available: true,
    logoUrl:'/assets/amazon.png'
  },
  {
    id: 2,
    brand: 'Netflix',
    amount: 25,
    currency: 'USD',
    available: true,
    logoUrl:'/assets/netflix.png'
  },
  {
    id: 3,
    brand: 'Steam',
    amount: 100,
    currency: 'USD',
    available: false,
    logoUrl:'/assets/steam.png'
  }
];

function findAllAvailable() {
  return giftcards.filter(g => g.available);
}

function findById(id) {
  return giftcards.find(g => g.id == id);
}


module.exports = {
  findAllAvailable,
  findById
};
