const PersonalVault = require('../models/personalVaultModel');

exports.chipIn = async (req, res) => {
  try {
    const { userId, amount } = req.body;
    const vault = await PersonalVault.findOneAndUpdate(
      { userId },
      { $inc: { amount } },
      { new: true, upsert: true }
    );
    res.status(200).json({ success: true, vault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.chipOut = async (req, res) => {
  try {
    const { userId, amount } = req.body;
    const vault = await PersonalVault.findOne({ userId });

    if (!vault || vault.amount < amount) {
      return res.status(400).json({ success: false, message: 'Insufficient funds' });
    }

    vault.amount -= amount;
    await vault.save();
    res.status(200).json({ success: true, vault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.getVaultDetails = async (req, res) => {
  try {
    const { userId } = req.params;
    const vault = await PersonalVault.findOne({ userId });
    if (!vault) {
      return res.status(404).json({ success: false, message: 'Vault not found' });
    }
    res.status(200).json({ success: true, vault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
