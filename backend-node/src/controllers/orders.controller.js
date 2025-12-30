const ordersService = require('../services/orders.service');

function createOrder(req, res) {
  const { giftcardId } = req.body;
  console.log("llego al crear orden", req.body)

  if (!giftcardId) {
    return res.status(400).json({
      message: 'Debe seleccionar una giftcard'
    });
  }

  try {
    const order = ordersService.createOrder({
      userId: req.user.sub,
      giftcardId
    });
console.log("llego al crear orden", req.user.sub)
    res.status(201).json({
      orderId: order.id,
      status: order.status
    });
  } catch (error) {
    if (error.message === 'NO SE ENCONTRO GIFTCARD') {
      return res.status(404).json({ message: 'NO SE ENCONTRO GIFTCARD' });
    }

    if (error.message === 'NO ESTA EN STOCK GIFTCARD') {
      return res.status(400).json({ message: 'NO ESTA EN STOCK GIFTCARD' });
    }

    res.status(500).json({ message: 'INTENTELO DE NUEVO MAS TARDE' });
    console.log("error", error.message)
  }
}

function getMyOrders(req, res) {
  const userId = req.user.sub;
  const orders = ordersService.getOrdersByUser(userId);
  res.json(orders);
}

module.exports = {
  createOrder,
  getMyOrders
};
