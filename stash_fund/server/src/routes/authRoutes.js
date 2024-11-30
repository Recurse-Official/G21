const express = require("express");
const { signup, login, findUser } = require("../controller/authController");

const router = express.Router();

// Signup Route
router.post("/signup", signup);

// Login Route
router.post("/login", login);

// get route
router.get("/:userId", findUser);

module.exports = router;
