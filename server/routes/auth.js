const express = require("express");
const User = require("../models/user");
const bycriptjs = require("bcryptjs");
const jwt = require('jsonwebtoken');
const auth = require("../middlewear/auth");
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ name });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
    const hashedPassword = await bycriptjs.hash(password, 8);
    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/api/signin",async (req,res)=>{
  try{
    const {email,password} = req.body;
    const user = await User.findOne({email});
    if(!user){
      return res.status(400).json({msg:'User with this email doesn\'t exist'});
    }
    const isMatch = await bycriptjs.compare(password,user.password);
    if(!isMatch){
      return res.status(400).json({msg:'Incorrect Password'});
    }
    const token = jwt.sign({id:user._id},"passwordKey");
    res.json({token,...user._doc});
  }catch(e){
    res.status(500).json({ error: e.message });
  }
});
authRouter.post("/tokenIsValid",async (req,res)=>{
  try{
    const token = req.header('x-auth-token');
    if(!token) return res.json(false);
    const verified = jwt.verify(token,'passwordKey');
    if(!verified) return res.json(false);
    const user = await User.findById(verified.id);
    if(!user) return res.json(false);
    console.log(token );
    res.json(true);
  }catch(e){
    res.status(500).json({ error: e.message });
  }
});
authRouter.get('/',auth ,async(req,res) =>{
  const user = await User.findById(req.user);
  res.json({...user._doc,token:req.token});
});
module.exports = authRouter;