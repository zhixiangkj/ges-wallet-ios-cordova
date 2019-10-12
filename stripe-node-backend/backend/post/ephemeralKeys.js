/**
 * Created by fjl on 2018/11/23
 */
const {checkMissingFields} = require('../exception')
module.exports = (stripe) => {
  const createSource = (email) => {
    return new Promise((resolve, reject) => {
      stripe.sources.create({
        type: 'ach_credit_transfer',
        currency: 'usd',
        owner: {email: email}
      }, function(err, source) {
        console.log(source)
        if (!err) {
          resolve(source)
        } else {
          reject(err)
        }
      })
    })
  }
  const createCustomer = (options = {}) => {
    return new Promise((resolve, reject) => {
      stripe.customers.create(options, function(err, customer) {
        if(err){
          reject(err)
        } else{
          resolve(customer)
        }
      })
    })
  }
  return async (req, res) => {
    if (missingFiledsMsg = checkMissingFields(req.body, ['apiVersion'])) {
      res.status(500).end(new Error(missingFiledsMsg))
    }
    const {apiVersion, customerId} = req.body
    if(!customerId) {
      try {
        // const source = await createSource('738623786@qq.com')
        const customer = await createCustomer({description: 'the developer`s account'})
        const key = await stripe.ephemeralKeys.create({customer: customer.id},{stripe_version: apiVersion})
        res.status(200).json({key, customerId: customer.id})
      } catch (e) {
        res.status(500).end(e)
      }
    } else {
      try {
        const key = await stripe.ephemeralKeys.create({customer: customerId},{stripe_version: apiVersion})
        res.status(200).json({key})
      } catch (e) {
        res.status(500).end(e)
      }
    }
  }
}
