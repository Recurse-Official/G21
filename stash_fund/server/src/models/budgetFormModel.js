// models/budgetFormModel.js
const mongoose = require('mongoose');

const BudgetFormSchema = new mongoose.Schema({
  userId: { type: String, required: true, ref: 'User' }, // Reference to the User model
  gender: { type: String, required: true },
  savingGoal: { type: String, required: true },
  regularExpenses: { type: [String], default: [] },
  unexpectedExpenses: { type: [String], default: [] },
  dailyTravelExpenses: { type: Number, required: true },
  weeklyCoffeeExpenses: { type: Number, required: true },
  foodHabits: { type: String, required: true },
  currentBill: { type: Number },
  weight: { type: Number },
  height: { type: Number },
  age: { type: Number },
  financialFeelings: { type: String },
  spendingOnOthers: { type: String },
  livingConditions: { type: String },
  hasDebts: { type: String },
  stressFreeBudgetItems: { type: String },
}, { timestamps: true });

module.exports = mongoose.model('BudgetForm', BudgetFormSchema);
