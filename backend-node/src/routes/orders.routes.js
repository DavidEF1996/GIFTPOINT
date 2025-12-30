const express = require('express');
const router = express.Router();

const authMiddleware = require('../middlewares/auth.middleware');
const ordersController = require('../controllers/orders.controller');

router.post('/', authMiddleware, ordersController.createOrder);
router.get('/', authMiddleware, ordersController.getMyOrders);

module.exports = router;
