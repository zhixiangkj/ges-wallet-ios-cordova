const config = require('../config')
const {checkMissingFields} = require('../exception')
module.exports = (stripe) => {
  return async (req, res) => {
    if (missingFiledsMsg = checkMissingFields(req.body, ['source', 'amount', 'currency', 'customerId'])) {
      res.status(500).end(new Error(missingFiledsMsg))
    }
    const { source, amount, currency, customerId } = req.body
    try {
      // Create a charge and set its destination to the pilot's account.
      const charge = await stripe.charges.create({
        source: source,
        amount: amount,
        currency: currency,
        customer: customerId,
        description: config.appName,
        metadata: {
          cellphone: '01010101010'
        }
      })
      res.status(200).json({charge})
    } catch (e) {
      res.status(500).end(e)
    }
  }
}