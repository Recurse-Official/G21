const GroupVault = require('../models/groupVaultModel');
const PersonalVault = require('../models/personalVaultModel');
const mongoose = require('mongoose');

exports.chipIn = async (req, res) => {
  try {
    const { groupId, userId, amount, source } = req.body;
    if (source === 'personal_vault') {
      const personalVault = await PersonalVault.findOne({ userId });
      
      if (!personalVault || personalVault.amount < amount) {
        return res.status(400).json({ success: false, message: 'Insufficient personal funds' });
      }

      personalVault.amount -= amount;
      await personalVault.save();
    }
    // const groupVault = await GroupVault.findOneAndUpdate(
    //   { groupVaultId: groupId },
    //   { 
    //     $inc: { totalAmount: amount },
    //     $push: { contributions: { user: userId, contribution: amount } }
    //   },
    //   { new: true }
    // );

    // res.status(200).json({ success: true, groupVault });
    const groupVault = await GroupVault.findOne({ groupVaultId: groupId });

    if (!groupVault) {
      return res.status(404).json({ success: false, message: 'Group vault not found' });
    }

    // Check if the user already exists in contributions
    if (groupVault.contributions.has(userId)) {
      // Increment the user's existing contribution
      groupVault.contributions.set(userId, groupVault.contributions.get(userId) + amount);
    } else {
      // Add a new user with the initial contribution
      groupVault.contributions.set(userId, amount);
    }

    // Save the updated group vault
    groupVault.totalAmount += amount;
    await groupVault.save();

    res.status(200).json({
      success: true,
      message: 'Contribution updated successfully',
      contributions: groupVault.contributions,
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.chipOut = async (req, res) => {
  try {
    const { groupId, userId, amount } = req.body;

    // Find the group vault
    const groupVault = await GroupVault.findOne({ groupVaultId: groupId });

    if (!groupVault) {
      return res.status(404).json({ success: false, message: 'Group vault not found' });
    }

    if (groupVault.totalAmount < amount) {
      return res.status(400).json({ success: false, message: 'Insufficient group funds' });
    }

    // Deduct the chipOut amount from the group vault
    groupVault.totalAmount -= amount;

    // If the user exists in contributions, decrement their contribution
    if (groupVault.contributions.has(userId)) {
      const userContribution = groupVault.contributions.get(userId);
      if (userContribution < amount) {
        return res
          .status(400)
          .json({ success: false, message: 'User has insufficient contribution in the vault' });
      }
      groupVault.contributions.set(userId, userContribution - amount);

    } else {
      return res.status(400).json({
        success: false,
        message: 'User does not have any contributions in this vault',
      });
    }

    // Save the updated group vault
    await groupVault.save();

    // Update user's personal vault
    const personalVault = await PersonalVault.findOneAndUpdate(
      { userId },
      { $inc: { amount } },
      { new: true, upsert: true } // Create if not exists
    );

    res.status(200).json({
      success: true,
      message: 'Chip out successful',
      groupVault,
      personalVault,
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.createGroupVault = async (req, res) => {
  try {
    const { name, purpose } = req.body;
    // const groupVault = await GroupVault.create({ name, purpose });
     // Generate a new ObjectId
     const objectId = new mongoose.Types.ObjectId();

     // Create the group vault with groupVaultID as string
     const groupVault = await GroupVault.create({
       groupVaultId: objectId.toString(),
       name,
       purpose,
     });
    res.status(201).json({ success: true, groupVault });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

// exports.getGroupVaultDetails = async (req, res) => {
//   try {
//     const { groupId } = req.params;
//     const groupVault = await GroupVault.findOne({ groupVaultId: groupId });
//     if (!groupVault) {
//       return res.status(404).json({ success: false, message: 'Group vault not found' });
//     }
//     res.status(200).json({ success: true, groupVault });
//   } catch (error) {
//     res.status(500).json({ success: false, error: error.message });
//   }
// };

exports.getGroupVaultDetails = async (req, res) => {
  try {
    const { groupId } = req.params;

    // Find the group vault
    const groupVault = await GroupVault.findOne({ groupVaultId: groupId });

    if (!groupVault) {
      return res.status(404).json({ success: false, message: 'Group vault not found' });
    }

    // Format contributions to a plain object for JSON response
    const contributions = Object.fromEntries(groupVault.contributions);

    res.status(200).json({
      success: true,
      groupVault: {
        groupVaultId: groupVault.groupVaultId,
        name: groupVault.name,
        purpose: groupVault.purpose,
        totalAmount: groupVault.totalAmount,  
        contributions,
      },
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
