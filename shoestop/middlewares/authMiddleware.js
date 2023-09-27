const jwt = require('jsonwebtoken')
const asyncHandler = require("express-async-handler")


const authenticationMiddleware = asyncHandler(  async (req, res, next) => {
    const authHeader = req.headers.authorization
  
    if (!authHeader) {
      throw new UnauthenticatedError('No token provided')
    }
  
    const token = authHeader.split(' ')[1]
    // console.log(token);
  
    try {
      const decoded =  jwt.verify(token, process.env.JWT_SECRET)
      
      req.user = decoded
      console.log(req.user);
      next()
    } catch (error) {
      throw new UnauthenticatedError('Not authorized to access this route')
    }
  } )

module.exports = authenticationMiddleware