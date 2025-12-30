const giftcardsRepository = require('../data/giftcards.repository');
const ordersRepository = require('../data/orders.repository');

function createOrder({ userId, giftcardId }) {
  const giftcard = giftcardsRepository.findById(giftcardId);

  console.log("llegando",giftcardId)
  if (!giftcard) {
    throw new Error('NO SE ENCONTRO GIFTCARD');
  }

  if (!giftcard.available) {
    throw new Error('NO ESTA EN STOCK GIFTCARD');
  }
  console.log("llegando2")
  const order = ordersRepository.save({
    userId,
    giftcardId,
    amount: giftcard.amount,
    currency: giftcard.currency,
    status: 'CREATED',
    createdAt: new Date().toISOString()
  });

  return order;
}

function getOrdersByUser(userId) {
  const orders = ordersRepository.findByUserId(userId);

  return orders.map(order => {
    const giftcard = giftcardsRepository.findById(order.giftcardId);

    return {
      id: order.id,
      status: order.status,
      createdAt: order.createdAt,

      giftcard: {
        id: giftcard.id,
        brand: giftcard.brand,
        amount: giftcard.amount,
        currency: giftcard.currency,
        logoUrl: giftcard.logoUrl
      }
    };
  });
}

module.exports = {
  createOrder,
  getOrdersByUser
};
