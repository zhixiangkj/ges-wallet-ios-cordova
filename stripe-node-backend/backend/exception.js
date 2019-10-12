// 检测必须接受的字段是否缺失
const checkMissingFields = (body, checkFields) => {
  let str = ''
  checkFields.forEach((key) => {
    if(!body[key]) {
      if(!str) {
        str += key
      } else {
        str += ', ' + key
      }
    }
  })
  if (!str) {
    return
  }
  return `Field ${str} is missing`
}
module.exports = {checkMissingFields}