const orders = [];
let nextId = 1;

function save(order) {
  const newOrder = {
    id: nextId++,
    ...order
  };
  orders.push(newOrder);
  return newOrder;
}

function findAll() {
  return orders;
}

function findByUserId(userId) {
  return orders.filter(order => order.userId === userId);
}


module.exports = {
  save,
  findAll,
  findByUserId
};
